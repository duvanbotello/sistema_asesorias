<?php
    class Asesoria extends Controllers {

        public function __construct() {
            parent::__construct();
        }

        function registrar() {
            echo $this->model->registrar($_POST['fecha'], $_POST['duracion'], $_POST['idasignatura'], $_POST['idasesor'], $_POST['idestudiante']);
        }

    }