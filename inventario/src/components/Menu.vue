<template>
  <v-card flat >
    <v-container fluid class="menu">
      <v-row class="child-flex menu">
        <div v-if="!pequenio" >
          <v-toolbar @click="IrHome()">
            <v-btn icon class="hidden-xs-only">
                <img src="img/logo.png" alt="">
            </v-btn>            

            <v-toolbar-title>DREL-UGEL</v-toolbar-title>

            <v-spacer></v-spacer>

          </v-toolbar>
        </div>

        <div style="flex-basis: 20%">
          <v-toolbar style="background-color:#B5E742;">

            <v-btn text v-if="pequenio" style="color:#686868;" @click="IrHome()">DREL-UGEL</v-btn>
            

            <v-spacer></v-spacer>

            <v-btn icon @click="IrAjustes()" style="color:#686868;">
              <v-icon>fas fa-hammer</v-icon>
            </v-btn>

            <v-btn icon>
              <v-icon style="color:#686868;">far fa-user</v-icon>
            </v-btn>
          </v-toolbar>
        </div>       
      </v-row>
    </v-container>
    
  </v-card>
</template>

<script>
    export default {
        data(){
            return{
                pequenio:false,
            }
        },     
        methods:{
            IrHome(){
                this.$router.push('/home')
            },
            IrAjustes(){
                this.$router.push('/configuracion')
            },
            pantalla(){
                
                if (screen.width < 1024) 
                {           
                    this.pequenio=true
                }                 
            }
        },
        mounted(){
            this.pantalla()
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