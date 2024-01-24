<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once("../config/conexion.php");
require_once("../models/Anuario.php");
$anuario = new Anuario();

require_once("../models/Usuario.php");
$usuario = new Usuario();

require_once("../models/Documento.php");
$documento = new Documento();

if (isset($_FILES['file']['name'])) {
    $_FILES['file']['name'] = preg_replace('/^[0-9.]+-*/', '', $_FILES['file']['name']);
}

function info($datos)
{
    $data = array();
    foreach ($datos as $row) {

        $username = $row['fullname'];

        $chapter_id = $row['cap_id'];
        $chapter_desc = $row['cap_descrip'];

        $subchapter_id = $row['subcap_value'];
        $subchapter_desc = $row['subcap_descrip'];

        $quadro_id = $row['cuad_id'];

        $title = $row['desc_titulo'];

        $filename = $row['doc_nom'];

        $fecha = $row['fech_crea'];

        $filePath = "https://dgec.gob.ar/sdt/public/anuario/Capitulo $chapter_id $chapter_desc/Subcapitulo $subchapter_id $subchapter_desc/Cuadro $quadro_id/$chapter_id.$subchapter_id.$quadro_id-$filename";
        $data[] = [
            $username,
            $chapter_desc,
            $subchapter_desc,
            $quadro_id,
            $title,
            $fecha,
            "<a href='" . $filePath . "' target='_blank' download><img class='download' src='../../public/img/download.svg' alt='Descarga' /></a>"
        ];
    }
    return $data;
}

switch ($_GET["op"]) {

    case "insert":
        $datos = $anuario->insert_cuadro($_POST["usu_id"], $_POST["chapter"], $_POST["subChapter"], $_POST["quadro"], $_POST["title"]);
        if ($datos !== false) {
            $output["path"] = $datos['path'];

            $ruta = "../public/anuario/" . $output["path"] . "/";

            if (@!file_exists($ruta)) {
                @mkdir($ruta, 0777, true);
            }
            $doc1 = $_FILES['file']['tmp_name'];
            $destino = $ruta . $datos['code'] . $_FILES['file']['name'];
            @move_uploaded_file($doc1, $destino);
            $anuario->create_json();
            http_response_code(200);
            echo json_encode(['message' => 'Carga Exitosa']);
        }
        break;

    case "update":
        // $_POST['usu_id'] = 1;
        $datos = $anuario->update_cuadro($_POST['usu_id'], $_POST["chapter"], $_POST["subChapter"], $_POST["quadro"], $_POST["title"]);

        if ($datos !== false) {
            $output["path"] = $datos['path'];
            $character = '';
            $ruta = "../public/anuario/" . $output["path"] . "/";
            if ($datos['subindice'] !== 1) {
                // $anuario->updateTitle($_FILES['file']['name'], $datos['subindice'] - 1);
                $character = '*(' . $anuario->charindex($datos['subindice'] - 1) . ')';
            }
            if (!file_exists($ruta)) {
                @mkdir($ruta, 0777, true);
            }

            $files = glob($ruta . $character . '*.' . pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION));
            if (!empty($files)) {
                $fileReplace = $files[0];
                if (file_exists($fileReplace)) {
                    unlink($fileReplace);
                }
            }
            $doc1 = $_FILES['file']['tmp_name'];
            $destino = $ruta . $datos['code'] . $_FILES['file']['name'];
            @move_uploaded_file($doc1, $destino);
            http_response_code(200);
            echo json_encode(['message' => 'Carga Exitosa']);
        }
        break;

    case "download":
        $valido = $anuario->supportUser($_GET['usu_id']);
        if (!$valido) {
            http_response_code(403);
            echo json_encode(['message' => 'User not authorized']);
            exit();
        }

        $zip = new ZipArchive();
        $zipname = 'anuario.zip';
        $folder = '../public/anuario';

        $result = $zip->open($zipname, ZipArchive::CREATE | ZipArchive::OVERWRITE);
        if (!$result) {
            http_response_code(500);
            echo json_encode(['message' => 'Internal Server Error']);
            exit();
        }

        $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($folder));

        foreach ($files as $file) {
            if (!$file->isDir()) {
                $pathfile = $file->getRealPath();
                $filename = substr($file, strlen($folder) + 1);
                $zip->addFile($pathfile, $filename);
            }
        }


        $zip->close();

        // Encabezados para forzar la descarga del archivo ZIP
        header('Content-Type: application/zip');
        header('Content-disposition: attachment; filename=' . $zipname);
        header("cache-control: no-cache, must-revalidate");
        header("Expires:0");


        // Leer y enviar el contenido del archivo ZIP
        readfile($zipname);

        // Eliminar el archivo ZIP después de la descarga
        unlink($zipname);


        // Finalizar la ejecución del script
        exit();
        break;

    case "listar":
        $datos = $anuario->listar_cuadros();
        if ($datos !== false) {
            http_response_code(200);
            echo json_encode(info($datos));
            exit();
        }

        http_response_code(400);
        echo json_encode(['message' => 'Sucedio un problema al cargar los datos de la tabla']);
        break;

    case 'LastInsert':
        $datos = $anuario->listar_LastCuadros();
        error_log(json_encode($datos));
        if ($datos !== false) {
            http_response_code(200);
            echo json_encode(info($datos));
            exit();
        }
        http_response_code(400);
        echo json_encode(['message' => 'Sucedio algo al cargar el ultimo registro']);
        break;
}
