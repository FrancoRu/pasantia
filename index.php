<?php
session_start();
require_once './services/getCuadroManagment.php';
header('Content-Type: text/html; charset=UTF-8');
//require_once './controller/cuadros-controllers.php';

//$controller  = new CuadroController();

//$controller->getQuadro();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="main.js" defer></script>
    <link rel="stylesheet" href="./styles/styles.css" />
    <title>Document</title>
</head>

<body>
    <div class="svg-container"></div>
    <div class="contenedor">
        <!-- Se imagen del logotipo aquí usando una ruta relativa y la clase "logo-dgec" -->
        <img src="img/logo-dgec.png" alt="Logotipo de DGEyC" class="logo-dgec">
    </div>
    </div>
    <section>
        <main>
            <div class="container">
                <div class="header-form">
                    <div class="title-header">
                        <h1>Buscador de Cuadros</h1>
                        <h2>Censos 2010-2022</h2>
                    </div>
                    <div class="text">
                        <p>
                            En esta sección, se muestran los resultados del Censo Nacional
                            2010 a nivel provincial y por departmentos, con la adición de
                            datos provisionales del Censo 2022. Puedes buscar información
                            según área geográfica, unidad de relevamiento y tema de interés.
                        </p>
                    </div>
                </div>
                <form method="get" action="prueba.php" id="form" accept-charset="UTF-8">
                    <fieldset>
                        <label for="censo">
                            Año: <br />
                            <select name="censo">
                                <option>2010</option>
                                <option>2022</option>
                            </select>
                        </label>
                    </fieldset>
                    <fieldset>
                        <label for="department">
                            Unidad geográfica : <br />
                            <select id="department" name="department"></select>
                        </label>
                    </fieldset>
                    <fieldset>
                        <label for="survey">
                            Unidad de relevamiento: <br />
                            <select id="theme" name="theme"></select>
                        </label>
                    </fieldset>
                    <fieldset>
                        <label for="theme">
                            Temas: <br />
                            <select id="quadro" name="quadro"></select>
                        </label>
                    </fieldset>
                    <div class="button-container">
                        <button type="submit" id="submit">Buscar</button>
                    </div>
                </form>
            </div>
            <div class="charge"></div>
        </main>
    </section>
</body>

</html>