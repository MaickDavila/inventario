<template>
    <div  class="d-flex flex-column flex-wrap">
        
        <div v-if="mostrar_agregar" class=" align-self-start pa-10 flex-grow-1" style="background-color:#ededed; width: 100%; ">
            <label class="display-1">Marcas</label>
            <template>
                <v-form
                    ref="form"                    
                    lazy-validation
                >
                    <v-text-field
                    v-model="descripcion"
                    :counter="100"                    
                    label="Descripción"
                    required
                    ref="txtdescripcion"
                    
                    ></v-text-field>

                    <v-btn
                    color="success"
                    class="mr-4"
                    @click="guardar()"
                    >
                    {{texto_guardar}}
                    </v-btn>

                    <v-btn
                    color="error"
                    class="mr-4"
                    @click="limpiar()"
                    >
                    Limpiar
                    </v-btn>

                </v-form>
            </template>
        </div>  

        <div class=" align-content-end flex-grow-1">
                    
                    <template>  
                        <v-card>

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
                                     
                                    <v-btn class="ma-2" tile color="success" dark @click="agregarEvento">Nuevo</v-btn>                                   
                                    <v-btn class="ma-2" tile outlined color="success" @click="editarEvento">
                                    <v-icon left>mdi-pencil</v-icon> Editar
                                    </v-btn>
                                    <v-btn class="ma-2" tile color="error" dark @click="EventoBorrar(false)">Borar</v-btn>
                                    
                                    
                                </div>

                            </v-card-title>

                                
                                
                            <template>
                            <v-data-table
                            v-model="selected"
                            :headers="headers"
                            :items="items"
                            :single-select="singleSelect"
                            :search="search"
                            item-key="idmarca"
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

        <div>
            <template>
                <v-row justify="center">
                    <v-dialog v-model="dialog" persistent max-width="500">
     
                    <v-card>
                        <v-card-title class="headline">¿Seguro que desea realizar esta acción?</v-card-title>
                        <v-card-text>Esta a punto de eliminar una Marca</v-card-text>
                        <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="green darken-1" text @click="borrar(true)">Aceptar</v-btn>
                        <v-btn color="green darken-1" text @click="borrar(false)">Cancelar</v-btn>
                        </v-card-actions>
                    </v-card>
                    </v-dialog>
                </v-row>
            </template>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
    export default {
        name:'Marca',
        data(){
            return{
                mostrar_agregar:false,
                dialog: false,
                idmarca:0,
                eseditar:false,
                texto_guardar:'Guardar',
                descripcion:'',
                search: '',        
                singleSelect:true,
                selected: [],
                headers: [

                {
                    text: 'Id Marca',          
                    value: 'idmarca',
                },          
                { text: 'Nombre', value: 'nombre' },
                { text: 'Estado', value: 'estado' },
                
                ],
                items:[], 
                    }
            },
            methods:{
                agregarEvento(){
                   if(this.mostrar_agregar == true){
                       this.mostrar_agregar = false;
                   }
                   else{
                       this.mostrar_agregar = true;
                       this.$refs.txtdescripcion.focus();                       
                   } 
                },
                guardar(){

                    let descripcion = this.descripcion;                  
                    let id = parseInt(this.idmarca);

                   
                  
                    
                    if(descripcion.trim().length == 0)
                    {
                        alert("¡Verifique la descripción!");
                        return;
                    }

                   
                   
                    if(!this.eseditar){


                        axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=insert&nombre="+ descripcion)
                        .then(response => {
                            // Obtenemos los datos
                            let respuesta = response.data;
                            if(respuesta == 0){
                                this.limpiar();
                                this.mostrar();
                            }
                        })
                        .catch(e => {
                            // Capturamos los errores
                        })
                    }
                    else{
                        axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=update&id="+id+"&nombre="+ descripcion)
                        .then(response => {
                            // Obtenemos los datos
                            let respuesta = response.data;
                            if(respuesta == 0){
                                this.limpiar();
                                this.mostrar();
                            }
                        })
                        .catch(e => {
                            // Capturamos los errores
                        })
                        
                    }
                    this.mostrar_agregar = false;
                },
                EventoBorrar(){
                    let tamanio= this.selected.length;
                     
                   if(tamanio>0){
                        this.dialog = true;        
                   }           
                   else{
                       alert("¡Porfavor seleccione un área!");
                   }      
                },
                borrar(valor){
                   
                    if(valor){

                            this.selected.forEach(element => {                        
                            axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=delete&id="+element.idmarca)
                            .then(response => {
                                // Obtenemos los datos
                                let respuesta = response.data;
                                
                                if(response.status == 200){                                
                                   
                                    this.mostrar();
                                }
                            })
                            .catch(e => {
                                // Capturamos los errores
                            })
                        
                        });
                    }     
                    this.dialog = false;               

                },
                editarEvento(){
                    let tamanio= this.selected.length;                                        
                    if(tamanio>0){
                        this.idmarca =  this.selected[0].idmarca;
                        this.descripcion = this.selected[0].nombre; 
                        this.texto_guardar = "Guardar Edición";
                        this.eseditar = true;
                    }
                    else{
                        alert("¡Porfavor seleccione una marca!");
                    }
                    
                },

                limpiar(){
                    this.descripcion = "";
                    this.texto_guardar = "Guardar";
                    this.eseditar = false;
                    this.selected = [];
                },
                mostrar(){
                   
                    axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=show")
                        .then(response => {
                            // Obtenemos los datos
                            let respuesta = response.data;
                            
                            if(response.status == 200){
                            this.items = respuesta;
                            
                            }
                        })
                        .catch(e => {
                            // Capturamos los errores
                            console.log(e);
                        })
                }
            },            
             mounted(){
                axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        
                        if(response.status == 200){
                           this.items = respuesta;
                           
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                         console.log(e);
                    })
             }
    }
</script>

<style lang="scss" scoped>

</style>