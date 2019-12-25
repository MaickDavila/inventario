import '@fortawesome/fontawesome-free/css/all.css' // Ensure you are using css-loader
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';
import Chat from 'vue-beautiful-chat'
import Notifications from 'vue-notification'
Vue.use(Notifications)
Vue.use(Chat)

Vue.config.productionTip = false

new Vue({
  iconfont: 'fa',
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
