<?php
    class Perfil extends Controllers {
        public function __construct() {
            parent::__construct();
        }

        public function asesor() {
            require VIEWS . DFT . "head.html";
            $this->view->render($this, "perfil");
            require VIEWS . DFT . "footer.html";
        }

    }
