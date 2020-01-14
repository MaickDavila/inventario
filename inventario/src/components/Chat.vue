<template>

 
  <div class="pa">

    <v-row>
      <v-col>
<v-card
        class="mx-auto ml-10"  
        elevation-10
        outlined
      >
    <h3 class="mt-4 text-center">Datos de propietario</h3>
    <v-list-item three-line>
      <v-list-item-content>
   
       <div class="overline mb-4 ">Nombre</div>
        <v-list-item-title class="headline mb-1">{{cached.nombre_usuario}}</v-list-item-title>
       
       
<!--         
         <div class="overline mb-4 mt-4">Apellido</div>
        <v-list-item-title class="headline mb-1">{{cached.celular}}</v-list-item-title> -->

        
         <div class="overline mb-4 mt-4">Celular</div>
        <v-list-item-title class="headline mb-1">{{cached.celular}}</v-list-item-title>

        
         <div class="overline mb-4 mt-4">Correo</div>
        <v-list-item-title class="headline mb-1">{{cached.correo}}</v-list-item-title>

        
         <div class="overline mb-4 mt-4">Tipo de usuario</div>
        <v-list-item-title class="headline mb-1">{{cached.tipo_usuario}}</v-list-item-title>

       

         <div class="overline mb-4 mt-4">Equipo Propietario</div>
        <v-list-item-title class="headline mb-1">{{cached.nombre_usuario}}</v-list-item-title>
       

        
      </v-list-item-content>

     
    </v-list-item>

    <v-card-actions>
      <!-- <v-btn text>Button</v-btn>
      <v-btn text>Button</v-btn> -->
    </v-card-actions>
  </v-card>

      </v-col>
      


<v-col>
       <v-card
          elevation-10
          class="mx-auto ml-10 mr-10"  
          outlined
  >
    <h3 class="mt-4  text-center ">Datos de equipo</h3>
    <v-list-item three-line>
      <v-list-item-content>
   
      
        <div class="overline mb-4 ">Area</div>
      <v-list-item-title class="headline mb-1">{{data_equipo.area}}</v-list-item-title>
       
       
        
         <div class="overline mb-4 mt-4">Usuario</div>
        <v-list-item-title class="headline mb-1">{{data_equipo.usuario}}</v-list-item-title>

        
         <div class="overline mb-4 mt-4">Nombre Equipo</div>
        <v-list-item-title class="headline mb-1">{{data_equipo.nombre_equipo}}</v-list-item-title>

      </v-list-item-content>

    </v-list-item>

    <v-card-actions>
      <!-- <v-btn text>Button</v-btn>
      <v-btn text>Button</v-btn> -->
    </v-card-actions>
  </v-card>
</v-col>
</v-row>

  
                      

    <beautiful-chat
      :participants="participants"
      :onMessageWasSent="onMessageWasSent"
      :messageList="messageList"
      :newMessagesCount="newMessagesCount"
      :isOpen="isChatOpen"
      :close="closeChat"
      :icons="icons"
      :open="openChat"
      :showEmoji="false"
      :showFile="false"
      :showTypingIndicator="showTypingIndicator"
      :colors="colors"
      :alwaysScrollToBottom="alwaysScrollToBottom"
      :messageStyling="messageStyling"
      @onType="handleOnType"
      @edit="editMessage" />
  </div>
</template>

