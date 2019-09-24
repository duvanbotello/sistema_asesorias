
var validarEmail = (email)=>{
    //expresion regex de javascript para poder validar un correo.
    let regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (regex.test(email)) {
        // si el correo es valido
        return true;
    }else{
        return false;
    }
}
