<template>
    <div class="d-flex flex-column flex-wrap">
        
        <div v-if="mostrar_agregar" class=" align-self-start pa-10 flex-grow-1 usuario" style="background-color:#ededed; width: 100%;">
            <label class="display-1">Agregar nuevo Usuario {{LlenarTipos()}}</label>
            <template>
                <v-form
                    ref="form"                    
                    lazy-validation
                >

                    <v-container fluid>
                            <v-row align="center">
                            <v-col cols="12">
                                <v-select
                                v-model="select"
                                :hint="`${select.state}, ${select.abbr}`"
                                :items="items_tipos"
                                item-text="state"
                                item-value="abbr"
                                label="Tipo Usuario"
                                persistent-hint
                                return-object
                                single-line
                                 
                                ></v-select>
                            </v-col>
                            </v-row>
                    </v-container>


                    <div class=" d-flex flex-row flex-wrap">
                        <v-text-field
                        class=" flex-grow ma-2"
                        v-model="nombres"
                        :counter="100"                    
                        label="Nombres"
                        required
                        ></v-text-field>

                        <v-text-field
                        class=" flex-grow-1 ma-2"
                        v-model="apellidos"
                        :counter="100"                    
                        label="Apellidos"
                        required
                        ></v-text-field>
                    </div>


                    <v-text-field
                    v-model="celular"
                    :counter="100"                    
                    label="Celular"
                    required
                    ></v-text-field>


                    <v-text-field
                    v-model="correo"
                    :counter="100"                    
                    label="Correo"
                    required
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
                        <v-card class="usuario">

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
                                    <v-btn class="ma-2" tile color="primary" dark @click="verEquipos()">Ver Equipo</v-btn>  
                                    <v-btn class="ma-2" tile color="success" dark @click="agregarEvento">Nuevo</v-btn>                                   
                                    <v-btn class="ma-2" tile outlined color="success" @click="editarEvento()">
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
                            item-key="idusuario"
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
                        <v-card-text>Esta a punto de eliminar un Área</v-card-text>
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






         <!--datos propietario-->               
        <template>
            <v-row justify="center">
                <v-dialog v-model="dialog_modal" fullscreen hide-overlay transition="dialog-bottom-transition">
                
                <v-card>
                    <v-toolbar dark color="primary">
                    <v-btn icon dark @click="dialog_modal = false">
                        <v-icon>mdi-close</v-icon>
                    </v-btn>
                    <v-toolbar-title>Datos Equipo</v-toolbar-title>
                    <v-spacer></v-spacer>
                    
                    </v-toolbar>
                    <v-list three-line subheader>
                    <v-subheader></v-subheader>
                    

                    <v-card-title>    
                        <v-text-field
                            v-model="search"                        
                            label="Buscar"
                            single-line 
                            class=""                       
                        >                       
                        </v-text-field>
                    </v-card-title>    

                    <v-spacer></v-spacer>
                    
                    <v-data-table
                            v-model="selected2"
                            :headers="headers2"
                            :items="items_propietario"
                            :single-select="singleSelect"
                            :search="search"
                            item-key="id"
                            show-select
                            class="elevation-1"
                            disable-sort
                            >
                        </v-data-table>
                                
            
                    </v-list>
                
                </v-card>
                </v-dialog>
            </v-row>
        </template>
        <!--fin datos propietario-->              

              


    </div>
</template>

