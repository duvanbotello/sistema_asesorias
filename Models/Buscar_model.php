<?php

class Buscar_model extends Conexion {

    public function __construct() {
        //Ejecutamos el metodos Constructor de la clase Conexion.
        parent::__construct();
    }

    public function cargarAsesores($tipo) {
        if($tipo == 'Todos') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento';
            $param = array('rol' => 2);
        } else if($tipo == 'Experiencia') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by usas_experiencia desc';
            $param = array('rol' => 2);
        } else if($tipo == 'Recomendados') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by usas_recomendado desc';
            $param = array('rol' => 2);
        } else if($tipo == 'Nuevos') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by usas_fechacreacion desc';
            $param = array('rol' => 2);
        }
        return $this->db->select('u.*, a.*', 'usuario u, asesor a', $where, $param);
    }

    public function obtenerAsesor($documento) {
        $where = 'usu_rol_id = :rol and u.usu_documento = a.usuario_usu_documento and u.usu_documento = :documento';
        $param = array(
            'rol' => 2,
            'documento' => $documento
        );
        return $this->db->select('u.*, a.*', 'usuario u, asesor a', $where, $param)['results'][0];
    }

}