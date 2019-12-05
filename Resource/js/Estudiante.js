
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

    agendarAsesoria(fecha, horainicial, horafinal, idasignatura, idasesor, idestudiante) {
        $.post(
            URL + "Asesoria/registrar",
            {fecha, horainicial, horafinal, idasignatura, idasesor, idestudiante},
            res => {
                try {
                    if(res == 1) {
                        $('#cuenta-card').css("display", "none")
                        location.href = "#perfil-asesor"
                        M.toast({ html: 'Asesoría agendada con éxito', classes: 'rounded cyan darken-2' })
                    } else M.toast({ html: res, classes: 'rounded red darken-2' })
                } catch (err) {
                    M.toast({ html: err, classes: 'rounded red darken-2' })
                }
            }
        )
    }

    cargarAsesoriasAgendadas() {
        const idEstudiante = JSON.parse(localStorage.getItem('estudiante')).idEstudiante
        $.get(
            URL + "Estudiante/obtenerAsesorias",
            { idEstudiante },
            res => {
                try {
                    let data = JSON.parse(res)
                    let body = ""
                    let asesoriasPasadas = []
                    const NOW = new Date()
                    data.results.forEach(ele => {
                        let date = ele.ase_fecha.split(' ')[0]
                        date = date.split('-')
                        let fecha = new Date(Date.parse(date))
                        fecha = new Date(fecha.setHours(ele.ase_horafinal.split(':')[0]))
                        fecha = new Date(fecha.setMinutes(ele.ase_horafinal.split(':')[1]))
                        if(fecha < NOW) {
                            asesoriasPasadas.push(ele)
                        } else {
                            body += `<li id="cont-ase-${ele.ase_id}" class="collection-item avatar">
                                        <i class="material-icons circle">view_agenda</i>
                                        <p><b>Asesor :</b> ${ele.usu_nombres}</p>
                                        <p><b>Fecha :</b> ${ele.ase_fecha.split(' ')[0]}</p>
                                        <p><b>Hora :</b> ${ele.ase_horainicial} - ${ele.ase_horafinal}</p>
                                        <p><b>Asignatura:</b> ${ele.asig_nombre}</p>`
                            if(ele.ase_estado == 0) {
                                body += `<p><b>Estado:</b> Pendiente</p>`
                            } else if(ele.ase_estado == 1) {
                                body += `<p><b>Estado:</b> Aceptada</p>`
                            } else if(ele.ase_estado == -1) {
                                body += `<p><b>Estado:</b> Rechazada</p>`
                            }
                            body += `   <br>
                                        <div class="row">`
                            if(ele.ase_estado == 0) {
                                body += `   <button onclick="verComentariosAsesoria(${ele.ase_id})" class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                                <i class="material-icons right">send</i>
                                            </button>
                                            <button onclick="eliminarAsesoria(${ele.ase_id}, 'cont-ase-${ele.ase_id}')" class="col s6 red darken-2 btn-small" type="submit" name="action">Cancelar Asesoría
                                                <i class="material-icons right">close</i>
                                            </button>`
                            } else if(ele.ase_estado == 1 || ele.ase_estado == -1) {
                                body += `   <button onclick="verComentariosAsesoria(${ele.ase_id})" class="col s12 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                                <i class="material-icons right">send</i>
                                            </button>`
                            }
                            body += `   </div>
                                    </li>`
                        }
                    });
                    asesoriasPasadas.forEach(ele => {
                        body += `<li id="cont-ase-${ele.ase_id}" class="collection-item avatar">
                                    <i class="material-icons circle">view_agenda</i>
                                    <h5 style="color: red; text-align: center;"><b>Caducada</b></h5>
                                    <p><b>Asesor :</b> ${ele.usu_nombres}</p>
                                    <p><b>Fecha :</b> ${ele.ase_fecha.split(' ')[0]}</p>
                                    <p><b>Hora :</b> ${ele.ase_horainicial} - ${ele.ase_horafinal}</p>
                                    <p><b>Asignatura:</b> ${ele.asig_nombre}</p>`
                        if(ele.ase_estado == 0) {
                            body += `<p><b>Estado:</b> Pendiente</p>`
                        } else if(ele.ase_estado == 1) {
                            body += `<p><b>Estado:</b> Aceptada</p>`
                        } else if(ele.ase_estado == -1) {
                            body += `<p><b>Estado:</b> Rechazada</p>`
                        }
                        body += `   <br>
                                    <div class="row">`
                        if(ele.ase_estado == 0) {
                            body += `   <button onclick="verComentariosAsesoria(${ele.ase_id})" class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                            <i class="material-icons right">send</i>
                                        </button>
                                        <button onclick="eliminarAsesoria(${ele.ase_id}, 'cont-ase-${ele.ase_id}')" class="col s6 red darken-2 btn-small" type="submit" name="action">Cancelar Asesoría
                                            <i class="material-icons right">close</i>
                                        </button>`
                        } else if(ele.ase_estado == 1) {
                            body += `   <button onclick="verComentariosAsesoria(${ele.ase_id})" class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                            <i class="material-icons right">send</i>
                                        </button>
                                        <button onclick="verCalificacion('cont-cal-ase-${ele.ase_id}')" class="col s6 green light-2 btn-small" type="submit" name="action">Ver Calificación
                                            <i class="material-icons right">remove_red_eye</i>
                                        </button>`
                        } else if(ele.ase_estado == -1) {
                            body += `   <button onclick="verComentariosAsesoria(${ele.ase_id})" class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                            <i class="material-icons right">send</i>
                                        </button>
                                        <button onclick="eliminarAsesoria(${ele.ase_id}, 'cont-ase-${ele.ase_id}')" class="col s6 red darken-2 btn-small" type="submit" name="action">Cancelar Asesoría
                                            <i class="material-icons right">close</i>
                                        </button>`
                        }
                        body += `   </div>`
                        if(ele.ase_estado == 1) {
                            body += `<div style="display: none;" id="cont-cal-ase-${ele.ase_id}">
                                        <div class="row">
                                            <div class="input-field col s6">
                                                <i class="material-icons prefix">create</i>
                                                <input id="cal-ase-${ele.ase_id}" type="number" min="0" max="10" value="${ele.ase_calificacion}">
                                                <label for="cal-ase-${ele.ase_id}">Calificación</label>
                                            </div>
                                            <div class="input-field col s6">
                                                <i class="material-icons prefix">create</i>
                                                <textarea id="obs-ase-${ele.ase_id}" class="materialize-textarea" data-length="300">${ele.ase_observacion}</textarea>
                                                <label for="obs-ase-${ele.ase_id}">Observaciones</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <button onclick="calificarAsesoria('cont-cal-ase-${ele.ase_id}', 'cal-ase-${ele.ase_id}', 'obs-ase-${ele.ase_id}', ${ele.ase_id})" class="col s12 green light-2 btn-small" type="submit" name="action">Calificar Asesoría
                                                <i class="material-icons right">create</i>
                                            </button>
                                        </div>
                                    </div>`
                        }
                        body += `</li>`
                    });
                    $('#listaAsesorias').append(body)
                } catch (err) {
                    M.toast({ html: err, classes: 'rounded red darken-2' })
                }
            }
        )
    }

}
