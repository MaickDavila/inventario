import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    login:[],
    logueado:false,
  },
  mutations: {
    MUTATE_LOGIN:(state, items) => {
      Vue.set(state, "login",items);
      Vue.set(state, "logueado", true)
    }
  },
  actions: {
    AddLogin: (context, items) => {
      context.commit("MUTATE_LOGIN", items);      
    }
  },
  modules: {
  }
})
