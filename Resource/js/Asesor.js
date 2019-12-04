
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
                    data.results.forEach(ele => {
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
                                        <button onclick="actualizarAsesoria(${ele.ase_id}, '1')"  class="col s4 green darken-2 btn-small" type="submit" name="action">Aceptar Asesoría
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
                                        <button onclick="actualizarAsesoria(${ele.ase_id}, '1')"  class="col s6 green darken-2 btn-small" type="submit" name="action">Aceptar Asesoría
                                            <i class="material-icons right">check</i>
                                        </button>`
                        }
                        body += `   </div>
                                </li>`
                    });
                    $('#listaAsesorias').append(body)
                } catch (err) {
                    M.toast({ html: err, classes: 'rounded red darken-2' })
                }
            }
        )
    }

}
