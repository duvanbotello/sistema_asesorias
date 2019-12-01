<?php

class Buscar_model extends Conexion {

    public function __construct() {
        //Ejecutamos el metodos Constructor de la clase Conexion.
        parent::__construct();
    }

    public function cargarAsesores($tipo) {
        $attr = "u.*, a.*";
        $tables = "usuario u, asesor a";
        $param = array('rol' => 2);
        $where = "";
        if($tipo == 'Todos') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by u.usu_nombres, u.usu_apellidos desc';
        } else if($tipo == 'Experiencia') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by a.usas_experiencia desc';
        } else if($tipo == 'Recomendados') {
            $attr .= ", (select count(*) from recomendados where asesor_idasesor = a.idasesor) as usas_recomendado";
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by usas_recomendado desc';
        } else if($tipo == 'Nuevos') {
            $where = 'usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento order by a.usas_fechacreacion desc';
        } else {
            $where = "usu_rol_id = :rol and a.usuario_usu_documento = u.usu_documento and ( u.usu_nombres like '%$tipo%' or u.usu_apellidos like '%$tipo%')";
        }
        $data = $this->db->select($attr, $tables, $where, $param)['results'];

        for ($i = 0; $i < sizeof($data); $i++) {
            $document = $data[$i]['usu_documento'];
            $res = $this->db->select("a.asig_nombre", "asesor_asignatura aa, asignatura a", "a.asig_id = aa.asignatura_asig_id and aa.asesor_usuario_usu_documento = '$document'", null)['results'];
            $data[$i]['asignaturas'] = $res;
        }

        return array('results' => $data);
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