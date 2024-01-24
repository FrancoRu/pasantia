<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administracion de cuadros</title>

    <link rel="stylesheet" href="./styles/main.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.min.js"></script>
</head>

<body id="container-form-ABM">
    <div class="container">
        <div class="row justify-content-center">
            <form id="form" class="col-8" action="http://localhost/sdt/controller/anuario.php?op=proof" method="post">

                <div class="form-group row">

                    <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                        <label for="censo" class="col-6 col-form-label">Censo*:</label>
                        <input type="number" value="2022" class="form-control" id="censo" required>
                        <!-- <select name="censo" class="form-control" id="select-censo">
                            <option value="select">Seleccione un año</option>
                        </select> -->
                    </div>

                    <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                        <label for="department" class="col-6 col-form-label">Departamento*:</label>

                        <select name="department" class="form-control" id="select-UG">
                            <option value="select">Seleccione un departamento</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                        <label for="theme" class="col-6 col-form-label">Unidad de Relevamiento*:</label>

                        <select name="theme" class="form-control" id="select-UR">
                            <option value="select">Seleccione una unidad de relevamiento</option>
                        </select>
                    </div>

                    <div class="col-xl-6 col-sm-12 d-flex justify-content-start align-items-center">
                        <label for="quadro" class="col-6 col-form-label">Cuadro*:</label>
                        <input type="text" class="form-control" id="quadro" placeholder="Ingrese el nombre del cuadro" required>
                        <!-- <select name="quadro" class="form-control" id="select-Theme">
                            <option value="select">Seleccione un cuadro</option>
                        </select> -->
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-12 d-flex justify-content-start align-items-center">
                        <label for="title" class="col-3 col-form-label">Título*:</label>
                        <input type="text" class="form-control" id="title" placeholder="Ingrese titulo" required>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-xl-6 col-sm-6 d-flex justify-content-start align-items-center">
                        <label for="fraccion" class="col-6 col-form-label">Extensión*:</label>

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

                        <input type="file" accept=".xlsx" name="select-File" class="form-control" id="File" placeholder="Seleccione un archivo" required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary btn-ABM" id="btn_add">Enviar</button>
                    </div>
                </div>
            </form>

        </div>
        <ul>
            <li>* Datos obligatorios</li>
            <li>Si la combinacion entre los datos otorgados coincide con algún registro en la BD se modificara el registro</li>
            <li>Si la combinacion entre los datos otorgados no coincide con algún registro en la BD se creara un registro nuevo</li>
        </ul>