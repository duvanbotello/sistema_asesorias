
class Estudiante {

    constructor() { }

    cargarPerfilEstudiante() {
        const dataSession = JSON.parse(localStorage.getItem('estudiante'))
        let usuario = `<div class="card-content center-align">
        <img src="http://localhost/sistema_asesorias/logo.png" alt="" class="z-depth-3 responsive-img">
        <br>
        <h5 class="center-align" ><B id="NombreEstudiante">`+ dataSession.nombre + ' ' + dataSession.apellido + `</B></h5>
        <div class="row ">
            <div class="col s1">
                <i class="material-icons">mail</i>
            </div>
            <div class="col s11">
                <h7 class="center-align" id="CorreoEstudiante">`+ dataSession.correo + `</h7>
            </div>
        </div>
        <div class="row">
            <div class="col s1">
                <i class="material-icons">date_range</i>
            </div>
            <div class="col s11">
                <h7 class="center-align" id="fechaEstudiante">`+ dataSession.fecha + `</h7>
            </div>
        </div>
        <div class="row">
            <div class="col s1">
                <i class="material-icons">settings_cell</i>
            </div>
            <div class="col s11">
                <h7 class="center-align" id="TelefonoEstudiante">5760677</h7>
            </div>
        </div>

        <button class="btn waves-effect waves-light " type="submit" onclick="EditarPerfil()" name="action">Editar Perfil
            <i class="material-icons right">send</i>
        </button>


    </div>`;
        $('#body').append(usuario)


    }

    cargarEditarPerfilEstudiante() {
        const dataSession = JSON.parse(localStorage.getItem('estudiante'))

        document.getElementById('nombreEstu').value = dataSession.nombre;
        document.getElementById('apellidoEstu').value = dataSession.apellido;
        document.getElementById('correoEstu').value = dataSession.correo;
        document.getElementById('fechaEstu').value = dataSession.fecha;

    }

    actualizarEstudiante(nombres, apellidos, correo, fecha) {
        const documento = JSON.parse(localStorage.getItem('estudiante')).num_documento
        $.post(
            URL + "Estudiante/actualizarEstudiante",
            { documento, nombres, apellidos,  correo, fecha},
            res => {
                console.log(res)
                try {
                    if (res == 1) {
                        document.getElementById('nombreEstu').value = nombres
                        document.getElementById('apellidoEstu').value = apellidos
                        document.getElementById('correoEstu').value = correo
                        document.getElementById('fechaEstu').value = fecha
                        M.toast({ html: 'Datos actualizados', classes: 'rounded cyan darken-2' })
                    } else {
                        M.toast({ html: res, classes: 'rounded yellow darken-2' })
                    }
                } catch (err) {
                    M.toast({ html: err, classes: 'rounded red darken-2' })
                }
            }
        )
    }

}
