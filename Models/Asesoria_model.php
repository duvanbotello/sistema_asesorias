<?php
    class Asesoria_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        function registrar($fecha, $duracion, $idasignatura, $idasesor, $idestudiante) {
            $values = "(ase_fecha, ase_duracion, asignatura_idasignatura, idasesor, idestudiante) VALUES (:fecha, :duracion, :idasignatura, :idasesor, :idestudiante)";
            $params = array(
                'fecha' => $fecha,
                'duracion' => $duracion,
                'idasignatura' => $idasignatura,
                'idasesor' => $idasesor,
                'idestudiante' => $idestudiante
            );
            $res = $this->db->insert("asesoria", $values, $params);
            if($res === true) return 1;
            else return $res;
        }

    }