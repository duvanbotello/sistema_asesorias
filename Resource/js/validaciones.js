
var validarNombre = name => {
    if (name.value == '') {
        M.toast({html: 'Debes ingresar tu nombre', classes: 'rounded cyan darken-2'})
        name.focus()
        return false
    } else if (name.value.length < 4) {
        M.toast({html: 'Tu nombre debe contener mas de 3 caracteres', classes: 'rounded cyan darken-2'})
        name.focus()
        return false
    } else if (name.value.length > 20) {
        M.toast({html: 'Tu nombre debe contener menos de 21 caracteres', classes: 'rounded cyan darken-2'})
        name.focus()
        return false
    } else if (!/^([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'][\s]*)+([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])[\s]*?([A-Za-zÁÉÍÓÚñáéíóúÑ]{0}?[A-Za-zÁÉÍÓÚñáéíóúÑ\'])?$/g.test(name.value)) {
        M.toast({html: 'Tu nombre solo debe contener letras', classes: 'rounded cyan darken-2'})
        name.focus()
        return false
    }
    return true
}

var validarTipoDoc = tipodoc => {
    if (tipodoc.value == '0') {
        M.toast({html: 'Debes seleccionar tu tipo de documento', classes: 'rounded cyan darken-2'})
        tipodoc.focus()
        return false
    }
    return true
}

var validarTipoRol = tiporol => {
    if (tiporol.value == '0') {
        M.toast({html: 'Debes seleccionar tu tipo de rol', classes: 'rounded cyan darken-2'})
        tiporol.focus()
        return false
    }
    return true
}

var validarTipoTel = tipotel => {
    if (tipotel.value == '0') {
        M.toast({html: 'Debes seleccionar tu tipo de telefono', classes: 'rounded cyan darken-2'})
        tipotel.focus()
        return false
    }
    return true
}

var validarDocumento = doc => {
    if (doc.value == '') {
        M.toast({html: 'Debes ingresar tu documento', classes: 'rounded cyan darken-2'})
        doc.focus()
        return false
    } else if (doc.value.length < 5) {
        M.toast({html: 'Tu documento debe contener mas de 4 caracteres', classes: 'rounded cyan darken-2'})
        doc.focus()
        return false
    } else if (doc.value.length > 15) {
        M.toast({html: 'Tu documento debe contener menos de 16 caracteres', classes: 'rounded cyan darken-2'})
        doc.focus()
        return false
    } else if (isNaN(doc.value)) {
        M.toast({html: 'Tu documento solo debe contener números', classes: 'rounded cyan darken-2'})
        doc.focus()
        return false
    }
    return true
}

var validarExperiencia = exp => {
    if (exp.value == '') {
        M.toast({html: 'Debes ingresar tu experiencia', classes: 'rounded cyan darken-2'})
        exp.focus()
        return false
    } else if (exp.value < 0.00) {
        M.toast({html: 'Tu experiencia tiene que estar dentro del rango, 0.0 - 10.0', classes: 'rounded cyan darken-2'})
        exp.focus()
        return false
    } else if (exp.value > 10.00) {
        M.toast({html: 'Tu experiencia tiene que estar dentro del rango, 0.0 - 10.0', classes: 'rounded cyan darken-2'})
        exp.focus()
        return false
    } else if (isNaN(exp.value)) {
        M.toast({html: 'Tu experiencia solo se mide por números', classes: 'rounded cyan darken-2'})
        exp.focus()
        return false
    }
    return true
}

var validarBiografia = bio => {
    if (bio.value == '') {
        M.toast({html: 'Debes ingresar tu biografia', classes: 'rounded cyan darken-2'})
        bio.focus()
        return false
    } else if (bio.value.length > 500) {
        M.toast({html: 'Tu biografia debe contener menos de 501 caracteres', classes: 'rounded cyan darken-2'})
        bio.focus()
        return false
    } 
    return true
}

var validarTelefono = phone => {
    if (phone.value == '') {
        M.toast({html: 'Debes ingresar tu telefono', classes: 'rounded cyan darken-2'})
        phone.focus()
        return false
    } else if (phone.value.length < 5) {
        M.toast({html: 'Tu telefono debe contener mas de 4 caracteres', classes: 'rounded cyan darken-2'})
        phone.focus()
        return false
    } else if (phone.value.length > 10) {
        M.toast({html: 'Tu telefono debe contener menos de 11 caracteres', classes: 'rounded cyan darken-2'})
        phone.focus()
        return false
    } else if (isNaN(phone.value)) {
        M.toast({html: 'Tu telefono solo debe contener números', classes: 'rounded cyan darken-2'})
        phone.focus()
        return false
    }
    return true
}

var validarUbicacion = location => {
    if (location.value == '') {
        M.toast({html: 'Debes ingresar tu dirección de ubicación', classes: 'rounded cyan darken-2'})
        location.focus()
        return false
    } else if (location.value.length > 50) {
        M.toast({html: 'Tu dirección de ubicación debe contener menos de 51 caracteres', classes: 'rounded cyan darken-2'})
        location.focus()
        return false
    }
    return true
}

var validarCorreo = email => {
    if (email.value == '') {
        M.toast({html: 'Debes ingresar tu correo electrónico', classes: 'rounded cyan darken-2'})
        email.focus()
        return false
    } else if (email.value > 25) {
        M.toast({html: 'Tu correo electrónico debe contener menos de 26 caracteres', classes: 'rounded cyan darken-2'})
        email.focus()
        return false
    } else if (!/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i.test(email.value)) {
        M.toast({html: 'Tu correo electrónico debe cumplir con la estructura correcta', classes: 'rounded cyan darken-2'})
        email.focus()
        return false
    }
    return true
}

var validarUsuario = user => {
    if (user.value == '') {
        M.toast({html: 'Debes ingresar el usuario', classes: 'rounded cyan darken-2'})
        user.focus()
        return false
    } else if (user.value.length < 4) {
        M.toast({html: 'El usuario debe contener mas de 3 caracteres', classes: 'rounded cyan darken-2'})
        user.focus()
        return false
    } else if (user.value.length > 10) {
        M.toast({html: 'El usuario debe contener menos de 11 caracteres', classes: 'rounded cyan darken-2'})
        user.focus()
        return false
    }
    return true
}

var validarContrasena = pass => {
    if (pass.value == '') {
        M.toast({html: 'Debes ingresar la contraseña', classes: 'rounded cyan darken-2'})
        pass.focus()
        return false
    } else if (pass.value.length < 4) {
        M.toast({html: 'La contraseña debe contener mas de 3 caracteres', classes: 'rounded cyan darken-2'})
        pass.focus()
        return false
    } else if (pass.value.length > 10) {
        M.toast({html: 'La contraseña debe contener menos de 11 caracteres', classes: 'rounded cyan darken-2'})
        pass.focus()
        return false
    }
    return true
}
