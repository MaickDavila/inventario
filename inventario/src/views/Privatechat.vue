<template>
  <div class="container">
    <h3 class="text-center">Mensajes </h3>
 
    <div class="messaging">
      <div class="inbox_msg">
        <div class="inbox_people">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>Recientes</h4>
            </div>

          <!--
              <div class="srch_bar">
              <div class="stylish-input-group">
                <input type="text" class="search-bar" v-model="buscar" placeholder="Search" />
                <span class="input-group-addon">
                  <button type="button">
                    <i class="fa fa-search" aria-hidden="true"></i>
                  </button>
                </span>
              </div>
            </div>

          -->

          </div>

          <div class="my-2">
              <v-btn
              class="mr-2 warning"
              @click="pendientes = true"
              >
                Pendientes
              </v-btn>

              <v-btn
              class="success"
              @click="pendientes = false"
              >
                Todos
              </v-btn>

            </div>

          <div class="inbox_chat">
            <div class="chat_list active_chat" v-for="(index,i ) in ListarMensajes()" :key="i">
              <div class="chat_people">
                <div class="chat_img">
                  <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil" />
                </div>
                <div class="chat_ib">
                  <h5>
                    {{index.author}}
                    <span class="chat_date">{{index.data.fecha}}</span>
                  </h5>
                  <p>{{index.data.text}}</p>

                        <v-btn                         
                          :class="'mr-4 chat_status ' + colors[index.data.estado]"
                          @click="chageEstatus(index.data.id,index.data.estado)"
                        >
                         {{estados[index.data.estado]}}
                        </v-btn>
                   <p><small style="color:blue;">{{index.data.mensaje_soporte}}</small></p>

                </div>
              </div>
            </div>
          </div>
        </div>
     <notifications group="foo" />
      </div>
    </div>

            <template>
              <v-row justify="center">
                <v-dialog v-model="dialog" persistent max-width="600px">
 
                  <v-card>
                    <v-card-title>
                      <span class="headline">Cambiar Estado</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <v-col cols="12">
                              <v-textarea
                                v-model="descripcion"
                                color="teal"
                                :readonly="readOnly"
                              >
                                <template v-slot:label>
                                  <div>
                                    Descripción
                                  </div>
                                </template>
                              </v-textarea>
                            </v-col>                
                        </v-row>
                      </v-container>
                      <small>*Agregue una descripción</small>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn color="blue darken-1" text @click="dialog = false">Cerrar</v-btn>
                      <v-btn color="blue darken-1" text @click="GuardarCambioSoporte()">Guardar</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-row>
            </template>

  </div>
</template>

<script>
import axios from "axios";
import io from 'socket.io-client';
import Solucion from '@/components/Config/Solucion.vue';

export default {
  data() {
    return {
      idtemp:0,
      readOnly:false,
      descripcion:"",
      dialog:false,
      buscar:'',
      pendientes:false,
      socket:{},
      message: null,
      messages: [],
      countMessages : 0,
      newCount : 0,
      colors:{
        '0':'warning',
        '1':'success'
      },
      estados : {
        '0' : 'pendiente',
        '1' : 'solucionado'
      }
    };
  },
  created() {
  
    this.socket = io("http://localhost:3000")
    this.fecthMessages();
   
  },
  init(){
    this.countMessages = 0;
    this.newCount = 0;
  },
   mounted(){
    this.Escuchar();
    
  },
  methods: {
 

    Escuchar(){
        this.socket.on('chat',data=>{
        this.messages = data;
        this.countMessages = data.length;
        this.newCount = data.length;
      });
    },
    ListarMensajes(){
      let salida;

      if(this.pendientes){
          
          salida = this.messages.filter(
            function(element){
              return element.data.estado == 0;
            }
          );
        }  
        else{
          salida = this.messages;
        }  
       
      
      return salida;
    },
    getColor(value){
      let salida = '';
      if(value==1){
        salida = 'success';
      }else{
        salida =  'danger';
      }
      console.log(salida);
      return salida.toString();
    },
    chageEstatus(id,status){
      var std = (status==1? 0:1)
      this.dialog = true;
      if(std == 1){
        this.readOnly = false;
        this.descripcion = "";
        this.idtemp = id;
      }
      else{
        this.readOnly = true;
        let mensaje = this.messages.filter(element => element.data.id == id);        
        this.descripcion = mensaje[0].data.mensaje_soporte;
      }
    },
    GuardarCambioSoporte(){
      console.log("this.descripcion");
      console.log(this.descripcion);
      axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=insertMesage&idsoporte="+this.idtemp+"&estado="+1+"&mensaje="+this.descripcion)
          .then(response => {
              // Obtenemos los datos
              console.log(response);              
              this.dialog = false;   
               
          })
          .catch(e => {
              // Capturamos los errores
        });

    },
    saveMessage() {
      //   this.messages.push(this.message);
      this.message = null;
    },
    fecthMessages() {

      this.socket.on('chat',data=>{
        this.messages = data;

        this.newCount = data.length;
       if(this.newCount>this.countMessages){
        this.$notify({
          group: 'foo',
          title: 'Nuevo Mensaje',
          text: '!'
        });
      }
      });
      
    }
  }
};
</script>

