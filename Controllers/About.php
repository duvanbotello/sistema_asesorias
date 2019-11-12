<?php

class About extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function cargaAbout()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "about");
        require VIEWS . DFT . "footer.html";
    }

    public function cargaContact()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "contact");
        require VIEWS . DFT . "footer.html";
    }

}
