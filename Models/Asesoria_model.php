<?php
    class Asesoria_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        function registrar($fecha, $horainicial, $horafinal, $idasignatura, $idasesor, $idestudiante) {
            $values = "(ase_fecha, ase_horainicial, ase_horafinal, asignatura_idasignatura, idasesor, idestudiante) VALUES (:fecha, :horainicial, :horafinal, :idasignatura, :idasesor, :idestudiante)";
            $params = array(
                'fecha' => $fecha,
                'horainicial' => $horainicial,
                'horafinal' => $horafinal,
                'idasignatura' => $idasignatura,
                'idasesor' => $idasesor,
                'idestudiante' => $idestudiante
            );
            $res = $this->db->insert("asesoria", $values, $params);
            if($res === true) return 1;
            else return $res;
        }
        
        function eliminar($idasesoria) {
            $where = "ase_id = :idasesoria";
            $params = array("idasesoria" => $idasesoria);
            $res = $this->db->delete("asesoria", $where, $params);
            if($res === true) return 1;
            else return $res;
        }

        function actualizar($idasesoria, $estado) {
            $where = "ase_id = :idasesoria";
            $params = array("idasesoria" => $idasesoria);
            $res = $this->db->update("asesoria", "ase_estado", $estado, $where, $params);
            if($res === true) return 1;
            else return $res;
        }

        function calificar($idasesoria, $calificacion, $observacion) {
            $where = "ase_id = $idasesoria";
            $fields = array("ase_calificacion", "ase_observacion");
            $newValues = array($calificacion, $observacion);
            $res = $this->db->updateAll("asesoria", $fields, $newValues, $where, null);
            if($res === true) return 1;
            else return $res;
        }

    }