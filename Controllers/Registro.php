<?php
    class Registro extends Controllers {
        public function __construct() {
            parent::__construct();
        }

        public function carga() {
            require VIEWS . DFT . "head.html";
            $this->view->render($this, "registro");
            require VIEWS . DFT . "footer.html";
        }

        public function registrar() {
            $data = $this->model->registrar($_POST['nombres'], $_POST['apellidos'], $_POST['fechanac'], $_POST['tipodoc'], $_POST['documento'], $_POST['ubicacion'], $_POST['tipotel'], $_POST['telefono'], $_POST['tiporol'], $_POST['experiencia'], $_POST['biografia'], $_POST['email'], $_POST['password'], $_POST['asignaturas']);
            if ($data === 1) echo 'El documento o el correo electrónico ya se encuentran registrados';
            else echo $data;
        }

        function obtenerAsignaturas() {
            $data = $this->model->obtenerAsignaturas();
            if (is_array($data)) echo json_encode($data);
            else echo $data;
        }

    }
