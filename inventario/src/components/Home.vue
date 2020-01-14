<template>
    <div class="app">
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
      Asignar(){
        let item =  JSON.parse(localStorage.getItem('login'));
        this.$store.state.login = item;   
        if(item.length>0){
            let tipo = item[0].tipo_usuario;
          
              if(tipo.toUpperCase() == "ADMIN"){
                  this.$router.push('/privateChat')                                
                }       
                else{
                    this.$router.push('/chat')
                }
            

            
          
        }else{
          this.$router.push('/login')
          
          
        }
        

           
      
      },
    },
    mounted(){
      this.Asignar()
    
      
    },
    created(){
      
      
    }

}
</script>

<style lang="scss" scoped>
.app{
    margin-top: 65px;  
}
</style>