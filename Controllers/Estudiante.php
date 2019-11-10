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


}