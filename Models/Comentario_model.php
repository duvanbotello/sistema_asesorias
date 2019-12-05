<?php
    class Comentario_model extends Conexion {

        public function __construct() {
            parent::__construct();
        }

        function agregar($idAsesoria, $documento, $contenido) {
            $values = "(asesoria_ase_id, usuario_usu_documento, come_contenido) VALUES (:idAsesoria, :documento, :contenido)";
            $params = array(
                "idAsesoria" => $idAsesoria,
                "documento" => $documento,
                "contenido" => $contenido
            );
            $res = $this->db->insert("comentario", $values, $params);
            if($res === true) echo 1;
            else echo $res;
        }

        function obtener($idAsesoria) {
            $attr = "concat(u.usu_nombres, ' ', u.usu_apellidos) as usu_nombres, c.*";
            $tables = "comentario c, usuario u";
            $where = "c.usuario_usu_documento = u.usu_documento and asesoria_ase_id = :idAsesoria order by c.come_time asc";
            $params = array(
                "idAsesoria" => $idAsesoria
            );
            return $this->db->select($attr, $tables, $where, $params);
        }

    }