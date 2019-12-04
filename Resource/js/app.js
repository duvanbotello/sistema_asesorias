
$(document).ready(function(){
    // cargar selects del formulario registro
    $('select').formSelect()

})

function ocultarCampos() {
    elem = document.getElementById("cont-exp");
    elem2 = document.getElementById("cont-bio");
    elem3 = document.getElementById("cont-fcrea");
    elem4 = document.getElementById("cont-asi");
    select = document.getElementById("tiporol");
    if (select.value == 2) {
        cargarAsignaturas();
        elem.style.display = 'block';
        elem2.style.display = 'block';
        elem3.style.display = 'block';
        elem4.style.display = 'block';
    }else if (select.value == 1 || select.value == 0){
        elem.style.display = 'none';
        elem2.style.display = 'none';
        elem3.style.display = 'none';
        elem4.style.display = 'none';
    }
}


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
    let asignaturas = localStorage.getItem('asignaturas')
    var nombres = window.document.getElementById('nombres')
    var apellidos = window.document.getElementById('apellidos')
    var fechanac = window.document.getElementById('fechanac')
    var tipodoc = window.document.getElementById('tipodoc')
    var documento = window.document.getElementById('documento')
    var ubicacion = window.document.getElementById('ubicacion')
    var tipotel = window.document.getElementById('tipotel')
    var telefono = window.document.getElementById('numtel')
    var tiporol = window.document.getElementById('tiporol')
    var experiencia = window.document.getElementById('experiencia')
    var biografia = window.document.getElementById('biografia')
    var fechacrea = window.document.getElementById('fechacrea')
    var email = window.document.getElementById('email')
    var password = window.document.getElementById('password')
    var password2 = window.document.getElementById('password2')
    
    if (validarNombre(nombres) && validarNombre(apellidos) && validarTipoDoc(tipodoc) && validarDocumento(documento) && validarUbicacion(ubicacion) && validarTipoTel(tipotel) && validarTelefono(telefono) && validarTipoRol(tiporol) && validarCorreo(email) && validarContrasena(password) && validarContrasena(password2)) {
        if (password.value === password2.value) {
            if (tiporol.value == 2 && validarExperiencia(experiencia) && validarBiografia(biografia)) {
                if(JSON.parse(asignaturas).asignaturas.length > 0) {
                    asignaturas = createJsonIdOnly(JSON.parse(asignaturas).asignaturas)
                    usuario.registrar(nombres.value, apellidos.value, fechanac.value, tipodoc.value, documento.value, ubicacion.value, tipotel.value, telefono.value, tiporol.value, experiencia.value, biografia.value, fechacrea.value, email.value, password.value, JSON.stringify({ asignaturas }))
                } else M.toast({ html: 'Debes tener por lo menos una materia para asesorar', classes: 'rounded yellow darken-2' })
            } else {
                usuario.registrar(nombres.value, apellidos.value, fechanac.value, tipodoc.value, documento.value, ubicacion.value, tipotel.value, telefono.value, tiporol.value, experiencia.value, biografia.value, fechacrea.value, email.value, password.value, "")
            }
        }
        else M.toast({ html: 'Tus contraseñas no coinciden', classes: 'rounded yellow darken-2' })
    }
}

