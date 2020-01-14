<template>
  <v-card flat >
    <v-container fluid class="menu">
      <v-row v-if="this.$store.state.logueado" class="child-flex menu">
        <div v-if="!pequenio" >
          <v-toolbar @click="IrHome()">
            <v-btn icon class="hidden-xs-only">
                <img src="https://iquitostravelguide.com/wp-content/uploads/2017/04/direccion-regional-de-educacion-de-loreto-iquitos-travel-guide-logo.jpg" alt="logo">
            </v-btn>            

            <v-toolbar-title>DREL-UGEL</v-toolbar-title>

            <v-spacer></v-spacer>

          </v-toolbar>
        </div>

        <div style="flex-basis: 20%">
          <v-toolbar  style="background-color:#B5E742;">

            <v-btn text v-if="pequenio" style="color:#686868;" @click="IrHome()">DREL-UGEL</v-btn>
            
          <notifications group="foo" />
            <v-spacer></v-spacer>

            <v-btn v-if="this.$store.state.admin" icon @click="IrAjustes()" style="color:#686868;">
              <v-icon>fas fa-hammer</v-icon>
            </v-btn>



           

            <v-btn v-if="this.$store.state.logueado" icon @click="CerrarSesion()">
              <v-icon style="color:#686868;">far fa-user</v-icon>
            </v-btn>
          </v-toolbar>
        </div>       
      </v-row>
    </v-container>
    
  </v-card>
</template>

<script>
import { mapGetters } from "vuex";
    export default {
        data(){
            return{
                logueado: false,
                pequenio:false,
                admin:false,
              
            }
        },     
        methods:{
          LOG(){
           
           
             
          },
            CerrarSesion(){

                if(!confirm("¿Seguro que desea salir?")){
                  return;
                }
                this.logueado = false;
                let items = [];
                localStorage.setItem('login', JSON.stringify(items));
                localStorage.setItem('admin', false);
                this.$store.dispatch('ClearLogin', this.items)
                 
                this.$notify({
                group: 'foo',
                title: 'Session Cerrada',
                text: 'Acaba de cerrar su session'
              });
            
              this.$router.push("/login");
            },
            IrHome(){

               
                this.items = JSON.parse(localStorage.getItem('login')); 
                

                if((this.items) == null){
                  return;
                }

              

                if(this.items.length > 0){
                  this.logueado = true;
                  var tipo = this.items[0].tipo_usuario;
                  
                  
                  if(tipo.toUpperCase() == "ADMIN"){
                      this.$router.push('/privateChat')
                    
                  }else{
              
                    this.$router.push('/chat')
                  }
                }
              
            },
            IrAjustes(){
                this.$router.push('/configuracion')
            },
            pantalla(){
                
                if (screen.width < 1024) 
                {           
                    this.pequenio=true;
                }                 
            },
            Entorno(){
             
              if((this.$store.state.login) == null){
                return;
              }

              if(this.$store.state.login.length > 0){
                let tipo = this.$store.state.login[0].tipo_usuario.toUpperCase();
                if(tipo == "ADMIN"){
                  this.admin = true;
                  this.logueado = true;
                }
              }              
            }
        },
        mounted(){
            let item = JSON.parse(localStorage.getItem('login'));
            this.$store.state.login = item;   
            this.pantalla();
            this.Entorno();
             
            
            
        },
        create(){
          this.Entorno();
          
        }   
    }
</script>

<style lang="scss" scoped>
img{
    width: 50px;
}
.menu{
    padding: 0;
    margin: 0;

    width: 100%;
    position: fixed;
    z-index: 100; 
}
 
</style>