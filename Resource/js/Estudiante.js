
class Estudiante {

    constructor() { }

    actualizarPassword(password) {
        $.post(URL + "Login/actualizarPassword", { password },
            res => {
                //console.log(res)
                if (res == 0) {
                    M.toast({ html: 'Contraseña actualizada', classes: 'rounded cyan darken-2' })
                    // $('#formActualizar')[0].reset()
                } else M.toast({ html: res })
            }
        )
    }







    cargarPerfilEstudiante() {
        const dataSession = JSON.parse(localStorage.getItem('estudiante'))
        let usuario = `<div class="card-content center-align">
        <img src="http://localhost/sistema_asesorias/logo.png" alt="" class="z-depth-3 responsive-img">
        <br>
        <h5 class="center-align" ><B id="NombreEstudiante">`+ dataSession.nombre  + ' ' + dataSession.apellido + `</B></h5>
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

        <button class="btn waves-effect waves-light " type="submit" name="action">Editar Perfil
            <i class="material-icons right">send</i>
        </button>


    </div>`;
        $('#body').append(usuario)


    }
    MaysPrimera(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
    actualizarAsesor(nombres, apellidos, ubicacion, correo, fecha, biografia) {
        const documento = JSON.parse(localStorage.getItem('asesor')).num_documento
        $.post(
            URL + "Asesor/actualizarAsesor",
            { documento, nombres, apellidos, ubicacion, correo, fecha, biografia },
            res => {
                try {
                    if (res == 1) {
                        document.getElementById('nombreAsesor').value = nombres
                        document.getElementById('apellidoAsesor').value = apellidos
                        document.getElementById('ubicacionAsesor').value = ubicacion
                        document.getElementById('correoAsesor').value = correo
                        document.getElementById('fechaAsesor').value = fecha
                        document.getElementById('biografiaAsesor').value = biografia
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
