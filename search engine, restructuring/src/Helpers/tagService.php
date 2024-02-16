<?php

namespace App\Helpers;

class TagService
{
    public static function getFormSearch()
    {
        $form = '<form id="form" accept-charset="UTF-8">
                <div class="mb-3">
                    <label for="censo" class="form-label">Año:</label>
                    <select class="form-select" id="censo" name="censo"></select>
                </div>
                <div class="mb-3">
                    <label for="department" class="form-label">Unidad geográfica:</label>
                    <select class="form-select" id="department" name="department"></select>
                </div>
                <div class="mb-3">
                    <label for="theme" class="form-label">Unidad de relevamiento:</label>
                    <select class="form-select" id="theme" name="theme"></select>
                </div>
                <div class="mb-3">
                    <label for="quadro" class="form-label">Temas:</label>
                    <select class="form-select" id="quadro" name="quadro"></select>
                </div>
                <div class="button-container container text-center">
                    <button type="submit" id="submit" class="btn btn-custom float-end width-auto">
                        Buscar
                    </button>
                </div>
            </form>';
        return $form;
    }
}
