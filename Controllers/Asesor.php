<?php
    class Asesor extends Controllers {
        
        public function __construct() {
            parent::__construct();
        }

        public function miperfil() {
            if(isset($_SESSION["asesor"])) {
                require VIEWS . DFT . "head.html";
                $this->view->render($this, "perfil");
                require VIEWS . DFT . "footer.html";
            } else {
                header('Location: http://localhost/sistema_asesorias/Index/index');
            }
        }

        public function actualizarAsesor() {
            echo $this->model->actualizarAsesor($_POST['documento'], $_POST['nombres'], $_POST['apellidos'], $_POST['ubicacion'], $_POST['correo'], $_POST['fecha'], $_POST['biografia']);
        }

        public function obtenerAsesorias() {
            $data = $this->model->obtenerAsesorias($_GET["idAsesor"]);
            if(is_array($data)) echo json_encode($data);
            else echo $data;
        }

    }