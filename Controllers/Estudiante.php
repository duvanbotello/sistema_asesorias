<?php

class Estudiante extends Controllers {
    public function __construct() {
        parent::__construct();
    }

    public function miperfil() {
        if(isset($_SESSION["estudiante"])) {
            require VIEWS . DFT . "head.html";
            $this->view->render($this, "perfil");
            require VIEWS . DFT . "footer.html";
        } else {
            header('Location: http://localhost/sistema_asesorias/Index/index');
        }
    }
    public function EditarPerfil() {
        if(isset($_SESSION["estudiante"])) {
            require VIEWS . DFT . "head.html";
            $this->view->render($this, "editarPerfil");
            require VIEWS . DFT . "footer.html";
        } else {
            header('Location: http://localhost/sistema_asesorias/Index/index');
        }
    }

    public function obtenerEstudiante() {
        $data = $this->model->obtenerEstudiante($_GET["documento"]);
        if(is_array($data)) echo json_encode($data);
        else echo $data;
    }

    public function actualizarEstudiante() {
        echo $this->model->actualizarEstudiante($_POST['documento'], $_POST['nombres'], $_POST['apellidos'], $_POST['correo'], $_POST['fecha']);
    }

    public function recomendarAsesor() {
        echo $this->model->recomendarAsesor($_POST['idEstudiante'], $_POST['idAsesor']);
    }

}