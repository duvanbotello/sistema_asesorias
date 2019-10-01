<?php

class Index extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function index()
    {
        $this->view->render($this,"login");
    }

    public function userLogin()
    {
        if (isset($_POST["email"]) && isset($_POST["password"])) {
            $this->model->userLogin($_POST["email"], $_POST["password"]);
        }
    }

}


?>