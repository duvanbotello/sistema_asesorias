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

        public function recomendarAsesor($idEstudiante, $idAsesor) {
            $value = '(estudiante_idestudiante, asesor_idasesor) VALUES (:idEstudiante, :idAsesor)';
            $param = array(
                'idEstudiante' => $idEstudiante,
                'idAsesor' => $idAsesor
            );
            $response = $this->db->insert('recomendados', $value, $param);
            if($response === true) return 1;
            else return $response;
        }
    }
