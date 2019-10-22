<?php

class Login extends Controllers
{
    public function __construct() {
        parent::__construct();
    }

    public function carga()
    {

        $estudiante = null;
        $estudiante = isset($_SESSION["estudiante"]);
        $asesor = null;
        $asesor = isset($_SESSION["asesor"]);

        if (null != $estudiante) {
            require VIEWS . DFT . "head.html";
            require VIEWS . IND . "PrincipalEstudiante.html";
            require VIEWS . DFT . "footer.html";
        } else if (null != $asesor) {
            require VIEWS . DFT . "head.html";
            require VIEWS . IND . "PrincipalAsesor.html";
            require VIEWS . DFT . "footer.html";
        } else {
            //redireccionamos el usuario a la vista login
            require VIEWS . DFT . "head.html";
        $this->view->render($this, "login");
        require VIEWS . DFT . "footer.html";
        }

        
        
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
