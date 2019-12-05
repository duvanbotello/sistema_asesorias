<?php
    class Asesoria extends Controllers {

        public function __construct() {
            parent::__construct();
        }

        function registrar() {
            echo $this->model->registrar($_POST['fecha'], $_POST['horainicial'], $_POST['horafinal'], $_POST['idasignatura'], $_POST['idasesor'], $_POST['idestudiante']);
        }

        function eliminar() {
            echo $this->model->eliminar($_POST['idasesoria']);
        }

        function actualizar() {
            echo $this->model->actualizar($_POST['idasesoria'], $_POST['estado']);
        }

        function calificar() {
            echo $this->model->calificar($_POST['idasesoria'], $_POST['calificacion'], $_POST['observacion']);
        }

    }