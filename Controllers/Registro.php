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
            $data = $this->model->registrar($_POST['tipodoc'], $_POST['nombres'], $_POST['apellidos'], $_POST['fechanac'], $_POST['documento'], $_POST['tiporol'], $_POST['tipotel'], $_POST['telefono'], $_POST['email'], $_POST['password']);
            if ($data == 1) echo 'El documento o el correo electrónico ya se encuentran registrado';
            else echo $data;
        }

    }
