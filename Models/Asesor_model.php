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

        public function obtenerAsesorias($idAsesor) {
            $where = "a.idestudiante = e.idestudiante and e.usuario_usu_documento = u.usu_documento and asig.asig_id = a.asignatura_idasignatura and a.idasesor = :idAsesor order by a.ase_estado desc, a.ase_fecha asc, a.ase_horainicial asc";
            $params = array("idAsesor" => $idAsesor);
            return $this->db->select("a.*, concat(u.usu_nombres, ' ', u.usu_apellidos) as usu_nombres, asig.asig_nombre", "asesoria a, estudiante e, usuario u, asignatura asig", $where, $params);
        }

    }
