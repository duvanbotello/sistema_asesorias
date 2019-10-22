<?php
    class Registro_model extends Conexion {
        public function __construct() {
            parent::__construct();
        }

        public function registrar($nombres, $apellidos, $fechanac, $tipodoc, $documento, $tipotel, $telefono, $tiporol, $email, $password) {
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
                        'tipodoc' => $tipodoc,
                        'nombres' => $nombres,
                        'apellidos' => $apellidos,
                        'fechanac' => $fechanac,
                        'documento' => $documento,
                        'tiporol' => $tiporol,
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

        // public function registrarTele($telefono, $tipotel)
        // {
        //     $where = 'tele_numero = :telefono or tele_tipo = :tipotel';
        //     $param = array(
        //         'telefono' => $telefono,
        //         'tipotel' => $tipotel
        //     );
        //     $response = $this->db->select('*', 'telefono', $where, $param);
        //     if (is_array($response)) {
        //         $response = $response['results'];
        //         if ($response == null) {
        //             $value = '(tele_numero, tele_tipo) VALUES (:telefono, :tipotel)';
        //             $param = array(
        //                 'telefono' => $telefono,
        //                 'tipotel' => $tipotel
        //             );
        //             $data = $this->db->insert('telefono', $value, $param);
        //             if ($data) return 0;
        //             else return $data;
        //         } else {
        //             return 1;
        //         }
        //     } else {
        //         return $response;
        //     }
        // }
    }
