
<?php
//esta clase es la encargada de gestionar la conexion a la base de datos.
class Conexion{
    function __construct(){
        //ejecutamos la clase QueryManager
        $this->db = new QueryManager('root','','hotelalamo');
       
    }
}
?>