<?php

class Login extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function carga()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "login");
        require VIEWS . DFT . "footer.html";
        
    }
    
    public function cargaActualizar()
    {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "actualizarPassword");
        require VIEWS . DFT . "footer.html";
        
    }

    public function recuperarPassword()
    {
        if (isset($_POST["email"])) {

            $data = $this->model->recuperarPassword($_POST['email']);
            
            //verificamos si es un array o contiene un array
            if (is_array($data)) {
                echo json_encode($data);
            } else {
                echo $data;
            }
        }
        
    }

    public function actualizarPassword()
    {
        $data = $this->model->actualizarPassword($_POST['password']);
            
        //verificamos si es un array o contiene un array
        if (is_array($data)) {
            echo json_encode($data);
        } else {
            echo $data;
        }
    }


}


?>