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
    <script src="js/animation.js" defer></script>
    <script src="js/ABM.js" defer></script>
</head>

<body id="container-form-ABM">
    <div class="container">
        <div class="row justify-content-center">
            <form id="form-ABM" class="col-8">
                
                <div class="form-group row">
                    <label for="censo" class="col-xl-6 col-sm-12 col-form-label sr-only">Censo:</label>
                    <div class="col-xl-6 col-sm-12">
                        <select name="censo" class="form-control" id="select-censo">
                            <option class="keep" value="select">Seleccione un año</option>
                            <option class="keep" value="add">Agregar un año</option>
                        </select>
                    </div>

                    <label for="department" class="col-xl-6 col-sm-12 col-form-label sr-only">Departamento:</label>
                    <div class="col-xl-6 col-sm-12">
                        <select name="department" class="form-control hidden" id="select-UG">
                            <option class="keep" value="select">Seleccione un departamento</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="theme" class="col-xl-6 col-sm-12 col-form-label sr-only">Unidad de Relevamiento:</label>
                    <div class="col-xl-6 col-sm-12">
                        <select name="theme" class="form-control hidden" id="select-UR">
                            <option class="keep" value="select">Seleccione una unidad de relevamiento</option>
                        </select>
                    </div>

                    <label for="quadro" class="col-xl-6 col-sm-12 col-form-label sr-only">Cuadro:</label>
                    <div class="col-xl-6 col-sm-12">
                        <select name="quadro" class="form-control hidden" id="select-Theme">
                            <option class="keep" value="select">Seleccione un cuadro</option>
                            <option class="keep" value="add">Agregar un cuadro</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="title" class="col-xl-6 col-sm-12 col-form-label sr-only">Título:</label>
                    <div class="col-12">
                        <select name="title" class="form-control  hidden" id="select-Title">
                            <option class="keep" value="select">Seleccione un titulo</option>
                            <option class="keep" value="add">Agregar un titulo</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row div-check ">
                    <label for="fraccion" class="col-xl-6 col-sm-6 col-form-label sr-only">Es fracción:</label>
                    <div class="col-xl-6 col-sm-6 d-flex justify-content-start align-items-center">
                        <p class="my-auto">Es fracción:</p>
                        <input type="checkbox" id="check" name="fraccion">
                    </div>

                </div>

                <div class="form-group row">
                    <label for="input-File" class="col-xl-6 col-sm-12 col-form-label sr-only">Archivo:</label>
                    <div class="col-12">
                        <input type="file" accept=".xlsx" name="select-File" class="form-control hidden" id="File" placeholder="Seleccione un archivo">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary btn-ABM hidden " id="btn_add">Agregar</button>
                        <button type="submit" class="btn btn-primary btn-ABM hidden " id="btn_modify">
                            Buscar</button>
                    </div>
                </div>

                <?php include_once __DIR__ . '/../layout/charge.php' ?>
            </form>
        </div>