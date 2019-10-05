<?php

class Index extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function index()
    {
        $estudiante = null;
        $recep = isset($_SESSION["estudiante"]);
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "index");
        require VIEWS . DFT . "footer.html";
       
    }

    public function userLogin()
    {
        if (isset($_POST["email"]) && isset($_POST["password"])) {
            //vamos a utilizar el metodo userLogin del modelo index_model
            //ya que esta clase extiende a Controllers y por consecuente se pueden
            //utilizar todas las clases dentro de Models
            //y utilizo la instancia model para el metodo UserLogin que esta dentro de index_model
            $data = $this->model->userLogin($_POST["email"], $_POST["password"]);
            //verificamos si es un array o contiene un array
            if (is_array($data)) {
                echo json_encode($data);
            } else {
                echo $data;
            }
        }
    }

}


?>