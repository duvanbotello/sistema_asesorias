
class Usuario{
    constructor(){

    }

    iniciarSesion(email, password) {

        //verifica que el campo email contenga datos.
        if (email == "") {
            //el .focus útil para posicionarnos en un campo concreto de un formulario, ya sea al principio del formulario
            //o por validaciones que vayamos haciendo y que nos hagan ir a otro campo del formulario.
            document.getElementById("email").focus();
            //toast para mandar mensajes
            M.toast({html: 'Ingrese direccion de correo', classes: 'rounded cyan darken-2'})
        } else {
            //si el campo del email tieLone datos verifica el de la pasword
            if (password == "") {
                document.getElementById("password").focus();
                M.toast({html: 'Ingrese Contraseña', classes: 'rounded cyan darken-2'})
            } else {
                //valida utilizan la funcion validarEmail que esta en Funciones
                //verificar si el email es valido

                if (validarEmail(email)) {

                    //para enviar nuestros datos por post al servidor
                    //le enviamos como parametro la ruta del controlador
                    //y optenemos respuesta atraves de response.

                    $.post(URL + "Index/userLogin", { email, password }, (response) => {
                        console.log(response)
                        try {

                            //paso los datos del vector response que envian desde el servidor
                            //con JSON para manejarlos en la vista.

                            var item = JSON.parse(response);

                            //Verifico que el idUsuario sea mayor a 0 para verificar que el inicio de
                            //session sea valido.

                            if (0 < item.idusuario) {
                                //el metodo localstore nos permite crear elementos para almacenarlos
                                //en la memoria de nuestro navegador
                                //con tiene la llave user y almacena la informacion de response
                                localStorage.setItem("estudiante", response);
                                //si el inicio de session es correcto lo enviamos al controlador Principal
                                //para que abra la vista principal
                                window.location.href = URL + "Index/index";
                            } else {
                                //de lo contrario mostramos un mensaje de error
                                M.toast({html: 'Contraseña Incorrecta', classes: 'rounded cyan darken-2'})
                            }
                        } catch (response) {
                            //por si susece algun error en el proceimiento
                            M.toast({html: 'Correo no registrado', classes: 'rounded cyan darken-2'})

                        }
                    });

                } else {
                    document.getElementById("email").focus();
                    M.toast({html: 'Ingrese direccion de correo valida', classes: 'rounded cyan darken-2'})
                }
            }
        }
    }
    sessionCLose() {
        localStorage.removeItem("estudiante");
    }

    registrarEstudiante (nombres, apellidos, fechanac, documento, telefono, email, password) {
        $.post(
            URL + 'Registro/registrarEstudiante',
            {nombres, apellidos, fechanac, documento, telefono, email, password},
            res => {
                //console.log(res)
                if (res == 0) {
                    M.toast({ html: 'Estudiante registrado satisfactoriamente', classes: 'rounded cyan darken-2' })
                    $('#formRegistroEstudiante')[0].reset()
                } else M.toast({ html: res })
            }
        )
    }
}
