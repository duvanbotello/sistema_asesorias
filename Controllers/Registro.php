<?php

class Registro extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function carga()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "registro");
        require VIEWS . DFT . "footer.html";
        
    }


}


?>