<template>    
    <div class="d-flex flex-column flex-wrap">
 
        
        <div v-if="mostrar_agregar" class=" align-self-start pa-10 flex-grow-1" style="background-color:#ededed; width: 100%; ">
            <label class="display-1">Agregar un nuevo Equipo</label>
            
            <template>
                <v-form
                    ref="form"                    
                    lazy-validation
                >

                    <template>
                        <v-container fluid>
                            <v-row align="center">
                                <v-col cols="6">
                                    <v-select
                                    v-model="select_marca"
                                    :hint="`${select_marca.state}, ${select_marca.abbr}`"
                                    :items="items_marca"
                                    item-text="state"
                                    item-value="abbr"
                                    label="Marca"
                                    persistent-hint
                                    return-object
                                    single-line
                                    
                                    ></v-select>
                                </v-col>

                                <v-col cols="6">
                                    <v-select
                                    v-model="select_tipo_equipo"
                                    :hint="`${select_tipo_equipo.state}, ${select_tipo_equipo.abbr}`"
                                    :items="items_tipo_equipo"
                                    item-text="state"
                                    item-value="abbr"
                                    label="Tipo Equipo"
                                    persistent-hint
                                    return-object
                                    single-line
                                    
                                    ></v-select>
                                </v-col>

                            </v-row>
                        </v-container>
                    </template>


                    <div class=" d-flex flex-row flex-wrap">
                        <v-text-field
                        class=" flex-grow ma-2"
                        v-model="nombre_equipo"
                        :counter="100"                    
                        label="Nombre del equipo"
                        required
                        ></v-text-field>

                        <v-text-field
                        class=" flex-grow-1 ma-2"
                        v-model="usuario_equipo"
                        :counter="100"                    
                        label="Usuario del equipo"
                        required
                        ></v-text-field>
                    </div>

                    
                    <div class=" d-flex flex-row flex-wrap">
                        <v-text-field
                        v-model="procesador"
                        :counter="100"                    
                        label="Procesador"
                        required
                        class="ma-2"
                        ></v-text-field>


                        <v-text-field
                        v-model="memoria_ram"
                        :counter="100"                    
                        label="Memoria Ram"
                        required
                        class="ma-2"
                        ></v-text-field>

                         <v-text-field
                        v-model="disco_duro"
                        :counter="100"                    
                        label="Disco Duro"
                        required
                        class="ma-2"
                        ></v-text-field>

                    </div>




                    <div class=" d-flex flex-row flex-wrap">
                        <v-text-field
                        v-model="ip"
                        :counter="100"                    
                        label="IP"
                        required
                        class="ma-2"
                        ></v-text-field>


                        <v-text-field
                        v-model="mascara_sub_red"
                        :counter="100"                    
                        label="Mascara Sub Red"
                        required
                        class="ma-2"
                        ></v-text-field>

                         <v-text-field
                        v-model="puerta_enlace"
                        :counter="100"                    
                        label="Puerta Enlace"
                        required
                        class="ma-2"
                        ></v-text-field>                  
                    </div>




                    <div class=" d-flex flex-row flex-wrap">
                        <v-text-field
                        v-model="dns_preferido"
                        :counter="100"                    
                        label="Dns Preferido"
                        required
                        class="ma-2"
                        ></v-text-field>


                        <v-text-field
                        v-model="dns_alternativo"
                        :counter="100"                    
                        label="Dns Alternativo"
                        required
                        class="ma-2"
                        ></v-text-field>              
                    </div>


                    <div class=" d-flex flex-row flex-wrap">
                        <v-checkbox
                        v-model="dominio"
                        label="Dominio"
                        required
                        >                            
                        </v-checkbox>       

                        <v-checkbox
                        v-model="antivirus"
                        label="Antivirus"
                        required
                        >                            
                        </v-checkbox>               
                    </div>

                    <v-text-field
                        v-model="sistema_operativo"
                        :counter="100"                    
                        label="Sistema Operativo"
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

        <!--dialogo de propiertario-->   
        <template>
            <v-row justify="center">
                <v-dialog v-model="dialog_modal" fullscreen hide-overlay transition="dialog-bottom-transition">
                
                <v-card>
                    <v-toolbar dark color="primary">
                    <v-btn icon dark @click="dialog_modal = false">
                        <v-icon>mdi-close</v-icon>
                    </v-btn>
                    <v-toolbar-title>Datos Propietario</v-toolbar-title>
                    <v-spacer></v-spacer>
                    
                    </v-toolbar>
                    <v-list three-line subheader>
                    <v-subheader></v-subheader>

                    <div class="text-center">
                        <v-btn class="ma-2" tile color="success" dark @click="AgregarPropietarioEvento">Agregar Propietario</v-btn>                                                 
                    </div>


                            <v-data-table
                                    v-model="selected"
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
        <!--fin dialogo de propiertario--> 


        <!--modal para agregar un propietario-->
        <template>
            <v-row justify="center">
                <v-dialog v-model="dialogAgregarPropietario" persistent max-width="600px">
                <v-card>
                    <v-card-title>
                    <span class="headline">Agregar Propietario</span>
                    </v-card-title>
                    <v-card-text>
                    <v-container>
                        <v-row>
                            <v-col cols="12" sm="12">
                                <v-select
                                    v-model="select_usuarios"
                                    :hint="`${select_usuarios.state}, ${select_usuarios.abbr}`"
                                    :items="items_usuarios"
                                    item-text="state"
                                    item-value="abbr"
                                    label="Usuarios"
                                    persistent-hint
                                    return-object
                                    single-line
                                    
                                ></v-select>
                            </v-col>
                        </v-row>
                    </v-container>
                    
                    </v-card-text>
                    <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="blue darken-1" text @click="dialogAgregarPropietario = false">Cerrar</v-btn>
                    <v-btn color="blue darken-1" text @click="dialogAgregarPropietario = false">Guardar</v-btn>
                    </v-card-actions>
                </v-card>
                </v-dialog>
            </v-row>
        </template>
        <!--fin modal para agregar un propietario-->


        <!--seccion del datatbale--> 
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
                                      <!-- <template v-slot:activator="{ on }"> -->
                                        <!-- <v-btn color="primary" dark v-on="on">Ver Propietario</v-btn> -->
                                    <!-- </template> -->
                                     <v-btn class="ma-2" tile color="primary" dark @click="verPropietario">Ver Propietario</v-btn>  
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
        <!--fin seccion del datatbale--> 
        

        <!--dialogo de eliminar-->
        <div>
            <template>
                <v-row justify="center">
                    <v-dialog v-model="dialog" persistent max-width="500">
     
                    <v-card>
                        <v-card-title class="headline">¿Seguro que desea realizar esta acción?</v-card-title>
                        <v-card-text>Esta a punto de eliminar un Equipo</v-card-text>
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
        <!--fin dialogo de eliminar-->




       

    </div>
