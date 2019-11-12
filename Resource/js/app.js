
// cargar selects del formulario registro
$(document).ready(function(){
    $('select').formSelect()
})

// instanciamos las clases necesarias
var usuario = new Usuario();
var estudiante = new Estudiante();

var iniciarSesion = ()=>{
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    usuario.iniciarSesion(email, password); 
}

var EditarPerfil = ()=>{
    window.location = 'http://localhost/sistema_asesorias/Estudiante/EditarPerfil'
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
        else M.toast({ html: 'Tus contraseñas no coinciden', classes: 'rounded cyan darken-2' })
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
        else M.toast({ html: 'Tus contraseñas no coinciden', classes: 'rounded cyan darken-2' })
    }
}

function cargarAsesores(tipo) {
    M.toast({ html: `Asesores según ${tipo}`, classes: 'rounded cyan darken-2' })
    usuario.cargarAsesores(tipo)
}

function verPerfilAsesor(document) {
    usuario.verPerfilAsesor(document)
}

function buscarAsesor() {
    let filtroAsesor = document.getElementById('buscadorPrincipal').value
    usuario.cargarAsesores(filtroAsesor)
}

function actualizarAsesor() {
    let nombres = document.getElementById('nombreAsesor')
    let apellidos = document.getElementById('apellidoAsesor')
    let ubicacion = document.getElementById('ubicacionAsesor')
    let correo = document.getElementById('correoAsesor')
    let fecha = document.getElementById('fechaAsesor')
    let biografia = document.getElementById('biografiaAsesor')
    if(validarNombre(nombres) && validarNombre(apellidos) && validarUbicacion(ubicacion) && validarCorreo(correo) && biografia.value != '')
        usuario.actualizarAsesor(nombres.value, apellidos.value, ubicacion.value, correo.value, fecha.value, biografia.value)
}

function actualizarEstudiante() {
    let nombres = document.getElementById('nombreEstu')
    let apellidos = document.getElementById('apellidoEstu')
    let correo = document.getElementById('correoEstu')
    let fecha = document.getElementById('fechaEstu')
    if(validarNombre(nombres) && validarNombre(apellidos) && validarCorreo(correo))
        estudiante.actualizarEstudiante(nombres.value, apellidos.value, correo.value, fecha.value)
    alert('Inicia Sesion de Nuevo para Validar tus Cambios')
    sessionClose()
    window.location = 'http://localhost/sistema_asesorias/Index/destroySession'
   
}

$().ready(()=>{
    let URLactual = window.location.pathname;
    usuario.userData(URLactual);
    if(URLactual == '/sistema_asesorias/Buscar/carga' || URLactual == '/sistema_asesorias/Index/index' || URLactual == '/sistema_asesorias/') usuario.cargarAsesores('Todos')
    if(URLactual == '/sistema_asesorias/Perfil/asesor') usuario.cargarPerfilAsesor()
    if(URLactual == '/sistema_asesorias/Asesor/miperfil') usuario.cargarPerfilPropioAsesor()
    if(URLactual == '/sistema_asesorias/Estudiante/miperfil') estudiante.cargarPerfilEstudiante()
    if(URLactual == '/sistema_asesorias/Estudiante/EditarPerfil') estudiante.cargarEditarPerfilEstudiante()
    
})