<script>
import CloseIcon from 'vue-beautiful-chat/src/assets/close-icon.png'
import OpenIcon from 'vue-beautiful-chat/src/assets/logo-no-bg.svg'
import FileIcon from 'vue-beautiful-chat/src/assets/file.svg'
import CloseIconSvg from 'vue-beautiful-chat/src/assets/close.svg'
import io from 'socket.io-client'
import axios from 'axios';
import functions from '@/assets/js/functions'

 
export default {
  name: 'app',
  data() {
    return {
      singleSelect:true,
      selected: [],
      cached:[],
      data_equipo:[],
      headers: [

      {
          text: 'Id Area',          
          value: 'idarea',
      },          
      { text: 'Nombre', value: 'nombre' },
      { text: 'Estado', value: 'estado' },
      
      ],
      items:[], 
      socket:{},
      usuario_emisor : null,
      context:{},
      icons:{
        open:{
          img: OpenIcon,
          name: 'default',
        },
        close:{
          img: CloseIcon,
          name: 'default',
        },
        file:{
          img: FileIcon,
          name: 'default',
        },
        closeSvg:{
          img: CloseIconSvg,
          name: 'default',
        },
      },
      participants: [
        {
          id: 'user1',
          name: 'Soporte Tecnico',
          imageUrl: ''
        }
      ], // the list of all the participant of the conversation. `name` is the user name, `id` is used to establish the author of a message, `imageUrl` is supposed to be the user avatar.
      // titleImageUrl: 'https://a.slack-edge.com/66f9/img/avatars-teams/ava_0001-34.png',
      messageList: [
          { type: 'text', author: `user1`, data: { text: `Hola, Como puedo ayudarte!` } }
      ], // the list of the messages to show, can be paginated and adjusted dynamically
      newMessagesCount: 0,
      isChatOpen: false, // to determine whether the chat window should be open or closed
      showTypingIndicator: '', // when set to a value matching the participant.id it shows the typing indicator for the specific user
      colors: {
        header: {
          bg: '#4e8cff',
          text: '#ffffff'
        },
        launcher: {
          bg: '#4e8cff'
        },
        messageList: {
          bg: '#ffffff'
        },
        sentMessage: {
          bg: '#4e8cff',
          text: '#ffffff'
        },
        receivedMessage: {
          bg: '#eaeaea',
          text: '#222222'
        },
        userInput: {
          bg: '#f4f7f9',
          text: '#565867'
        }
      },
      items:[], // specifies the color scheme for the component
      alwaysScrollToBottom: false, // when set to true always scrolls the chat to the bottom when new events are in (new message, user starts typing...)
      messageStyling: true // enables *bold* /emph/ _underline_ and such (more info at github.com/mattezza/msgdown)
    }
  },
  created() {
     this.socket = io(functions.nameSocket)
  },
  mounted(){
    //  var host = window.location.protocol + "//" + window.location.network;
    //  console.log(host)
       
      this.items = JSON.parse(localStorage.getItem('login')); 
      if(this.items.length>0){
        this.usuario_emisor = this.items[0].idusuario_equipo;
        this.cached = this.items[0]
        
        axios.get(functions.nameServe+"/inventario/Database/BackEnd/usuario_equipo.php?op=show2&id="+this.items[0].idequipo)
        .then(response => {
            // Obtenemos los datos
           this.data_equipo = response.data;
          // console.log(this.data_equipo)
        })
        .catch(e => {
          // console.log("Exepcion " + e)
            // Capturamos los errores
        })
      }

    this.socket.emit('chatCliente',this.usuario_emisor)

    this.reloadChat();
 
  },
  methods: {
    reloadChat(){
      this.socket.on('historialCliente',data=>{
          this.messageList = data;
        });
    },
    sendMessage (text) {
      
      if (text.length > 0) {
        this.newMessagesCount = this.isChatOpen ? this.newMessagesCount : this.newMessagesCount + 1
        var  user = this.usuario_emisor;
        let datos = {"texto": text, "usuario": this.user};
        
        this.onMessageWasSent({ author: 'support', type: 'text', data: datos })
      }

  
    },
    onMessageWasSent (message) {
      // called when the user sends a message
      // console.log(message);
      this.messageList = [ ...this.messageList, message ]    
      this.socket.emit('send', message, this.usuario_emisor);
      this.reloadChat();
      
    },
    openChat () {
      // called when the user clicks on the fab button to open the chat
      this.isChatOpen = true
      this.newMessagesCount = 0
    },
    closeChat () {
      // called when the user clicks on the botton to close the chat
      this.isChatOpen = false
    },
    handleScrollToTop () {
      // called when the user scrolls message list to top
      // leverage pagination for loading another page of messages
  	},
    handleOnType () {
  
      console.log('Emit typing event')
    },
    editMessage(message){
      const m = this.messageList.find(m=>m.id === message.id);
      m.isEdited = true;
      m.data.text = message.data.text;
    }
}
}
</script>

<style lang="scss" scoped>
.pa{
  padding-top: 100px;
}
</style>