<template>
  <IssuePage />
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import IssuePage from './components/IssuePage.vue';

export default defineComponent({
  name: 'App',
  components: {
    IssuePage,
  },
});
</script>

<style>
html,
body,
#app {
  margin: 0;
  padding: 0;
  height: 100%;
  min-width: 320px;
  --header-height: 64px;
}

#app {
  height: 100%;
}

body {
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB',
    'Microsoft YaHei', SimSun, sans-serif;
  overflow: auto;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
}

a {
  color: #18a058;
  text-decoration: none;
}

button,
input,
select,
textarea {
  font-family: inherit;
  font-size: inherit;
  line-height: inherit;
  color: inherit;
}
</style>
