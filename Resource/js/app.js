
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

var registrar = () => {
    var tipodoc = window.document.getElementById('tipodoc')
    var nombres = window.document.getElementById('nombres')
    var apellidos = window.document.getElementById('apellidos')
    var fechanac = window.document.getElementById('fechanac')
    var documento = window.document.getElementById('documento')
    var tiporol = window.document.getElementById('tiporol')
    var tipotel = window.document.getElementById('tipotel')
    var telefono = window.document.getElementById('numtel')
    var email = window.document.getElementById('email')
    var password = window.document.getElementById('password')
    var password2 = window.document.getElementById('password2')
    if (validarTipoDoc(tipodoc) && validarNombre(nombres) && validarNombre(apellidos) && validarDocumento(documento) && validarTipoRol(tiporol) && validarTipoTel(tipotel) && validarTelefono(telefono) && validarCorreo(email) && validarContrasena(password) && validarContrasena(password2) && confirm('¿deseas registrar esta persona?')) {
        if (password.value === password2.value) usuario.registrar(tipodoc.value, nombres.value, apellidos.value, fechanac.value, documento.value, tiporol.value, tipotel.value, telefono.value, email.value, password.value)
        else M.toast({ html: 'Tus contraseñas no coinciden', class: 'rounded cyan darken-2' })
    }
}

$().ready(()=>{

});
