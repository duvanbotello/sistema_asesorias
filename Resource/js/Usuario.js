
class Usuario{
    constructor(){
        
    }

    iniciarSesion(email, password){
        if (email == "") {
            document.getElementById("email").focus();
            M.toast({html: 'Ingrese direccion de correo', classes: 'rounded cyan darken-4'})
        }else{
            if (password == "") {
                document.getElementById("password").focus();
                M.toast({html: 'Ingrese la contraseña', classes: 'rounded cyan darken-4'})
            }else{
                // si el correo o la contraseña no estan vacios pasamos a comprobar si son validos
                if (validarEmail(email)) {
                    // si el correo es valido se pasa a comprobar la contraseña
                    if (5 <= password.length) {
                        // como el correo y contraseña son validos vamos a capturar esos datos
                        $.post(
                            "Index/userLogin",
                            {email, password},
                            (response)=>{
                                console.log(response);
                            }
                        );
                    }else{
                        document.getElementById("password").focus();
                        M.toast({html: 'Ingrese al menos 5 caracteres', classes: 'rounded cyan darken-4'})
                    }
                }else{
                    document.getElementById("email").focus();
                    M.toast({html: 'Ingrese direccion de correo valida', classes: 'rounded cyan darken-4'})
                }
            }
        }
    }
}