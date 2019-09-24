
// codigo de Estudiantes (Usuarios)
var usuario = new Usuario();
var iniciarSesion = ()=>{
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    usuario.iniciarSesion(email, password);
}

$().ready(()=>{
    
});