<?php
    class Estudiante_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        public function obtenerEstudiante($documento) {
            $where = 'usu_rol_id = :rol and u.usu_documento = a.usuario_usu_documento and u.usu_documento = :documento';
            $param = array(
                'rol' => 2,
                'documento' => $documento
            );
            return $this->db->select('u.*, e.*', 'usuario u, estudiante e', $where, $param)['results'][0];
        }

    }
