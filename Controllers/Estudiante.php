<?php

class Estudiante extends Controllers {
    public function __construct() {
        parent::__construct();
    }

    public function miperfil() {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "perfil");
        require VIEWS . DFT . "footer.html";
    }


}