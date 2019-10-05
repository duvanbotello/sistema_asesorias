<?php

class Index extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function index()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "index");
        require VIEWS . DFT . "footer.html";
       
        
    }

    public function userLogin()
    {
        if (isset($_POST["email"]) && isset($_POST["password"])) {
            $this->model->userLogin($_POST["email"], $_POST["password"]);
        }
    }

}


?>