<style scoped="">
.container {
  max-width: 1400px;
  margin: auto;
}

img {
  max-width: 100%;
}

.inbox_people {
  background: #f8f8f8 none repeat scroll 0 0;
  float: left;
  overflow: hidden;
  width: 100%;
  border-right: 1px solid #c4c4c4;
}

.inbox_msg {
  border: 1px solid #c4c4c4;
  clear: both;
  overflow: hidden;
}

.top_spac {
  margin: 20px 0 0;
}

.recent_heading {
  float: left;
  width: 40%;
}

.srch_bar {
  display: inline-block;
  text-align: right;
  width: 60%;
}

.headind_srch {
  padding: 10px 29px 10px 20px;
  overflow: hidden;
  border-bottom: 1px solid #c4c4c4;
}

.recent_heading h4 {
  color: #05728f;
  font-size: 21px;
  margin: auto;
}

.srch_bar input {
  border: 1px solid #cdcdcd;
  border-width: 0 0 1px 0;
  width: 80%;
  padding: 2px 0 4px 6px;
  background: none;
}

.srch_bar .input-group-addon button {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  padding: 0;
  color: #707070;
  font-size: 18px;
}

.srch_bar .input-group-addon {
  margin: 0 0 0 -27px;
}

.chat_ib h5 {
  font-size: 25px;
  color: #464646;
  margin: 0 0 8px 0;
}

.chat_ib h5 span {
  font-size: 20px;
  float: right;
}

.chat_ib p {
  font-size: 20px;
  color: #989898;
  margin: auto;
}

.chat_img {
  float: left;
  width: 11%;
}

.chat_ib {
  float: left;
  padding: 0 0 0 15px;
  width: 88%;
}

.chat_status {
  float: right;
  padding: 0 0 0 15px;
  
}
.chat_people {
  overflow: hidden;
  clear: both;
}

.chat_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}

.inbox_chat {
  height: 100vh;
  overflow-y: scroll;
}

.active_chat {
  background: #ebebeb;
}

.incoming_msg_img {
  display: inline-block;
  width: 6%;
}

.received_msg {
  display: inline-block;
  padding: 0 0 0 10px;
  vertical-align: top;
  width: 92%;
}

.received_withd_msg p {
  background: #ebebeb none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 14px;
  margin: 0;
  padding: 5px 10px 5px 12px;
  width: 100%;
}

.time_date {
  color: #747474;
  display: block;
  font-size: 12px;
  margin: 8px 0 0;
}

.received_withd_msg {
  width: 57%;
}

.mesgs {
  float: left;
  padding: 30px 15px 0 25px;
  width: 60%;
}

.sent_msg p {
  background: #05728f none repeat scroll 0 0;
  border-radius: 3px;
  font-size: 14px;
  margin: 0;
  color: #fff;
  padding: 5px 10px 5px 12px;
  width: 100%;
}

.outgoing_msg {
  overflow: hidden;
  margin: 26px 0 26px;
}

.sent_msg {
  float: right;
  width: 46%;
}

.input_msg_write input {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  color: #4c4c4c;
  font-size: 15px;
  min-height: 48px;
  width: 100%;
}

.type_msg {
  border-top: 1px solid #c4c4c4;
  position: relative;
}

.msg_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 0;
  top: 11px;
  width: 33px;
}

.messaging {
  padding: 80px 0 50px 0;
}

.msg_history {
  height: 516px;
  overflow-y: auto;
}
</style>