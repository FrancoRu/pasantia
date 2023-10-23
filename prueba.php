<?php
require_once './controller/cuadros-controllers.php';
try {
    $controller  = new CuadroController();
    $_SESSION['data'] = $controller->getQuadro();
} catch (Exception $e) {
    echo $e->getMessage();
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <?php
    if (isset($_SESSION['data'])) {
        echo $_SESSION['data'];
    }
    ?>
</body>

</html>