function createJsonIdOnly(array) {
    let newArray = []
    array.forEach(ele => {
        newArray.push(ele.id)
    });
    return newArray
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

function recomendarAsesor(idAsesor, starId) {
    const estudiante = JSON.parse(localStorage.getItem('estudiante'))
    if(estudiante) usuario.recomendarAsesor(estudiante.idEstudiante, idAsesor, starId)
    else M.toast({ html: `Es necesario que inicies sesión`, classes: 'rounded yellow darken-2' })
}

function cargarAsignaturas() {
    $.get(
        URL + "Registro/obtenerAsignaturas",
        {},
        res => {
            try {
                let data = JSON.parse(res)
                data = data.results
                let options = `<option selected value="0">Selecciona tu asignatura...</option>`
                for (let i = 0; i < data.length; i++) {
                    options += `<option value="${data[i].asig_id}">${data[i].asig_nombre}</option>`
                }
                $("#combo_asignaturas").append(options)
                M.FormSelect.init(document.querySelectorAll('select'));//Importante para la renderización de los select
            } catch (err) {
                M.toast({ html: err, classes: 'rounded red darken-2' })
            }
        }
    )
}

function agregarAsignatura() {
    try {
        const asig = $('#combo_asignaturas option:selected')
        const obj = {
            id: asig.val(),
            nombre: asig.text()
        }
        if(asig.val() == 0) M.toast({ html: "Debes seleccionar una asignatura", classes: 'rounded yellow darken-2' })
        else {
            if(localStorage.getItem('asignaturas')) {
                let asignaturasCookie = localStorage.getItem('asignaturas')
                let asignaturas = (JSON.parse(asignaturasCookie)).asignaturas
                const repeat = asignaturas.filter(a => a.id === asig.val())
                if(repeat.length > 0) {
                    M.toast({ html: "Ya seleccionaste esta asignatura", classes: 'rounded yellow darken-2' })
                } else {
                    asignaturas.push(obj)
                    localStorage.setItem('asignaturas', JSON.stringify({ asignaturas }))
                    M.toast({ html: "Asignatura agregada", classes: 'rounded cyan darken-2' })
                    $('#cont-asignaturas').append(`<div id="divasig${asig.val()}" onclick="removerAsignatura('${asig.val()}', 'divasig${asig.val()}')" class="cyan darken-2 contenedorAsignaturas hand col s4"><p>${asig.text()}</p></div>`)
                }
            } else {
                asignaturas = [obj]
                localStorage.setItem('asignaturas', JSON.stringify({ asignaturas }))
                M.toast({ html: "Asignatura agregada", classes: 'rounded cyan darken-2' })
                $('#cont-asignaturas').append(`<div id="divasig${asig.val()}" onclick="removerAsignatura('${asig.val()}', 'divasig${asig.val()}')" class="cyan darken-2 contenedorAsignaturas hand col s4"><p>${asig.text()}</p></div>`)
            }
        }
    } catch (err) {
        console.log(err)
    }
}

function removerAsignatura(id, divid) {
    try {
        let asignaturasCookie = localStorage.getItem('asignaturas')
        let asignaturasAntiguas = (JSON.parse(asignaturasCookie)).asignaturas
        const asignaturas = asignaturasAntiguas.filter(a => a.id !== id)
        localStorage.setItem('asignaturas', JSON.stringify({ asignaturas }))
        M.toast({ html: "Asignatura removida", classes: 'rounded red darken-2' })
        $(`#${divid}`).remove()   
    } catch (err) {
        console.log(err)
    }
}

function openFormAsesoria() {
    $('#cuenta-card').css("display", "block")
    location.href = "#cuenta-card"
}

function agendarAsesoria() {
    if(localStorage.getItem('estudiante')) {
        const idestudiante = JSON.parse(localStorage.getItem('estudiante')).idEstudiante
        const idasesor = JSON.parse(localStorage.getItem('perfilasesor')).idasesor
        const idasignatura = document.getElementById('combo_asignaturasasesor').value
        const fecha = document.getElementById('fechaagenda').value
        const horainicial = document.getElementById('horainicial').value
        const horafinal = document.getElementById('horafinal').value
        if(idestudiante && idasesor && idasignatura != 0 && fecha && horainicial && horafinal) {
            let f = new Date(fecha)
            let fechaelegida = new Date(f.setDate(f.getDate() + 1))
            fechaelegida = new Date(fechaelegida.setHours(0))
            if(fechaelegida > new Date()) estudiante.agendarAsesoria(fecha, horainicial, horafinal, idasignatura, idasesor, idestudiante)
            else M.toast({ html: "Solo puedes agendar con un día de anticipación", classes: 'rounded yellow darken-2' })
        } else M.toast({ html: "Debes suministrar todos los datos", classes: 'rounded yellow darken-2' })
    } else M.toast({ html: "Debes iniciar sesión", classes: 'rounded yellow darken-2' })
}

$().ready(()=>{
    let URLactual = window.location.pathname;
    usuario.userData(URLactual);
    if(URLactual == '/sistema_asesorias/Buscar/carga' || URLactual == '/sistema_asesorias/Index/index' || URLactual == '/sistema_asesorias/') {
        const estudiante = JSON.parse(localStorage.getItem('estudiante'))
        if(estudiante) usuario.iniciarSesion(estudiante.correo, localStorage.getItem('user_pass'))
        usuario.cargarAsesores('Todos')
    }
    if(URLactual == '/sistema_asesorias/Perfil/asesor') usuario.cargarPerfilAsesor()
    if(URLactual == '/sistema_asesorias/Asesor/miperfil') usuario.cargarPerfilPropioAsesor()
    if(URLactual == '/sistema_asesorias/Estudiante/miperfil') estudiante.cargarPerfilEstudiante()
    if(URLactual == '/sistema_asesorias/Estudiante/EditarPerfil') estudiante.cargarEditarPerfilEstudiante()
    if(URLactual == '/sistema_asesorias/Registro/carga') localStorage.clear()
    if(URLactual == '/sistema_asesorias/Estudiante/miperfil') estudiante.cargarAsesoriasAgendadas()

})