<?php
require_once("../../config/conexion.php");
if (isset($_SESSION["usu_id"])) {
?>
    <!DOCTYPE html>
    <html>
    <?php require_once("../MainHead/head.php"); ?>
    <link rel="stylesheet" href="../../public/css/separate/pages/form.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="main.js" defer></script>
    <title>Buscador</title>

    </head>

    <body class="with-side-menu">
        <?php require_once("../MainHeader/header.php"); ?>

        <div class="mobile-menu-left-overlay"></div>

        <?php require_once("../MainNav/nav.php"); ?>
        <div class="page-content">
            <div class="container">
                <div class="container-fluid">
                    <div class="box-typical box-typical-padding">
                        <form id="form-buscador" class="col-8">

                            <div class="form-group row">

                                <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                                    <label for="censo" class="col-6 col-form-label">Censo*:</label>
                                    <input type="number" name="censo" value="2022" class="form-control" id="censo" required>
                                </div>

                                <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                                    <label for="department" class="col-6 col-form-label">Departamento*:</label>

                                    <select name="department" class="form-control" id="select-UG">

                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                                    <label for="theme" class="col-6 col-form-label">Unidad de Relevamiento*:</label>

                                    <select name="theme" class="form-control" id="select-UR">
                                        <option value="H">Hogar</option>
                                        <option value="P">Población</option>
                                        <option value="V">Vivienda</option>
                                    </select>
                                </div>

                                <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                                    <label for="quadro" class="col-6 col-form-label">Cuadro*:</label>
                                    <input type="text" name="quadro" class="form-control" id="quadro" placeholder="Ingrese el nombre del cuadro" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-12 d-flex justify-content-start align-items-center">
                                    <label for="title" class="col-3 col-form-label">Título*:</label>
                                    <input type="text" name="title" class="form-control" id="title" placeholder="Ingrese titulo" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-xl-6 col-sm-6 d-flex justify-content-start align-items-center">
                                    <label for="extension" class="col-6 col-form-label">Extensión*:</label>

                                    <select name="extension" class="form-control" id="select-fraccion">
                                        <option value="1">por área de gobierno local, fracción y radio censal</option>
                                        <option value="2">por departamento</option>
                                        <option value="3">total departamental</option>
                                    </select>
                                </div>
                                <div class="col-xl-6 col-sm-6 d-flex justify-content-start align-items-center">
                                    <label for="fraccion" class="col-6 col-form-label">Acrónimo*:</label>

                                    <select name="fraccion" class="form-control" id="select-fraccion">
                                        <option value="0">Fracción - FR</option>
                                        <option value="1">Provincial - PR</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-12 d-flex justify-content-start align-items-center">
                                    <label for="input-File" class="col-3 col-form-label ">Archivo:</label>

                                    <input type="file" accept=".xlsx" name="input-File" class="form-control" id="File" placeholder="Seleccione un archivo" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary btn-ABM" id="btn_add">Enviar</button>
                                </div>
                            </div>
                        </form>
                        <ul>
                            <li>* Datos obligatorios</li>
                            <li>Si la combinacion entre los datos otorgados coincide con algún registro en la BD se modificara el registro</li>
                            <li>Si la combinacion entre los datos otorgados no coincide con algún registro en la BD se creara un registro nuevo</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <?php require_once("../MainJs/js.php"); ?>
    </body>

    </html>
<?php
} else {
    header("Location:" . Conectar::ruta() . "index.php");
}
?>