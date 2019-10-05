<?php
    class Registro_model extends Conexion {
        public function __construct() {
            parent::__construct();
        }

        public function registrarEstudiante($nombres, $apellidos, $fechanac, $documento, $telefono, $email, $password) {
            $where = 'usu_documento = :documento or usu_correo = :email';
            $param = array(
                'documento' => $documento,
                'email' => $email
            );
            $response = $this->db->select('*', 'usuario', $where, $param);
            if (is_array($response)) {
                $response = $response['results'];
                if ($response == null) {
                    $value = '(tipodoc_id, usu_nombres, usu_apellidos, usu_fechanac, usu_documento, usu_rol_id, usu_contraseña, usu_correo) VALUES (
                        :tipodoc, :nombres, :apellidos, :fechanac, :documento, :tiporol, :password, :email
                    )';
                    $param = array(
                        'tipodoc' => 1,
                        'nombres' => $nombres,
                        'apellidos' => $apellidos,
                        'fechanac' => $fechanac,
                        'documento' => $documento,
                        'tiporol' => 1,
                        'password' => password_hash($password, PASSWORD_DEFAULT),
                        'email' => $email
                    );
                    $data = $this->db->insert('usuario', $value, $param);
                    if ($data) return 0;
                    else return $data;
                } else {
                    return 1;
                }
            } else {
                return $response;
            }
        }

    }
