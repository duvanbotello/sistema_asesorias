<?php
class QueryManager
{
    private $pdo;
    public function __construct($user, $password, $db)
    {
        try {
            $this->pdo = new PDO(
                'mysql:host=localhost;dbname=' . $db . ';charset=utf8',
                $user,
                $password,
                [
                    PDO::ATTR_EMULATE_PREPARES => FALSE,
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
                ]
            );
        } catch (PDOException $e) {
            print "Error!: " . $e->getMessage();
            die();
        }
    }
    //creamos el metodo para hacer las consultas
    //pedimos como parametros las columnubas a consultas, el nombre de la tabla
    //la restriccion y los parametros de las restriciones
    function select($attr, $table, $where, $param)
    {
        try {
            //verificamos si el where trae datos.
            if ($where == "") {
                //si el where no trae datos se hace una consulta sin restricciones.
                $query = " SELECT " . $attr . " FROM " . $table;
            } else {
                //y si trae datos se hace la consulta con la restriccion
                $query = "SELECT " . $attr . " FROM " . $table . " WHERE " . $where;
            }
            //utilizo la clase pdo para almacer el query en sth
            $sth = $this->pdo->prepare($query);
            //ejecuto el query
            if($param == null){
                $sth->execute();
            }else{
                $sth->execute($param);
            }

            //guardo todos los datos de la consulta dentro de un array
            $response = $sth->fetchALL(PDO::FETCH_ASSOC);

            //retorno un array con el resultado
            return array("results" => $response);
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    // forma minimizada de la funcion select

    // function select($attr, $table, $where, $param) {
    //     try {
    //         if ($where == '') $query = "SELECT ".$attr." FROM ".$table;
    //         else $query = "SELECT ".$attr." FROM ".$table." WHERE ".$where;
    //         $sth = $this->pdo->prepare($query);
    //         if ($where == '') $sth->execute();
    //         else $sth->execute($param);

    //         $response = $sth->fetchAll(PDO::FETCH_ASSOC);

    //         return array('results' => $response);
    //     } catch (PDOException $e) {
    //         return $e->getMessage();
    //     }
    //     $pdo = null;
    // }

    function insert($table, $value, $param) {
        try {
            $query = 'INSERT INTO '.$table.$value;
            $sth = $this->pdo->prepare($query);
            $sth->execute($param);
            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function updateAsesor($documento, $nombres, $apellidos, $ubicacion, $correo, $fecha, $biografia) {
        try {
            $query = "UPDATE usuario SET usu_nombres = '$nombres', usu_apellidos = '$apellidos', usu_ubicacion = '$ubicacion', usu_correo = '$correo', usu_fechanac = '$fecha' WHERE usu_documento = '$documento'";
            $sth = $this->pdo->prepare($query);
            $sth->execute();
            $query = "UPDATE asesor SET usas_biografia = '$biografia' WHERE usuario_usu_documento = '$documento'";
            $sth2 = $this->pdo->prepare($query);
            $sth2->execute();
            if($sth && $sth2) return true;
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function updateEstudiante($documento, $nombres, $apellidos, $correo, $fecha) {
        try {
            $query = "UPDATE usuario SET usu_nombres = '$nombres', usu_apellidos = '$apellidos', usu_correo = '$correo', usu_fechanac = '$fecha' WHERE usu_documento = '$documento'";
            $sth = $this->pdo->prepare($query);
            $sth->execute();  
            if($sth) return true;
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function update($table, $field, $newValue, $where, $param) {
        try {
            $query = "UPDATE " . $table . " SET " . $field . " = '" . $newValue . "' WHERE " . $where;
            $sth = $this->pdo->prepare($query);
            $sth->execute($param);
            return true;
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function updateAll($table, $fields, $newValues, $where, $param) {
        try {
            $query = "UPDATE " . $table . " SET ";
            for ($i = 0; $i < count($fields); $i++) {
                $query .= $fields[$i] . " = '" . $newValues[$i] . "'";
                if((count($fields) - 1) != $i) $query .= ", ";
            }
            $query .= " WHERE " . $where;
            $sth = $this->pdo->prepare($query);
            $sth->execute($param);
            return true;
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function delete($table, $where, $params) {
        try {
            $query = "DELETE FROM " . $table . " WHERE " . $where;
            $sth = $this->pdo->prepare($query);
            $sth->execute($params);
            return 1;
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

    function EstadoHabitacion($idhabitacion)
    {
        try {
            $query = "UPDATE habitaciones SET estado = 1 WHERE idhabitaciones=$idhabitacion";
            $sth = $this->pdo->prepare($query);
            $sth->execute();
            return $sth->execute();
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }
    
    function getHabitaciones()
    {
        try {
            $query = "select h.idhabitaciones, i.url, h.numHabitacion, th.descripcion, th.precio, h.estado from habitaciones as h
                      inner join tipo_habitacion as th on h.tipo_habitacion  = th.idtipo_habitacion
                      inner join images as i on h.idhabitaciones = i.idhabitaciones
                    where h.estado = 2;";
            $sth = $this->pdo->prepare($query);
            $sth->execute();
            $response = $sth->fetchALL(PDO::FETCH_ASSOC);
            return array("results" => $response);
        } catch (PDOExepcion $e) {
            return $e->getMessage();
        }
        $pdo = null;
    }

}
?>
