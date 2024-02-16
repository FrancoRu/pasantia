<?php
?>

<div class="col-xl-5 col-sm-12">
    <section id="Section-form" class="bg-light shadow rounded-3 m-3 p-3 border border-0 border-dark">
        <main class="custom-container">
            <div class="header-form">
                <div class="title-header text-start">
                    <h1>Buscador de Cuadros</h1>
                    <h2>Censos 2010-2022</h2>
                </div>
                <div class="text-start small">
                    <p>
                        En esta sección, se muestran los resultados del Censo Nacional
                        2010 a nivel provincial y por departamentos, con la adición de
                        datos provisionales del Censo 2022. Puedes buscar información
                        según área geográfica, unidad de relevamiento y tema de interés.
                    </p>
                </div>
                <form id="form" accept-charset="UTF-8">
                    <div class="form-group text-start">
                        <label for="censo" class="form-label">Año:</label>
                        <select class="form-select" id="censo" name="censo"></select>
                    </div>
                    <div class="form-group text-start">
                        <label for="department" class="form-label">Unidad geográfica:</label>
                        <select class="form-select" id="department" name="department"></select>
                    </div>
                    <div class="form-group text-start">
                        <label for="theme" class="form-label">Unidad de relevamiento:</label>
                        <select class="form-select" id="theme" name="theme"></select>
                    </div>
                    <div class="form-group text-start">
                        <label for="quadro" class="form-label">Temas:</label>
                        <select class="form-select" id="quadro" name="table"></select>
                    </div>
                    <div class="form-group button-container text-center d-flex justify-content-center">
                        <button type="submit" id="submit" class="btn btn-outline-success">
                            Buscar
                        </button>
                    </div>
                </form>
            </div>
            <div class="text-center small" id="img-static">
                <img src="public/resource/img/Personas.svg" alt="Imagen" class="img-fluid mx-auto d-block" />
            </div>
            <?php include_once __DIR__ . '/../layout/charge.php' ?>
        </main>
    </section>
</div>