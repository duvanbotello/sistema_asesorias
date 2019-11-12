<?php
class Index_model extends Conexion
{
    public function __construct()
    {
        //Ejecutamos el metodos Constructor de la clase Conexion.
        parent::__construct();
    }

    function userLogin($email, $password)
    {
        //creo la restriccion
        $where = "usu_correo = :Correo";

        //creo un parametro llamado 'Email' y le asigno lo que venga por $email
        $param = array('Correo' => $email);
        //utilizo el objeto db que esta en la clase conexion y es una instancia de la clase QueryManager
        //para utilizar el metodo select y hacer la consulta a la base de datos
        $response = $this->db->select("*", 'usuario', $where, $param);

        //verifico si se devolvio un arrat
        if (is_array($response)) {
            //le coloco un index al array llamado results
            $response = $response['results'];
            if (0 != count($response)) {

                //verifico que el password enviado desde la vista se igual al almacenado en la BD
                if (password_verify($password, $response[0]["usu_contrasena"]) && $response[0]["usu_correo"] == $email) {
                    //si es correcto retorno un array con los datos del usuario.
                    
                    //creo una variable de session y envio los datos del usuario
                    if($response[0]["usu_rol_id"] == 1){
                        $res = $this->db->select("*", 'estudiante', "usuario_usu_documento = '".$response[0]["usu_documento"]."'", null);
                        $idEstudiante = $res['results'][0]['idestudiante'];
                        $res = $this->db->select("asesor_idasesor", 'recomendados', "estudiante_idestudiante = '$idEstudiante'", null);
                        $recomendados = json_encode($res['results']);
                        $data = array(
                            "num_documento" => $response[0]["usu_documento"],
                            "nombre" => $response[0]["usu_nombres"],
                            "apellido" => $response[0]["usu_apellidos"],
                            "tipo_documento" => $response[0]["tipodoc_id"],
                            "rol" => $response[0]["usu_rol_id"],
                            "correo" => $response[0]["usu_correo"],
                            "fecha" => $response[0]["usu_fechanac"],
                            "idEstudiante" => $idEstudiante,
                            "recomendados" => $recomendados
                        );
                        Session::setSession("estudiante", $data);
                    }else{
                        $data = array(
                            "num_documento" => $response[0]["usu_documento"],
                            "nombre" => $response[0]["usu_nombres"],
                            "apellido" => $response[0]["usu_apellidos"],
                            "tipo_documento" => $response[0]["tipodoc_id"],
                            "rol" => $response[0]["usu_rol_id"],
                            "correo" => $response[0]["usu_correo"],
                            "fecha" => $response[0]["usu_fechanac"]
                        );
                        Session::setSession("asesor", $data);
                    }
                    
                    return $data;
                } else {
                    //de lo contrario retorno IdUsuario 0, quiere decir que los datos de session son incorrectos.
                    $data = array("num_documento" => 0);
                    return $data;
                }
            } else {
                return "El email no esta registrado";
            }
        } else {
            return $response;
        }

    }

}