<script>
import axios from 'axios';
    export default {
        name:'Usuario',
        data(){
            return{  
                dialog_modal:false,

                select: { 'state': '', 'abbr': '' },
                items_tipos: [],
                mostrar_agregar:false,                
                dialog: false,
                idusuario:0,
                eseditar:false,
                texto_guardar:'Guardar',
                descripcion:'',
                nombres:'',
                apellidos:'',
                celular:'',
                correo:'',
                search: '',        
                singleSelect:true,
                selected: [],
                headers: [

                {
                    text: 'Id Usuario',          
                    value: 'idusuario',
                },          
                { text: 'Tipo Usuario', value: 'tipo_usuario' },
                { text: 'Nombres', value: 'nombres' },
                { text: 'Apellidos', value: 'apellidos' },
                { text: 'Celular', value: 'celular' },
                { text: 'Correo', value: 'correo' },
                { text: 'Fecha Registro', value: 'fecha' },
                { text: 'Estado', value: 'estado' },
                { text: 'Id Tipo Usuario', visible: "false", value: 'idtipousuario' }           
                ],
                
                items:[], 
                    }
            },
            methods:{     
                verEquipos(){
                    this.dialog_modal = true;
                },
                agregarEvento(){
                   if(this.mostrar_agregar == true){
                       this.mostrar_agregar = false;
                   }
                   else this.mostrar_agregar = true;
                   this.limpiar();
                },
                guardar(){

                    let nombres = this.nombres;
                    let apellidos = this.apellidos;
                    let celular= this.celular;
                    let correo = this.correo;
                    let id = parseInt(this.idusuario);
                    let idtipo_usuario = this.select.abbr;
                 


                    
                    if(nombres.trim().length == 0 || apellidos.trim().length == 0)
                    {
                        alert("¡Verifique la descripción!");
                        return;
                    }
                    try {
                                     
                        
                        if(!this.eseditar){

                            axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=insert&"+"idtipo_usuario="+idtipo_usuario+"&nombres="+ nombres+"&apellidos="+apellidos+"&celular="+celular+"&correo="+correo)
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

                            
                           
                            axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=update&id="+id+"&idtipo_usuario="+idtipo_usuario+"&nombres="+ nombres+"&apellidos="+apellidos+"&celular="+celular+"&correo="+correo)
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

                    } catch (error) {
                        console.log(error);
                    }
                    this.mostrar_agregar = false;
                },
                EventoBorrar(){
                    let tamanio= this.selected.length;
                     
                   if(tamanio>0){
                        this.dialog = true;        
                   }           
                   else{
                       alert("¡Porfavor seleccione un usuario!");
                   }      
                },
                borrar(valor){
                   
                    if(valor){

                            this.selected.forEach(element => {                        
                            axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=delete&id="+element.idusuario)
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
                    let tamanio = this.selected.length;                                        
                    if(tamanio>0){
                        this.idusuario =  this.selected[0].idusuario;                       
                        this.nombres = this.selected[0].nombres; 
                        this.apellidos = this.selected[0].apellidos; 
                        this.celular = this.selected[0].celular; 
                        this.correo = this.selected[0].correo; 
                        let idtipo_usuario = this.selected[0].idtipousuario; 
                        //
                        this.select = this.items_tipos.filter(valor => valor.abbr == idtipo_usuario)[0];
                        console.log("aqui estoy testeando");
                        console.log(this.items_tipos);

                      
                        //
                        this.texto_guardar = "Guardar Edición";
                        this.eseditar = true;
                        this.mostrar_agregar = true;
                    }
                    else{
                        alert("¡Porfavor seleccione un usuario!");                        
                    }
                    
                },

                limpiar(){
                    this.descripcion = "";
                    this.texto_guardar = "Guardar";
                    this.eseditar = false;
                    this.selected = [];
                    this.nombres = "";
                    this.apellidos = "";
                    this.celular = "";
                    this.correo = "";
                    this.select = {};
                },
                mostrar(){
                    
                    axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=show")
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
                },
                LlenarTipos(){
                    axios.get("http://localhost:8080/inventario/Database/BackEnd/tipo_usuario.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        let json = [];
                        if(response.status == 200){
                           respuesta.forEach(element=>{
                               json.push(
                                   {
                                       "state":element.descripcion,
                                       "abbr": element.idtipo_usuario
                                   }
                               );
                           })
                           this.items_tipos = json;
                           
                           
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                         console.log(e);
                    })
                }
            },            
             mounted(){
                axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=show")
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

                    axios.get("http://localhost:8080/inventario/Database/BackEnd/tipo_usuario.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        let json = [];
                        if(response.status == 200){
                           respuesta.forEach(element=>{
                               json.push(
                                   {
                                       "state":element.descripcion,
                                       "abbr": element.idtipo_usuario
                                   }
                               );
                           })
                           this.items_tipos = json;
                           
                           
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
.usuario{
    
    width: 100%;
}
@media screen and (max-width : 1000px){
    .usuario{        
       
    }
}

@media screen and (max-width : 800px){
    .usuario{        
       
    }
}
</style>