import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Configuracion from '../views/Configuracion.vue'
import Chat from '../views/Chat.vue'
import privateChat   from '../views/Privatechat.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/home',
    name: 'home',
    component: Home
  },
  {
    path: '/configuracion',
    name: 'configuracion',
    component: Configuracion
  },
  {
    path: '/chat',
    name: 'chat',
    component: Chat
  },
  {
    path:'/privateChat' ,
    name : 'privatechat',
    component : privateChat
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
