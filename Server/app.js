var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var axios = require('axios');


const urls = 
    {
        
      ip:'192.168.43.76',
      nameServe:'http://192.168.43.76:8090',
      // nameServe :'http://localhost:8090',
      nameSocket: 'http://192.168.43.76:3000',
      //nameSocket:  'http://localhost:3000',
      portoServe : '8090',
      portoSocket : '3000'
    }


io.on('connection', function(socket){
  
  //CUANDO EL USUARIO SE CONECTA CARGA EL CHAT POR EL LADO DEL CLIENTE CON LOS MENSAJES
  //ESTE CHAR ESCUCHA EL ADMIN
  axios.get(urls.nameServe+"/inventario/Database/BackEnd/chat.php?op=showMensajes")
      .then(response => {
          // Obtenemos los datos
          socket.emit('chat',response.data);
          console.log("se esta emitiendo el evento chat")
      })
      .catch(e => {
          // Capturamos los errores
    });
    

   //AL CONECTARSE SE EJECUTA EL CHAT DEL CLIENTE EN EL PUERTO 3000
   //PRIMERO ESPERA UNA RESPUESTA DE LA VISTA CHAT CLIENTE LA CUAL DEVUELVE EL IDUSUARIO
   //CON ESTO HACE UNA CONSULTA A LA BASE DE DATOS PARA DEVOLVER SU HISTORIAL DE CHAT
   //UNA VEZ DEVUELTA EMITIMO UN EVENTO EN LA VISTA CHAT LLAMADO HISTORIAL CLIENTE QUE MANDA TODO EL HISTORIAL
    socket.on('chatCliente',idusuario=>{
      axios.get(urls.nameServe+"/inventario/Database/BackEnd/chat.php?op=showMensajesSoporte&id="+idusuario)
      .then(response => {
          // Obtenemos los datos
          io.emit('historialCliente',response.data);
          console.log("se esta emitiendo el historial cliente")
      })
      .catch(e => {
          // Capturamos los errores
          console.log("error sockets " +e)
    });

    })

  socket.on('send', (data, idusuario) =>{
   

    axios.get(urls.nameServe+"/inventario/Database/BackEnd/chat.php?op=sendMensaje&idusuario_emisor="+idusuario+"&mensaje="+data.data.text)
      .then(response => {
          // Obtenemos los datos
          axios.get(urls.nameServe+"/inventario/Database/BackEnd/chat.php?op=showMensajes")
          .then(response => {
              // Obtenemos los datos
              io.emit('chat',response.data);
              console.log("se envion el mensaje correctamente")
          
          })
          .catch(e => {
              // Capturamos los errores
              console.log("error socket" + e)
        });
       
      })
      .catch(e => {
          // Capturamos los errores
          console.log("error socket" + e)
    });

 
  });
  console.log("conectado")
});

 

 


http.listen(3000, function(){
  console.log('listening on *:3000');
});