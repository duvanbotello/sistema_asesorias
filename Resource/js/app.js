
// codigo de Estudiantes (Usuarios)
var usuario = new Usuario();

$(document).ready(function(){
    $('select').formSelect()
})

var iniciarSesion = ()=>{
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    usuario.iniciarSesion(email, password);
}

var sessionClose = () => {
    usuario.sessionCLose();
}

var registrarEstudiante = () => {
    var nombres = window.document.getElementById('nombres')
    var apellidos = window.document.getElementById('apellidos')
    var fechanac = window.document.getElementById('fechanac')
    var documento = window.document.getElementById('documento')
    var telefono = window.document.getElementById('numtel')
    var email = window.document.getElementById('email')
    var password = window.document.getElementById('password')
    var password2 = window.document.getElementById('password2')
    if (validarNombre(nombres) && validarNombre(apellidos) && validarDocumento(documento) && validarTelefono(telefono) && validarCorreo(email) && validarContrasena(password) && validarContrasena(password2) && confirm('¿deseas registrar esta persona?')) {
        if (password.value === password2.value) usuario.registrarEstudiante(nombres.value, apellidos.value, fechanac.value, documento.value, telefono.value, email.value, password.value)
        else M.toast({ html: 'Tus contraseñas no coinciden', class: 'rounded' })
    }
}

$().ready(()=>{

});
