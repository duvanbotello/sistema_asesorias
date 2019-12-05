
class Asesor {

    constructor() { }

    cargarAsesoriasAgendadas() {
        const idAsesor = JSON.parse(localStorage.getItem('asesor')).idasesor
        $.get(
            URL + "Asesor/obtenerAsesorias",
            { idAsesor },
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
                                        <p><b>Estudiante :</b> ${ele.usu_nombres}</p>
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
                                body += `   <button class="col s4 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                                <i class="material-icons right">send</i>
                                            </button>
                                            <button onclick="actualizarAsesoria(${ele.ase_id}, '1')"  class="col s4 green light-2 btn-small" type="submit" name="action">Aceptar Asesoría
                                                <i class="material-icons right">check</i>
                                            </button>
                                            <button onclick="actualizarAsesoria(${ele.ase_id}, '-1')" class="col s4 red darken-2 btn-small" type="submit" name="action">Rechazar Asesoría
                                                <i class="material-icons right">close</i>
                                            </button>`
                            } else if(ele.ase_estado == 1) {
                                body += `   <button class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                                <i class="material-icons right">send</i>
                                            </button>
                                            <button onclick="actualizarAsesoria(${ele.ase_id}, '-1')" class="col s6 red darken-2 btn-small" type="submit" name="action">Rechazar Asesoría
                                                <i class="material-icons right">close</i>
                                            </button>`
                            } else if(ele.ase_estado == -1) {
                                body += `   <button class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                                <i class="material-icons right">send</i>
                                            </button>
                                            <button onclick="actualizarAsesoria(${ele.ase_id}, '1')"  class="col s6 green light-2 btn-small" type="submit" name="action">Aceptar Asesoría
                                                <i class="material-icons right">check</i>
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
                                    <p><b>Estudiante :</b> ${ele.usu_nombres}</p>
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
                        if(ele.ase_estado == 0 || ele.ase_estado == -1) {
                            body += `   <button class="col s12 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                            <i class="material-icons right">send</i>
                                        </button>`
                        } else if(ele.ase_estado == 1) {
                            body += `   <button class="col s6 cyan darken-2 btn-small" type="submit" name="action">Detalle Asesoría
                                            <i class="material-icons right">send</i>
                                        </button>
                                        <button onclick="verCalificacion('cont-cal-ase-${ele.ase_id}', ${ele.ase_id})" class="col s6 green light-2 btn-small" type="submit" name="action">Ver Calificación
                                            <i class="material-icons right">remove_red_eye</i>
                                        </button>`
                        }
                        body += `   </div>`
                        if(ele.ase_estado == 1) {
                            body += `<div style="display: none;" id="cont-cal-ase-${ele.ase_id}">
                                        <div class="row">
                                            <div class="input-field col s6">
                                                <i class="material-icons prefix">create</i>
                                                <input disabled id="cal-ase-${ele.ase_id}" type="number" min="0" max="10">
                                                <label for="cal-ase-${ele.ase_id}">Calificación</label>
                                            </div>
                                            <div class="input-field col s6">
                                                <i class="material-icons prefix">create</i>
                                                <textarea disabled id="obs-ase-${ele.ase_id}" class="materialize-textarea" data-length="300"></textarea>
                                                <label for="obs-ase-${ele.ase_id}">Observaciones</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <button onclick="ocultarCalificacion('cont-cal-ase-${ele.ase_id}')" class="col s12 cyan darken-2 btn-small" type="submit" name="action">Ocultar
                                                <i class="material-icons right">remove_red_eye</i>
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
