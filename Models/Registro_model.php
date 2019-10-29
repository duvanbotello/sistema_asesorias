<?php
class Registro_model extends Conexion
{
    public function __construct()
    {
        parent::__construct();
    }

    public function registrar($nombres, $apellidos, $fechanac, $tipodoc, $documento, $tipotel, $telefono, $tiporol, $email, $password)
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
                $value = '(tipodoc_id, usu_nombres, usu_apellidos, usu_fechanac, usu_documento,  usu_contrasena, usu_correo, usu_rol_id) VALUES (
                        :tipodoc, :nombres, :apellidos, :fechanac, :documento, :password, :email, :rol
                    )';
                $param = array(
                    'tipodoc' => $tipodoc,
                    'nombres' => $nombres,
                    'apellidos' => $apellidos,
                    'fechanac' => $fechanac,
                    'documento' => $documento,
                    'password' => password_hash($password, PASSWORD_DEFAULT),
                    'email' => $email,
                    'rol' => $tiporol
                );
                $data2 = $this->db->insert('usuario', $value, $param);
                if ($data2) {
                    $value = '(tele_numero,	tele_tipo,usuario_usu_documento) VALUES (:numero,:tipo,:documento)';
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
                        $value = '(usuario_usu_documento) VALUES (:usuario_usu_documento)';
                        $param = array(
                            'usuario_usu_documento' => $documento
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
