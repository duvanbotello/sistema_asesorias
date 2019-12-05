<?php
    class Comentario extends Controllers {
        public function __construct() {
            parent::__construct();
        }

        public function comentario() {
            if(isset($_SESSION["estudiante"]) || isset($_SESSION["asesor"])) {
                require VIEWS . DFT . "head.html";
                $this->view->render($this, "comentario");
                require VIEWS . DFT . "footer.html";
            } else {
                header('Location: http://localhost/sistema_asesorias/Index/index');
            }
        }

        function agregar() {
            return $this->model->agregar($_POST["idAsesoria"], $_POST["documento"], $_POST["contenido"]);
        }

        function obtener() {
            $data = $this->model->obtener($_GET["idAsesoria"]);
            if(is_array($data)) echo json_encode($data);
            else echo $data;
        }
    }