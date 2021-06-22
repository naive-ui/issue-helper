<template>
  <n-message-provider>
    <IssuePage />
  </n-message-provider>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { NMessageProvider } from 'naive-ui';
import IssuePage from './components/IssuePage.vue';

export default defineComponent({
  name: 'App',
  components: {
    IssuePage,
    NMessageProvider,
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
  --content-width: 900px;
  --content-max-width: calc(100vw - 32px);
}

body {
  overflow: auto;
  -webkit-font-smoothing: antialiased;
}

a {
  text-decoration: none;
}

.modal-card {
  width: calc(var(--content-width) + 32px);
  max-width: var(--content-max-width);
  margin-top: 32px;
  margin-bottom: 32px;
}
</style>
