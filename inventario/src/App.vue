<template>
  <v-app>
    <Menu/>
    <v-content v-if="!this.logueado"  class="login">
      <div class=" display-1">
        Ingrese su usuario
      </div>
      <!--contenido-->
      <template>
        <v-form
          ref="form"
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
    <router-view></router-view>
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import axios from 'axios';
import HelloWorld from './components/HelloWorld';
import Menu from './components/Menu';

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
           
           axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=login&usuario="+this.name)
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        
                        if(response.status == 200){
                            this.items = respuesta;  
                            console.log(this.items);                  
                            localStorage.setItem('login', JSON.stringify(this.items));      

                            this.$store.dispatch('AddLogin', this.items)
                            this.$router.push('/home');
                            this.logueado = true;
                           
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
        if(this.items.length>0){
          this.logueado = true;
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
