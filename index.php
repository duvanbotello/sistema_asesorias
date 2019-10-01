<?php
require "config.php";
// $url = isset($_GET["url"]) ? $_GET["url"]:"Index/index";
$url = $_GET["url"] ?? "Index/index";
$url = explode("/", $url);

$controller = "";
$method = "";

if (isset($url[0])) {
    $controller = $url[0];
}
if (isset($url[1])) {
    if ($url[1] != " ") {
        $method = $url[1];
    }
}

// para llamar clases de carpeta library
spl_autoload_register(function($class){
    if (file_exists(LBS.$class.".php")) {
        require LBS.$class.".php";
    }
});
// $obj = new Controllers();

// llama al controlador error y lo instancia
require CON."Error.php";
$error = new Errors();

// para llamar clases de carpeta controllers
$controllerpath = CON.$controller.".php";
if (file_exists($controllerpath)) {
    require $controllerpath;
    // instanciamos de la clase
    $controller = new $controller();
    
    if (isset($method)) {
        if (method_exists($controller, $method)) {
            $controller->{$method}();
        }else {
            $error->error();
        }
    }
}else {
    $error->error();
}


?>