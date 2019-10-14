
// cargar selects del formulario registro
$(document).ready(function(){
    $('select').formSelect()
})

// instanciamos las clases necesarias
var usuario = new Usuario();

var iniciarSesion = ()=>{
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    usuario.iniciarSesion(email, password);
}

var sessionClose = () => {
    usuario.sessionCLose();
}
var sessionCloseAsesor = () => {
    usuario.sessionCLoseAsesor();
}

var recuperarPassword = () => {
    var email = window.document.getElementById("email2")
    if (validarCorreo(email)) usuario.recuperarPassword(email.value)
}

var actualizarPassword = () => {
    var password = window.document.getElementById('password')
    var password2 = window.document.getElementById('password2')
    if (validarContrasena(password) && validarContrasena(password2)) {
        if (password.value === password2.value) usuario.actualizarPassword(password.value)
        else M.toast({ html: 'Tus contraseñas no coinciden', class: 'rounded cyan darken-2' })
    }
}

var registrar = () => {
    var nombres = window.document.getElementById('nombres')
    var apellidos = window.document.getElementById('apellidos')
    var fechanac = window.document.getElementById('fechanac')
    var tipodoc = window.document.getElementById('tipodoc')
    var documento = window.document.getElementById('documento')
    var tipotel = window.document.getElementById('tipotel')
    var telefono = window.document.getElementById('numtel')
    var tiporol = window.document.getElementById('tiporol')
    var email = window.document.getElementById('email')
    var password = window.document.getElementById('password')
    var password2 = window.document.getElementById('password2')
    if (validarNombre(nombres) && validarNombre(apellidos) && validarTipoDoc(tipodoc) && validarDocumento(documento) && validarTipoTel(tipotel) && validarTelefono(telefono) && validarTipoRol(tiporol) && validarCorreo(email) && validarContrasena(password) && validarContrasena(password2) && confirm('¿deseas registrar esta persona?')) {
        if (password.value === password2.value) usuario.registrar(nombres.value, apellidos.value, fechanac.value, tipodoc.value, documento.value, tipotel.value, telefono.value, tiporol.value, email.value, password.value)
        else M.toast({ html: 'Tus contraseñas no coinciden', class: 'rounded cyan darken-2' })
    }
}

$().ready(()=>{

});
