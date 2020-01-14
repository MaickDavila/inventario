import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Configuracion from '../views/Configuracion.vue'
import Chat from '../views/Chat.vue'
import privateChat   from '../views/Privatechat.vue'
import login  from '../views/Login.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: login
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
  },{
    path:'/login' ,
    name : 'login',
    component : login
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes
})

export default router

