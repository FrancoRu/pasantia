<?php

class Anuario extends Conectar
{
    private function isExist_cuadro($chapter, $subChapter, $quadro, $conectar)
    {
        $sql = "SELECT cuad_id FROM td_cuadro Cu
        INNER JOIN td_subcapitulo S
        ON S.subcap_id = Cu.subcap_id
        INNER JOIN td_capitulo C
        ON C.cap_id = S.cap_id
        WHERE S.subcap_id = ? AND
        C.cap_id = ? AND
        Cu.cuad_id = ?";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $subChapter);
        $stmt->bindValue(2, $chapter);
        $stmt->bindValue(3, $quadro);
        $stmt->execute();
        return $stmt->rowCount() > 0;
    }

    private function getSubIndice($chapter, $subChapter, $quadro, $conectar)
    {
        $sql = "SELECT subindice_titulo FROM td_cuadro Cu
        INNER JOIN td_subcapitulo S
        ON S.subcap_id = ?
        INNER JOIN td_capitulo C
        ON C.cap_id = ?
        WHERE Cu.cuad_id = ?
        ORDER BY subindice_titulo DESC
        LIMIT 1";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $subChapter);
        $stmt->bindValue(2, $chapter);
        $stmt->bindValue(3, $quadro);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result) {
            return $result['subindice_titulo'];
        }
        return false;
    }

    private function insertFile($doc, $chapter, $subChapter, $quadro, $title, $conectar)
    {
        $id = $this->getFileID($chapter, $subChapter, $quadro, $title, $conectar);
        if (!$id) {
            return false;
        }
        $sql = "INSERT INTO td_anuario (file_id, doc_nom) VALUES (?,?)";
        $stmt = $conectar->prepare($sql);
        $stmt->bindParam(1, $id);
        $stmt->bindParam(2, $doc);
        $stmt->execute();
        return $stmt->rowCount() > 0;
    }
    private function getFileID($chapter, $subChapter, $quadro, $title, $conectar, $state = true)
    {

        $sql = "SELECT file_id FROM td_cuadro Cu
        INNER JOIN td_subcapitulo S
        ON S.subcap_id = ?
        INNER JOIN td_capitulo C
        ON C.cap_id = ?
        WHERE Cu.cuad_id = ? AND ";
        if ($state) $sql .= "Cu.desc_titulo = ?";
        else $sql .= "Cu.subindice_titulo = ?";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $subChapter);
        $stmt->bindValue(2, $chapter);
        $stmt->bindValue(3, $quadro);
        $stmt->bindValue(4, $title);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result) {
            return $result['file_id'];
        }
        return false;
    }

    public function insert_cuadro($usu_id, $chapter, $subChapter, $quadro, $title)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $title = preg_replace('/^[0-9.]+/', '', $title);
        $exist = $this->isExist_cuadro($chapter, $subChapter, $quadro, $conectar);
        if ($exist) {
            $subIndice = $this->getSubIndice($chapter, $subChapter, $quadro, $conectar);
            $this->updateTitle($title, $subIndice);

            $sql = "INSERT INTO td_cuadro (cuad_id, subcap_id, usu_id, desc_titulo,subindice_titulo ) VALUES (?,?,?,?,?);";
        } else {
            $sql = "INSERT INTO td_cuadro (cuad_id, subcap_id, usu_id, desc_titulo ) VALUES (?,?,?,?);";
        }
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $quadro);
        $stmt->bindValue(2, $subChapter);
        $stmt->bindValue(3, $usu_id);
        $stmt->bindValue(4, $title);
        if ($exist) {
            $stmt->bindValue(5, $subIndice + 1);
        }
        try {
            $result = $stmt->execute();
            if ($result) {
                if ($exist) $this->updateTitle($_FILES['file']['name'], $subIndice);
                $saveFile = $this->insertFile($_FILES['file']['name'], $chapter, $subChapter, $quadro, $title, $conectar);
                if (!$saveFile) {
                    return false;
                }
            }
            return $this->path_file($chapter, $subChapter, $quadro, $title, $conectar, true);
        } catch (PDOException $e) {
            http_response_code(400);
            echo json_encode(['message' => 'Parametros no validos']);
            return false;
        }
    }

    private function authorized($usu_id, $fileID, $conectar)
    {
        $sql = "SELECT usu_id, file_id FROM td_cuadro WHERE usu_id = ? AND file_id = ?";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $usu_id);
        $stmt->bindValue(2, $fileID);
        $stmt->execute();
        return $stmt->rowCount() > 0;
    }

    public function supportUser($usu_id)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT rol_id FROM tm_usuario WHERE usu_id = ? AND rol_id = 2";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $usu_id);
        $stmt->execute();
        return $stmt->rowCount() > 0;
    }

    public function update_cuadro($usu_id, $chapter, $subChapter, $quadro, $title)
    {
        $conectar = parent::conexion();
        parent::set_names();
        $title = preg_replace('/^[0-9.]+/', '', $title);
        $fileID = $this->getFileID($chapter, $subChapter, $quadro, $title, $conectar, false);
        if (!$fileID) {
            http_response_code(404);
            echo json_encode(['message' => 'Archivo no encontrado']);
            return false;
        }
        $result = $this->authorized($usu_id, $fileID, $conectar);
        if (!$result) {
            http_response_code(403);
            echo json_encode(['message' => 'Usuario no autorizado a modificar el archivo seleccionado']);
            return false;
        }

        $sql = "UPDATE td_anuario 
            SET doc_nom = ?, fech_crea = NOW()
            WHERE file_id = ?";
        $subIndice = $this->getSubIndice($chapter, $subChapter, $quadro, $conectar);
        $this->updateTitle($_FILES['file']['name'], $subIndice);
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $_FILES['file']['name']);
        $stmt->bindValue(2, $fileID);

        $result = $stmt->execute();
        if (!$result) {
            http_response_code(500);
            echo json_encode(['message' => 'Error al subir el archivo']);
            return false;
        }
        return $this->path_file($chapter, $subChapter, $quadro, $title, $conectar, false);
    }


    public function updateTitle(&$title, $index)
    {
        $base = pathinfo($title, PATHINFO_FILENAME);
        $exten = pathinfo($title, PATHINFO_EXTENSION);
        $extenPart = !empty($exten) ? '.' . $exten : '';
        $letra = $this->charindex($index);
        $title = "$base ($letra)$extenPart";
    }

    public function charindex($index)
    {
        $alfabeto = range('a', 'z');

        // Calcular la posición en el alfabeto (cíclicamente)
        $posicion = ($index - 1) % count($alfabeto);

        // Calcular el número de veces que se ha completado el alfabeto
        $vueltasAlfabeto = abs(floor(($index - 1) / count($alfabeto)));

        // Obtener la letra correspondiente en el alfabeto
        $letra = $posicion >= 0 ? $alfabeto[$posicion] : $alfabeto[0];

        // Agregar letras adicionales según las vueltas completas al alfabeto
        $letra .= $vueltasAlfabeto != 0 ? str_repeat($letra, $vueltasAlfabeto) : '';

        return $letra;
    }

    private function path_file($chapter, $subChapter, $quadro, $title, $conectar, $state)
    {
        $sql = "SELECT Cu.subindice_titulo as subindice ,CONCAT('Capitulo ', C.cap_id, ' ',C.cap_descrip, '/Subcapitulo ',S.subcap_value,' ', S.subcap_descrip, '/Cuadro ', Cu.cuad_id) as 'path' 
        , CONCAT(C.cap_id,'.',S.subcap_value,'.', Cu.cuad_id, '-' ) as 'code' FROM td_cuadro Cu
        INNER JOIN td_subcapitulo S
        ON S.subcap_id = ?
        INNER JOIN td_capitulo C
        ON C.cap_id = ?
        WHERE Cu.cuad_id = ?
        AND ";
        if ($state) $sql .= "Cu.desc_titulo = ?";
        else $sql .= "Cu.subindice_titulo = ?";
        error_log($title);
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $subChapter);
        $stmt->bindValue(2, $chapter);
        $stmt->bindValue(3, $quadro);
        $stmt->bindValue(4, $title);
        $stmt->execute();
        $result = $stmt->fetch();
        if (!$result) {
            http_response_code(500);
            echo json_encode(['message' => 'Error al crear la ruta de carga de archivo']);
        }
        return $result;
    }

    public function create_json()
    {
        $conectar = parent::Conexion();
        parent::set_names();
        $data = $this->create_structure_quadro($conectar);
        $this->writeJSON($data);
    }


    private function getData()
    {
        return "SELECT C.cap_id, C.cap_descrip, S.subcap_id, S.subcap_value ,S.subcap_descrip, 
        Cu.cuad_id, Cu.desc_titulo, Cu.subindice_titulo, A.doc_nom, A.fech_crea, CONCAT(U.usu_nom, ' ', U.usu_ape) as 'fullname'
        FROM td_cuadro Cu
        INNER JOIN tm_usuario U ON U.usu_id = Cu.usu_id
        INNER JOIN td_subcapitulo S ON Cu.subcap_id = S.subcap_id
        INNER JOIN td_capitulo C ON C.cap_id = S.cap_id
        INNER JOIN td_anuario A ON A.file_id = Cu.file_id";
    }

    private function create_structure_quadro($conectar)
    {

        $sql = $this->getData() . ' ORDER BY C.cap_id ASC, S.subcap_id ASC, Cu.cuad_id ASC';
        $stmt = $conectar->prepare($sql);
        $result = $stmt->execute();
        if (!$result) {
            return false;
        }
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!is_array($data) && count($data) <= 0) {
            return false;
        }

        $array = [];
        $array['chapter'] = [];
        $lastChapter = null;
        $lastSubchapter = null;
        $lastQuadro = null;
        $indexChapter = -1;

        foreach ($data as $row) {
            $chapter_id = $row['cap_id'];
            $chapter_value = $row['cap_descrip'];

            $subchapter_id = $row['subcap_id'];
            $subchapter_value = $row['subcap_descrip'];

            $quadro_id = $row['cuad_id'];
            $title = $row['desc_titulo'];
            $subIndice = $row['subindice_titulo'];
            if ($lastChapter != $chapter_id) {
                $array['chapter'][] = [
                    'value' => $chapter_id,
                    'description' => $chapter_value,
                    'subchapter' => []
                ];
                $lastChapter = $chapter_id;
                $indexChapter++;
                $lastSubchapter = null;
            }
            if ($lastSubchapter !== $subchapter_id) {
                $array['chapter'][$indexChapter]['subchapter'][] = [
                    'value' => $subchapter_id,
                    'description' => $subchapter_value,
                    'quadro' => []
                ];
                $lastSubchapter = $subchapter_id;
                $indexSubchapter = count($array['chapter'][$indexChapter]['subchapter']) - 1;
                $lastQuadro = null;
            }

            if ($lastQuadro !== $quadro_id) {
                $array['chapter'][$indexChapter]['subchapter'][$indexSubchapter]['quadro'][] = [
                    'value' => $quadro_id,
                    'description' => "Cuadro $quadro_id",
                    'title' => []
                ];
                $lastQuadro = $quadro_id;
                $indexQuadro = count($array['chapter'][$indexChapter]['subchapter'][$indexSubchapter]['quadro']) - 1;
            }
            $titles = array_column($array['chapter'][$indexChapter]['subchapter'][$indexSubchapter]['quadro'][$indexQuadro]['title'], "description");

            if (!in_array($title, $titles)) {
                $array['chapter'][$indexChapter]['subchapter'][$indexSubchapter]['quadro'][$indexQuadro]['title'][] = [
                    'value' => $subIndice,
                    'description' => $title,
                ];
            }
        }
        return $array;
    }

    public function listar_cuadros()
    {
        $conectar = parent::Conexion();
        parent::set_names();

        $sql = $this->getData() . ' ORDER BY A.fech_crea DESC';

        $stmt = $conectar->prepare($sql);
        $result = $stmt->execute();

        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$result || !is_array($data) || count($data) <= 0) {
            return false;
        }

        return $data;
    }

    public function listar_LastCuadros()
    {
        $conectar = parent::Conexion();
        parent::set_names();

        $sql = $this->getData() . ' ORDER BY A.fech_crea DESC LIMIT 1';

        $stmt = $conectar->prepare($sql);
        $result = $stmt->execute();

        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$result || !is_array($data) || count($data) <= 0) {
            return false;
        }

        return $data;
    }

    public function getLastRegister()
    {
        $conectar = parent::Conexion();
        parent::set_names();
        $sql = $this->getData() . ' ORDER BY A.fech_crea DESC LIMIT 1';
        $stmt = $conectar->prepare($sql);
        $result = $stmt->execute();

        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        error_log(json_encode($data));
        if (!$result || !is_array($data) || count($data) <= 0) {
            return false;
        }

        return $data;
    }

    private static function writeJSON($data)
    {
        if (is_array($data)) {
            $jsonData = json_encode($data, JSON_UNESCAPED_UNICODE);
        } else {
            $jsonData = $data;
        }
        $filePath = '../view/Anuario/modificar.json';
        error_log('cargando en ' . $filePath);
        if ($file = fopen($filePath, 'w')) {
            fwrite($file, $jsonData);

            fclose($file);
        } else {
            echo "No se pudo abrir o crear el archivo '$filePath'.";
        }
    }
}
