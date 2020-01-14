<template>
  <v-app>   
    <HelloWorld/>  
     
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import axios from 'axios';
import HelloWorld from './components/HelloWorld';
import Menu from './components/Menu';
import functions from '@/assets/js/functions'


export default {
  name: 'App',

  components: {
    HelloWorld,
    Menu
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

                            this.$store.dispatch('AddLogin', this.items)
                            
                    
                            this.logueado = true;

                            this.items.forEach(element => {
                              let tipo = element.tipo_usuario;
                              if(tipo.toUpperCase() == "ADMIN"){
                                this.$router.push('/privateChat');                               
                              }       
                              else{
                                 this.$router.push('/chat');
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
      
      if (localStorage.getItem('login')){
        
        this.items = JSON.parse(localStorage.getItem('login')); 
        this.$store.state.login = this.items;


        
       
        if(this.items.length>0){
          this.logueado = true;
          this.$store.dispatch('AddLogin', this.items);

          let admin = (localStorage.getItem('admin'));
         
          if(admin === 'true'){
            this.$store.dispatch('Admin_True');
             
          }
          else{
            this.$store.dispatch('Admin_False');
          }
 
         
                         
        }
      }
      
    } ,
};
</script>
<style scoped>
.login{
  margin-top: 50vh;
  max-width: 500px !important;
  align-self: center;
}
</style>