</template>

<script>
import axios from 'axios';
    export default {
        name:'Equipo',
        data(){
            return{
                select_usuarios:{},
                items_usuarios:[],
                dialogAgregarPropietario:false,
                dialog_modal: false,
                notifications: false,
                sound: true,
                widgets: false,
                items_propietario: [],
                select_marca:{ state: '', abbr: '' },
                select_tipo_equipo:{ state: '', abbr: '' },
                items_marca:[],
                items_tipo_equipo:[],
                idmarca:0,
                allPropietario :false,
                idtipo_equipo:0,
                nombre_equipo:'',
                usuario_equipo:'',
                procesador:'',
                memoria_ram:'',
                disco_duro:'',
                ip:'',
                mascara_sub_red:'',
                puerta_enlace:'',
                dns_preferido:'',
                dns_alternativo:'',
                dominio:false,
                antivirus:false,
                sistema_operativo:'',                
                mostrar_agregar:false,                
                dialog: false,
                idequipo:0,
                eseditar:false,
                texto_guardar:'Guardar',
                descripcion:'',
                search: '',        
                singleSelect:true,
                selected: [],
                headers2 :[
                      {
                    text: 'Id',          
                    value: 'id',
                    },          
                    { text: 'Propietario', value: 'propietario' },
                    { text: 'Estado', value: 'estado'},
                    { text: 'Idusuario', value: 'idusuario'}
                ],
                headers: [

                {
                    text: 'Id Equipo',          
                    value: 'id',
                },          
                { text: 'Marca', value: 'marca' },
                { text: 'Tipo_equipo', value: 'tipo_equipo' },
                { text: 'Nombre Equipo', value: 'nombre_equipo' },
                { text: 'Usuario Equipo', value: 'usuario_equipo' },
                { text: 'Procesador', value: 'marca' },
                { text: 'Memoria Ram', value: 'memoria_ram' },
                { text: 'Disco Duro', value: 'disco_duro' },
                { text: 'IP', value: 'ip' },
                { text: 'Mascara sub red', value: 'mascara_sub_red' },
                { text: 'Puerta Enlace', value: 'puerta_enlace' },
                { text: 'Dns Preferido', value: 'dns_preferido' },
                { text: 'Dns Alternativo', value: 'dns_alternativo' },
                { text: 'Dominio', value: 'dominio' },
                { text: 'Antivirus', value: 'antivirus' },
                { text: 'Sistema Operativo', value: 'sistema_operativo' },
                { text: 'Fecha', value: 'fecha' },
                { text: 'Estado', value: 'estado' },
                { text: 'Id Marca', value: 'idmarca' },
                { text: 'Id Tipo Equipo', value: 'idtipo_equipo' },
                
                ],
                items:[], 
                    }
            },
            methods:{
                AgregarPropietarioEvento(){
                    this.dialogAgregarPropietario = true;

                    axios.get("http://localhost:8080/inventario/Database/BackEnd/usuario.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        let json = [];
                        if(response.status == 200){
                        respuesta.forEach(element=>{
                            json.push(
                                {
                                    "state":element.nombres,
                                    "abbr": element.idusuario
                                }
                            );
                        })
                       
                        this.items_usuarios = json;
                        
                        
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                        console.log(e);
                    })                                                                                                                                            
                },                 
                mostarHistorial(id){
                    var newItems =  this.items_propietario.filter(
                        items=>items.id_equipo === id
                    )
                    this.items_propietario = newItems;    
                },
                LlenarTipos(){
                        axios.get("http://localhost:8080/inventario/Database/BackEnd/tipo_equipo.php?op=show")
                        .then(response => {
                            // Obtenemos los datos
                            let respuesta = response.data;
                            let json = [];
                            if(response.status == 200){
                            respuesta.forEach(element=>{
                                json.push(
                                    {
                                        "state":element.descripcion,
                                        "abbr": element.idtipo_equipo
                                    }
                                );
                            })
                            this.items_tipo_equipo = json;
                            
                            
                            }
                        })
                        .catch(e => {
                            // Capturamos los errores
                            console.log(e);
                        })

                        //

                        axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=show")
                        .then(response => {
                            // Obtenemos los datos
                            let respuesta = response.data;
                            let json = [];
                            if(response.status == 200){
                            respuesta.forEach(element=>{
                                json.push(
                                    {
                                        "state":element.nombre,
                                        "abbr": element.idmarca
                                    }
                                );
                            })
                            this.items_marca = json;
                            
                            
                            }
                        })
                        .catch(e => {
                            // Capturamos los errores
                            console.log(e);
                        })
                    },

                agregarEvento(){
                   if(this.mostrar_agregar == true){
                       this.mostrar_agregar = false;
                   }
                   else this.mostrar_agregar = true;
                },
                verPropietario(){
                   
            
                var idequipo = this.selected[0].id;
                let tamanio= this.selected.length;
                   if(tamanio>0){
                       
                    this.dialog_modal = true;
                    axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=showPropietario&idequipo="+idequipo)
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        
                        if(response.status == 200){
                            
                            
                           this.items_propietario = respuesta;
                        
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                         console.log(e);
                    })

                    }           
                    else{
                        alert("¡Porfavor seleccione un equipo!");
                    }  
                },
                guardar(){

                    let idmarca = this.select_marca.abbr;
                    let idtipo_equipo = this.select_tipo_equipo.abbr;
                    let nombre_equipo = this.nombre_equipo;
                    let usuario_equipo = this.usuario_equipo;
                    let procesador = this.procesador;
                    let memoria_ram = this.memoria_ram;
                    let disco_duro = this.disco_duro;
                    let ip = this.ip;
                    let mascara_sub_red = this.mascara_sub_red;
                    let puerta_enlace = this.puerta_enlace;
                    let dns_preferido = this.dns_preferido;
                    let dns_alternativo = this.dns_alternativo;
                    let dominio = this.dominio;
                    let antivirus = this.antivirus;
                    let sistema_operativo = this.sistema_operativo;                    
                    let id = parseInt(this.idequipo);

                  
                    
                    if(nombre_equipo.trim().length == 0 || usuario_equipo.trim().length == 0 || procesador.trim().length == 0 || memoria_ram.trim().length == 0 || disco_duro.trim().length == 0)
                    {
                        alert("¡Verifique la descripción!");
                        return;
                    }

                   
                    if(!this.eseditar){
                      

                        axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=insert&idmarca="+ idmarca+"&idtipo_equipo="+idtipo_equipo+"&nombre_equio="+nombre_equipo+
                        "&usuario_equipo="+usuario_equipo+"&procesador="+procesador+"&memoria_ram="+memoria_ram+"&disco_duro="+disco_duro+"&ip="+ip+"&mascara_sub_red="+mascara_sub_red+
                        "&puerta_enlace="+puerta_enlace+"&dns_preferido="+dns_preferido+"&dns_alternativo="+dns_alternativo+"&dominio="+dominio+"&antivirus="+antivirus+"&sistema_operativo="+sistema_operativo)
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
                       
                        axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=update&id="+id+"&idmarca="+ idmarca+"&idtipo_equipo="+idtipo_equipo+"&nombre_equio="+nombre_equipo+
                        "&usuario_equipo="+usuario_equipo+"&procesador="+procesador+"&memoria_ram="+memoria_ram+"&disco_duro="+disco_duro+"&ip="+ip+"&mascara_sub_red="+mascara_sub_red+
                        "&puerta_enlace="+puerta_enlace+"&dns_preferido="+dns_preferido+"&dns_alternativo="+dns_alternativo+"&dominio="+dominio+"&antivirus="+antivirus+"&sistema_operativo="+sistema_operativo)
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
                       alert("¡Porfavor seleccione un equipo!");
                   }      
                },
                borrar(valor){
                   
                    if(valor){
                            

                            this.selected.forEach(element => {                  
                            axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=delete&id="+element.id)
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
                        this.LlenarTipos();

                        this.idequipo = this.selected[0].id;
                        this.idmarca = this.selected[0].idmarca;
                        this.idtipo_equipo = this.selected[0].idtipo_equipo;
                        //
                        this.select_marca = this.items_marca.filter(valor => valor.abbr == this.idmarca)[0];
                        this.select_tipo_equipo = this.items_tipo_equipo.filter(valor => valor.abbr == this.idtipo_equipo)[0];
                        //
                        this.nombre_equipo = this.selected[0].nombre_equipo;                        
                        this.usuario_equipo = this.selected[0].usuario_equipo;
                        this.procesador = this.selected[0].procesador;
                        this.memoria_ram = this.selected[0].memoria_ram;
                        this.disco_duro = this.selected[0].disco_duro;                    
                        this.ip = this.selected[0].ip;
                        this.mascara_sub_red = this.selected[0].mascara_sub_red;
                        this.puerta_enlace = this.selected[0].puerta_enlace;                
                        this.dns_preferido = this.selected[0].dns_preferido;
                        this.dns_alternativo = this.selected[0].dns_alternativo;
                        
                        this.dominio = this.selected[0].dominio[0] == "S"?true:false;
                        this.antivirus = this.selected[0].antivirus[0] == "S"?true:false;
                        this.sistema_operativo = this.selected[0].sistema_operativo;
                        this.texto_guardar = "Guardar Edición";
                        this.eseditar = true;
                        this.mostrar_agregar = true;
                        
                    }
                    else{
                        alert("¡Porfavor seleccione un equipo!");
                    }                    
                },

                limpiar(){
                     
                    try {
                        this.texto_guardar = "Guardar";
                        this.eseditar = false;
                        this.selected = [];

                        this.select_marca = [];
                        this.select_tipo_equipo = [];
                        this.nombre_equipo = "";
                        this.usuario_equipo = "";
                        this.procesador = "";
                        this.memoria_ram = "";
                        this.disco_duro = "";
                        this.ip = "";
                        this.mascara_sub_red = "";
                        this.puerta_enlace = "";
                        this.dns_preferido = "";
                        this.dns_alternativo = "";
                        this.dominio = false;
                        this.antivirus = false;
                        this.sistema_operativo = "";        
                    } catch (error) {
                        console.log(error);
                    }            
                    
                },
                mostrar(){
                 
                    axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=show")
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
                },
           
             mounted(){

              

                        
                axios.get("http://localhost:8080/inventario/Database/BackEnd/equipo.php?op=show")
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

                    //marcas
                   
                        axios.get("http://localhost:8080/inventario/Database/BackEnd/marca.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        
                        if(response.status == 200){
                                let json = [];
                               respuesta.forEach(element=>{
                               json.push(
                                   {
                                       "state":element.nombre,
                                       "abbr": element.idmarca
                                   }
                               );
                           })
                           this.items_marca = json;
                        }
                    })
                    .catch(e => {
                        // Capturamos los errores
                         console.log(e);
                    })


                    //tipo-equipos

                    axios.get("http://localhost:8080/inventario/Database/BackEnd/tipo_equipo.php?op=show")
                    .then(response => {
                        // Obtenemos los datos
                        let respuesta = response.data;
                        
                        if(response.status == 200){
                       
                            let json = [];
                            respuesta.forEach(element=>{
                            json.push(
                                   {
                                       "state":element.descripcion,
                                       "abbr": element.idtipo_equipo
                                   }
                               );
                           })
                           this.items_tipo_equipo = json;
                           
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