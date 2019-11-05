<?php

class Buscar extends Controllers {
    public function __construct() {
        parent::__construct();
    }

    public function carga() {
        require VIEWS . DFT . "head.html";
        $this->view->render($this, "buscar");
        require VIEWS . DFT . "footer.html";
    }

    public function cargarAsesores() {
        $data = $this->model->cargarAsesores($_GET["tipo"]);
        if(is_array($data)) echo json_encode($data);
        else echo $data;
    }

    public function obtenerAsesor() {
        $data = $this->model->obtenerAsesor($_GET["documento"]);
        if(is_array($data)) echo json_encode($data);
        else echo $data;
    }

}