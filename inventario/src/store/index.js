import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    login:[],
    logueado:false,
    admin: false,
     
  },
  mutations: {
    MUTATE_LOGIN:(state, items) => {
      Vue.set(state, "login",items);
      Vue.set(state, "logueado", true);
      Vue.set(state, "admin", false);
    },
    MUTATE_LOGIN_ADMIN:(state, items) => {
      Vue.set(state, "login",items);
      Vue.set(state, "logueado", true);
      Vue.set(state, "admin", true);
      
    },
    CLEAR_LOGIN:(state, items) => {
      Vue.set(state, "login", items);
      Vue.set(state, "logueado", false)
      Vue.set(state, "admin", false)
    },

    ADMIN_TRUE:(state) => {
      Vue.set(state, "admin", true);   
       
    },
    ADMIN_FALSE:(state) => {
      Vue.set(state, "admin", false);      
    }
  },
  actions: {
    AddLogin: (context, items) => {
      context.commit("MUTATE_LOGIN", items);      
    },
    AddLoginAdmin: (context, items)=>{
      context.commit("MUTATE_LOGIN_ADMIN", items);      
    },
    ClearLogin: (context, items) => {
      context.commit("CLEAR_LOGIN", items);      
    },
    Admin_True: (context) => {
      context.commit("ADMIN_TRUE");  
    },
    Admin_False: (context) => {
      context.commit("ADMIN_FALSE");  
    }
  },
  modules: {
  }
})
