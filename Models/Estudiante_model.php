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

        public function obtenerAsesorias($idEstudiante) {
            $where = "a.idasesor = ase.idasesor and ase.usuario_usu_documento = u.usu_documento and asig.asig_id = a.asignatura_idasignatura and a.idestudiante = :idEstudiante order by a.ase_estado desc, a.ase_fecha asc, a.ase_horainicial asc";
            $params = array("idEstudiante" => $idEstudiante);
            return $this->db->select("a.*, concat(u.usu_nombres, ' ', u.usu_apellidos) as usu_nombres, asig.asig_nombre", "asesoria a, asesor ase, usuario u, asignatura asig", $where, $params);
        }
    }
