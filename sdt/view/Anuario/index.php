<?php
require_once("../../config/conexion.php");
if (isset($_SESSION["usu_id"])) {
?>
    <!DOCTYPE html>
    <html>
    <?php require_once("../MainHead/head.php"); ?>
    <link rel="stylesheet" href="../../public/css/separate/pages/form.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="mostrarlistado.js" defer></script>
    <script src="main.js" defer></script>
    <title>Anuario</title>

    </head>

    <body class="with-side-menu">
        <?php require_once("../MainHeader/header.php"); ?>

        <div class="mobile-menu-left-overlay"></div>

        <?php require_once("../MainNav/nav.php"); ?>
        <div class="page-content">
            <div class="container">
                <div class="container-fluid">
                    <div class="box-typical box-typical-padding">
                        <form id="form" class="sign-box" action="" method="post">
                            <input type="hidden" id="action_id" name="action_id" value="1" />
                            <input type="hidden" id="rol_id" name="action_id" value="<?php echo $_SESSION["rol_id"] ?>" />
                            <input type="hidden" id="usu_id" name="usu_id" value="<?php echo $_SESSION["usu_id"] ?>">
                            <div class="sign-avatar">
                                <img src="../../public/img/storage.svg" alt="" id="imgtipo" />
                            </div>
                            <header class="sign-title" id="lbltitulo">Ingresar cuadro</header>

                            <div class="form-group">
                                <label for="chapter"> Capitulo: </label>
                                <select id="chapters" name="chapter" class="form-control"></select>
                            </div>

                            <div class="form-group">
                                <label for="subChapter"> Subcapitulo: </label>
                                <select id="subChapters" name="subChapter" class="form-control"></select>
                            </div>

                            <div id="optionChanges"></div>

                            <div class="form-group">
                                <input type="file" id="file" name="file" accept=".doc, .docx, .xls, .xlsx" class="form-control clean" required />
                            </div>
                            <div class="form-group">
                                <div class="float-right reset"></div>
                                <div class="float-left reset">
                                    <a href="#" id="btnsoporte">Actualizar cuadro</a>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" id="btn-submit" class="btn btn-primary rounded-pill">
                                    Enviar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <?php require_once 'mostrarlistado.php' ?>
            </div>
            <?php
            if (isset($_SESSION['usu_id']) && $_SESSION['usu_id'] == 2) {
                echo '<div>
            <a href="../../controller/anuario.php?op=download&usu_id=' . $_SESSION['usu_id'] . '" download target="_blank" class="btn btn-primary">Descargar</a>
        </div>';
            }
            ?>

        </div>
        <?php require_once("../MainJs/js.php"); ?>
    </body>

    </html>
<?php
} else {
    header("Location:" . Conectar::ruta() . "index.php");
}
?>