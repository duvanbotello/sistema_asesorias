<?php
class Login_model extends Conexion
{
    public function __construct()
    {
        //Ejecutamos el metodos Constructor de la clase Conexion.
        parent::__construct();
    }
 
    function recuperarPassword($email)
    {
        $where = "usu_correo = :Correo";

        $param = array('Correo' => $email);

        $response = $this->db->select("*", 'usuario', $where, $param);

        if (is_array($response)) {

            $response = $response['results'];

            if (0 != count($response)) {

                $nombre = $response[0]["usu_nombres"];
                $url = "http://localhost/sistema_asesorias/Login/cargaActualizar";

                // primero hay que incluir la clase phpmailer para poder instanciar un objeto de la misma
                require "includes/class.phpmailer.php";
                $mail = new PHPMailer();

                //Con PluginDir le indicamos a la clase phpmailer donde se encuentra la clase smtp 
                $mail->PluginDir = "includes/";

                // Le indicamos que vamos a usar un servidor smtp
                $mail->IsSMTP();
                $mail->SMTPSecure = "ssl";
                // $mail->SMTPDebug = 1;
                
                //Asignamos a Host el smtp a utilizar
                $mail->Host = "ssl://smtp.gmail.com";
                $mail->Port = 465;
                
                //Le indicamos que el servidor smtp requiere autenticación
                $mail->SMTPAuth = true;

                //Le decimos cual es nuestro nombre de usuario(correo) y password
                $mail->Username = "daniel.dal029@gmail.com"; 
                $mail->Password = "";

                //Indicamos cual es nuestra dirección de correo y el nombre que 
                //queremos que vea el usuario que lee nuestro correo
                $mail->setFrom("daniel.dal029@gmail.com", "Admin Daniel Luna - Asesorias");

                //Indicamos cual es la dirección de destino del correo
                $mail->AddAddress($email);

                // El correo se envía como HTML 
                $mail->IsHTML(true);
                
                //Asignamos asunto y cuerpo del mensaje
                $mail->Subject = "Cambio de contraseña - Asesorias";
                $mail->Body = "Hola $nombre: <br /><br />Se ha solicitado un reinicio de contraseña. <br/><br/>Para restaurar la contraseña, visita la siguiente direcci&oacute;n: <a href='$url'>$url</a>";

                //se envia el mensaje, si no ha habido problemas la variable $exito tendra el valor true
                $exito = $mail->Send();

                //Si el mensaje no ha podido ser enviado se realizaran 4 intentos mas como mucho 
                //para intentar enviar el mensaje, cada intento se hara 5 segundos despues 
                //del anterior, para ello se usa la funcion sleep	
                // $intentos=1; 
                // while ((!$exito) && ($intentos < 5)) {
                //     sleep(5);
                //     //echo $mail->ErrorInfo;
                //     $exito = $mail->Send();
                //     $intentos=$intentos+1;
                // }
                
                if(!$exito) {
                    echo "Problemas enviando correo electrónico";
                    echo "<br/>".$mail->ErrorInfo;	
                } else {
                    echo "Mensaje enviado correctamente";
                } 

            } else {
                return "El email no esta registrado";
            }
        } else {
            return $response;
        }
    }

    function actualizarPassword($password)
    {
        
    }
}
