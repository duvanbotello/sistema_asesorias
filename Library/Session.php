<?php
class Session{
    static function star(){
        //estamos inicializando la opcion para crear variables de session
        //y poder optener la informacion de estas variables de session
        @session_start();
    }
    //metodo par obtener la informacion de una variable de session
    static function getSession($name){
        return $_SESSION[$name];
    }
    //una funcion para crear las variablles de session
    //el parametro name optiene el nombre de la variable
    //y data contiene los datos de esa nueva variable de session
    static function setSession($name,$data){
        return $_SESSION[$name] = $data;
    }
    //para destruir las variables de session
    static function destroy(){
        @session_destroy();
    }
}
?>