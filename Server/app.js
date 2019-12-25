var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var axios = require('axios');


io.on('connection', function(socket){
  
  //CUANDO EL USUARIO SE CONECTA CARGA EL CHAT POR EL LADO DEL CLIENTE CON LOS MENSAJES
  //ESTE CHAR ESCUCHA EL ADMIN
  axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=showMensajes")
      .then(response => {
          // Obtenemos los datos
          socket.emit('chat',response.data);
          console.log(response.data)
      })
      .catch(e => {
          // Capturamos los errores
    });

   //AL CONECTARSE SE EJECUTA EL CHAT DEL CLIENTE EN EL PUERTO 3000
   //PRIMERO ESPERA UNA RESPUESTA DE LA VISTA CHAT CLIENTE LA CUAL DEVUELVE EL IDUSUARIO
   //CON ESTO HACE UNA CONSULTA A LA BASE DE DATOS PARA DEVOLVER SU HISTORIAL DE CHAT
   //UNA VEZ DEVUELTA EMITIMO UN EVENTO EN LA VISTA CHAT LLAMADO HISTORIAL CLIENTE QUE MANDA TODO EL HISTORIAL
    socket.on('chatCliente',idusuario=>{
      axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=showMensajesSoporte&id="+idusuario)
      .then(response => {
          // Obtenemos los datos
          io.emit('historialCliente',response.data);
      })
      .catch(e => {
          // Capturamos los errores
    });

    })

  socket.on('send', (data, idusuario) =>{
   

    axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=sendMensaje&idusuario_emisor="+idusuario+"&mensaje="+data.data.text)
      .then(response => {
          // Obtenemos los datos
          axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=showMensajes")
          .then(response => {
              // Obtenemos los datos
              io.emit('chat',response.data);
          
          })
          .catch(e => {
              // Capturamos los errores
              console.log(e)
        });
       
      })
      .catch(e => {
          // Capturamos los errores
          console.log(e)
    });

 
  });

  console.log("user conected")
});



http.listen(3000, function(){
  console.log('listening on *:3000');
});