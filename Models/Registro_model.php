<?php
class Registro_model extends Conexion
{
    public function __construct()
    {
        parent::__construct();
    }

    public function registrar($nombres, $apellidos, $fechanac, $tipodoc, $documento, $ubicacion, $tipotel, $telefono, $tiporol, $experiencia, $biografia, $fechacrea, $email, $password)
    {

        $where = 'usu_documento = :documento or usu_correo = :email';
        $param = array(
            'documento' => $documento,
            'email' => $email
        );
        $response = $this->db->select('*', 'usuario', $where, $param);
        if (is_array($response)) {
            $response = $response['results'];
            if ($response == null) {
                $value = '(usu_documento, tipodoc_id, usu_nombres, usu_apellidos, usu_fechanac, usu_correo, usu_ubicacion, usu_contrasena, usu_rol_id) VALUES (
                    :documento, :tipodoc, :nombres, :apellidos, :fechanac, :email, :ubicacion, :password, :rol
                    )';
                $param = array(
                    'documento' => $documento,
                    'tipodoc' => $tipodoc,
                    'nombres' => $nombres,
                    'apellidos' => $apellidos,
                    'fechanac' => $fechanac,
                    'email' => $email,
                    'ubicacion' => $ubicacion,
                    'password' => password_hash($password, PASSWORD_DEFAULT),
                    'rol' => $tiporol
                );
                $data2 = $this->db->insert('usuario', $value, $param);
                if ($data2) {
                    $value = '(tele_numero,	tele_tipo, usuario_usu_documento) VALUES (:numero,:tipo,:documento)';
                    $param = array(
                        'numero' => $telefono,
                        'tipo' => $tipotel,
                        'documento' => $documento
                    );
                    $data = $this->db->insert('telefono', $value, $param);
                    
                    if ($tiporol == 1) {
                        $value = '(usuario_usu_documento) VALUES (:usuario_usu_documento)';
                        $param = array(
                            'usuario_usu_documento' => $documento
                        );
                        $data = $this->db->insert('estudiante', $value, $param);
                    } else if ($tiporol == 2) {
                        $value = '(usuario_usu_documento, usas_experiencia, usas_biografia, usas_fechacreacion) VALUES (:usuario_usu_documento, :experiencia, :biografia, :fechacrea)';
                        $param = array(
                            'usuario_usu_documento' => $documento,
                            'experiencia' => $experiencia,
                            'biografia' => $biografia,
                            'fechacrea' => $fechacrea
                        );
                        $data = $this->db->insert('asesor', $value, $param);
                    }
                    return 0;
                } else {
                   
                    return $data2;
                }
            } else {
                return 1;
            }
        } else {
            return $response;
        }
    }

}
