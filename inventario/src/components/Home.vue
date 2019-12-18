<template>
    <div class="app">
        <template>  
            <v-card>
                <div class="text-center display-3 pt-10">
                    Lista de Activos
                </div>
                
                <v-card-title>                    
                    <v-text-field
                        v-model="search"                        
                        label="Buscar"
                        single-line 
                        class=""                       
                    >                       
                    </v-text-field>

                    <v-spacer></v-spacer>

                     <div class="text-center">
                        <v-btn class="ma-2" tile color="indigo" dark @click="prueba">Historia</v-btn>

                        <v-btn class="ma-2" tile outlined color="success">
                        <v-icon left>mdi-pencil</v-icon> Editar
                        </v-btn>

                        
                        
                    </div>

                </v-card-title>

                    
                    
                <template>
                <v-data-table
                  v-model="selected"
                  :headers="headers"
                  :items="items"
                  :single-select="singleSelect"
                  :search="search"
                  item-key="id"
                  show-select
                  class="elevation-1"
                  disable-sort
                >
                  <template v-slot:top>
                    <v-switch v-model="singleSelect" label="Seleccion simple" class="pa-3"></v-switch>
                  </template>
                </v-data-table>
              </template>

            </v-card>
        </template>




      

    </div>
</template>

<script>
import axios from 'axios';

  export default {
    data () {
      return {
        search: '',
        singleSelect: true,         
        selected: [],
        headers: [

          {
            text: 'Id',          
            value: 'id',
          },          
          { text: 'Area', value: 'area' },
          { text: 'Nombre', value: 'nombre' },
          { text: 'Marca', value: 'marca' },
          { text: 'Tipo Equipo', value: 'tipo_Equipo' },
          { text: 'Nombre Equipo', value: 'nombre_Equipo' },
          { text: 'Usuario Equipo', value: 'nombre_Equipo' },
          { text: 'Procesador', value: 'nrocesador' },
          { text: 'Memoria Ram', value: 'memoria_Ram' },
          { text: 'Disco Duro', value: 'disco_Duro' },
          { text: 'Ip', value: 'ip' },
          { text: 'Mascara Sub Red', value: 'mascara_Sub_Red' },
          { text: 'Puerta Enlace', value: 'puerta_Enlace' },
          { text: 'Dns Preferido', value: 'dns_Preferido' },
          { text: 'Dns Alternativo', value: 'dns_Alternativo' },
          { text: 'Dominio', value: 'dominio' },
          { text: 'Antivurs', value: 'antivurs' },
          { text: 'Sistema Operativo', value: 'sistema_Operativo' },
          { text: 'Estado', value: 'estado' },

         
        ],
        items:[],        
      }
    },
    methods:{
      prueba(){
        console.log(this.selected);        
      },
      Consultar(){
        console.log("xxx");  
        console.log("----");  
        setTimeout(this.Consultar,1000);  
        
        axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario_equipo.php?op=show")
        .then(response => {
            // Obtenemos los datos
            this.items = response.data
            console.log(this.items);
            console.log(this.desserts);
        })
        .catch(e => {
            // Capturamos los errores
        })
        
      }      
    },
    mounted(){
      axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario_equipo.php?op=show")
      .then(response => {
          // Obtenemos los datos
          this.items = response.data
          console.log(this.items);
          console.log(this.desserts);
      })
      .catch(e => {
          // Capturamos los errores
      })
      
    }

}
</script>

<style lang="scss" scoped>
.app{
    margin-top: 65px;  
}
</style>