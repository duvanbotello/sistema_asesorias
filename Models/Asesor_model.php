<?php
    class Asesor_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        public function actualizarAsesor($documento, $nombres, $apellidos, $ubicacion, $correo, $fecha, $biografia) {
            $response = $this->db->updateAsesor($documento, $nombres, $apellidos, $ubicacion, $correo, $fecha, $biografia);
            if($response) return 1;
            else return $response;
        }

    }
