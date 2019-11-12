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
        } else {
            $where = "usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento and ( u.usu_nombres like '%$tipo%' or u.usu_apellidos like '%$tipo%')";
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
        $asesor = $this->db->select('u.*, a.*', 'usuario u, asesor a', $where, $param)['results'][0];
        $where = 'asesor_idasesor = :idAsesor';
        $param = array(
            'idAsesor' => $asesor['idasesor']
        );
        $recomendaciones = $this->db->select('count(*) as recom', 'recomendados', $where, $param)['results'][0]['recom'];
        return array(
            'idasesor' => $asesor['idasesor'],
            'usas_experiencia' => $asesor['usas_experiencia'],
            'usas_biografia' => $asesor['usas_biografia'],
            'usas_fechacreacion' => $asesor['usas_fechacreacion'],
            'usu_documento' => $asesor['usu_documento'],
            'tipodoc_id' => $asesor['tipodoc_id'],
            'usu_nombres' => $asesor['usu_nombres'],
            'usu_apellidos' => $asesor['usu_apellidos'],
            'usu_fechanac' => $asesor['usu_fechanac'],
            'usu_correo' => $asesor['usu_correo'],
            'usu_ubicacion' => $asesor['usu_ubicacion'],
            'usu_rol_id' => $asesor['usu_rol_id'],
            'usas_recomendado' => $recomendaciones
        );
    }

}