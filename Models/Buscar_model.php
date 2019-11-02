<?php

class Buscar_model extends Conexion {

    public function __construct() {
        //Ejecutamos el metodos Constructor de la clase Conexion.
        parent::__construct();
    }

    public function cargarAsesores() {
        $where = 'usu_rol_id = :rol';
        $param = array('rol' => 2);
        $response = $this->db->select('*', 'usuario', $where, $param);
        return $response;
    }

}