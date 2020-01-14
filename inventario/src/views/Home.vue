<template>
  <div class="home">   
    <Home/>
  </div>
</template>

<script>
// @ is an alias to /src
import Menu from '@/components/Menu.vue'
import Home from '@/components/Home.vue'


export default {
  name: 'home',
  components: {
    Home,
    Menu,
    
  }
}
</script>
