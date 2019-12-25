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
            <div class="srch_bar">
              <div class="stylish-input-group">
                <input type="text" class="search-bar" placeholder="Search" />
                <span class="input-group-addon">
                  <button type="button">
                    <i class="fa fa-search" aria-hidden="true"></i>
                  </button>
                </span>
              </div>
            </div>
          </div>
          <div class="inbox_chat">
            <div class="chat_list active_chat" v-for="(index,i ) in messages" :key="i">
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
                          :color="{'warning':index.data.estado=1,'success':index.data.estado=0}"
                          class="mr-4 chat_status"
                          @click="chageEstatus(index.data.id,index.data.estado)"
                        >
                         {{index.data.estado}}
                        </v-btn>

                 
                </div>
              </div>
            </div>
          </div>
        </div>
     <notifications group="foo" />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import io from 'socket.io-client';
export default {
  data() {
    return {
      socket:{},
      message: null,
      messages: [],
      countMessages : 0,
      newCount : 0,
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
     
    this.socket.on('chat',data=>{
      this.messages = data;
      this.countMessages = data.length;
      this.newCount = data.length;
    });
    
  },
  methods: {
    chageEstatus(id,status){
      console.log("chage status succes" + id);
      console.log("parameter" + status);

      axios.get("http://localhost:8080/inventario/Database/BackEnd/chat.php?op=insertMesage&idsoporte="+id+"&idsoporte="+status)
          .then(response => {
              // Obtenemos los datos
              socket.emit('chat',response.data);
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
      this.init();
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
  height: 550px;
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