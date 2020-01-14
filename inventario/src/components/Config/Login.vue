<template>
      
    <v-app>
        <v-content v-if="!this.logueado"  class="login">
            <div class=" display-1">
                Ingrese su usuario
            </div>
            <!--contenido-->
            <template>
                <v-form
                ref="form"
                @submit.prevent="validate"
                v-model="valid"
                lazy-validation
                >
                <v-text-field
                    v-model="name"
                    :counter="10"
                    :rules="nameRules"
                    label="Name"
                    required
                ></v-text-field>

                <v-btn
                    :disabled="!valid"
                    color="success"
                    class="mr-4"
                    @click="validate"
                   
                >
                    Ingresar
                </v-btn>

                <v-btn
                    color="error"
                    class="mr-4"
                    @click="reset"
                >
                Limpiar
                </v-btn>

                </v-form>
            </template>
          </v-content>
    </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import axios from 'axios';
 
 
import functions from '@/assets/js/functions'


export default {
  name: 'login',

  components: {
 
  },

  data: () => ({
      logueado:false,
      valid: true,
      name: '',
      nameRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 10) || 'Name must be less than 10 characters',
      ],
      items: [        
      ],
      checkbox: false,
    }),

    methods: {
      validate () {
        
        
        if (this.$refs.form.validate()) {
           
           axios.get(functions.nameServe+"/inventario/Database/BackEnd/usuario.php?op=login&usuario="+this.name)
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                       
                        if(respuesta.length > 0){
                            this.items = respuesta;  
                          
                                      
                            localStorage.setItem('login', JSON.stringify(this.items));      
                            
                            
                            
                    
                            this.logueado = true;

                            this.items.forEach(element => {
                              let tipo = element.tipo_usuario;
                              let admin = tipo.toUpperCase() == "ADMIN"?true:false;

                                
                              

                              if(admin){
                                this.$router.push('/privateChat');
                                 this.$store.dispatch('AddLoginAdmin', this.items);     
                                 localStorage.setItem('admin', true);                         
                              }       
                              else{

                                 this.$router.push('/chat');
                                  this.$store.dispatch('AddLogin', this.items);
                              
                              }                       
                            });
                            

                           
                        }
                        else{
                          alert("¡Compruebe su nombre de usuario!");
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                         console.log(e);
                    })
        }
      },
      reset () {
        this.$refs.form.reset()
      },
      resetValidation () {
        this.$refs.form.resetValidation()
      },
    },
    mounted(){
      
      if (localStorage.getItem ('login')){
        
        this.items = JSON.parse(localStorage.getItem('login')); 
        this.$store.state.login = this.items;
       
        if(this.items.length>0){
          this.logueado = true;

          this.items.forEach(element => {
            let tipo = element.tipo_usuario;
            let admin = tipo.toUpperCase() == "ADMIN"?true:false;

            if(admin){
              this.$router.push('/privateChat');
                                   
            }       
            else{

                this.$router.push('/chat');
                
            
            }                       
          });

             
          // if(this.items[0].tipo_usuario.lowercase != 'admin'){
          //       this.$router.push('/Privatechat');
          // }else{
          //       this.$router.push('/chat');
          // }
                         
        }
         
      }
      
    } ,
    watch: { 
      todos: { 
      handler () {           
          localStorage.setItem('login', JSON.stringify(this.items)); 
        }, 
        deep: true, 
      }, 
    },
};
</script>

<style scoped>
.login{
  margin-top: 50vh;
  max-width: 500px !important;
  align-self: center;
}
</style>