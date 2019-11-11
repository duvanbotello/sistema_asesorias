<?php
    class Estudiante_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        public function actualizarEstudiante($documento, $nombres, $apellidos, $correo, $fecha) {
            $response = $this->db->updateEstudiante($documento, $nombres, $apellidos, $correo, $fecha);
            if($response) return 1;
            else return $response;
        }
    }
