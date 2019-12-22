<template>
    <div class="config">
        <div class=" display-3 text-center pt-10 pb-10">
            Configuración del sitio
        </div>        


        <template>
            <v-card >
                <v-toolbar flat color="primary" dark>
                <v-toolbar-title>Configuración</v-toolbar-title>
                </v-toolbar>
                <v-tabs vertical >
                <v-tab>
                    
                    Areas
                </v-tab>
                <v-tab>
                    
                    Marcas
                </v-tab>
                <v-tab>
                   
                    Tipo Equipo
                </v-tab>

                <v-tab>
                    
                    Tipo Usuario
                </v-tab>

                <v-tab>
                    
                    Usuarios
                </v-tab>

                 <v-tab>                    
                    Equipo
                </v-tab>

                 <v-tab>                    
                    Impresoras
                </v-tab>


                <v-tab-item>
                    <v-card flat>
                   <Area/>
                    </v-card>
                </v-tab-item>
                <v-tab-item>
                    <v-card flat>
                    <Marca/>
                    </v-card>
                </v-tab-item>
                <v-tab-item>
                    <v-card flat>
                    <Tipo_Equipo/>
                    </v-card>
                </v-tab-item>

                <v-tab-item>
                    <v-card flat>
                    <Tipo_Usuario/>
                    </v-card>
                </v-tab-item>

                 <v-tab-item>
                    <v-card flat>
                    <Usuario class="card"/>
                    </v-card>
                </v-tab-item>

                <v-tab-item>
                    <v-card flat>
                    <Equipo/>
                    </v-card>
                </v-tab-item>

                <v-tab-item>
                    <v-card flat>
                    <Impresoras/>
                    </v-card>
                </v-tab-item>

                </v-tabs>
            </v-card>
        </template>

        <div>
        </div>    
    </div>
</template>

<script>
import Area from '@/components/Config/Area.vue'
import Marca from '@/components/Config/Marca.vue'
import Tipo_Equipo from '@/components/Config/Tipo_Equipo.vue'
import Tipo_Usuario from '@/components/Config/Tipo_Usuario.vue'
import Usuario from '@/components/Config/Usuario.vue'
import Equipo from '@/components/Config/Equipo.vue'
import Impresoras from '@/components/Config/Impresoras.vue'

    export default {
        name:'Configuracion',
        components:{
            Area,
            Marca,
            Tipo_Equipo,
            Tipo_Usuario,
            Usuario,
            Equipo,
            Impresoras
        }
    }
</script>

<style lang="scss" scoped>
.config{
    padding-top: 65px;
}
.card{
    position: relative;
    
}
</style>