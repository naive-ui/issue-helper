<template>
  <PageHead :lang="lang" @langChange="setLang"/>
  <div class="content-box">
    <div class="content"><Intro :lang="lang" /></div>
    <div class="content"><IssueForm :lang="lang" /></div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from 'vue';
import PageHead from './PageHead.vue';
import Intro from './Intro.vue';
import IssueForm from './IssueForm.vue';
import { getQuery, updateQuery } from './utils';

export default defineComponent({
  name: 'IssuePage',
  components: {
    PageHead,
    Intro,
    IssueForm,
  },
  setup: () => {
    const lang = ref<'en-US' | 'zh-CN'>('en-US');

    const setLang = (value: 'en-US' | 'zh-CN') => {
      lang.value = value;
      updateQuery({ lang: value });
    };

    onMounted(() => {
      const param = getQuery();
      if (!param?.lang) {
        updateQuery({ lang: lang.value });
      } else {
        setLang(param.lang);
      }
    });

    return {
      lang,
      setLang
    };
  },
});
</script>

<style scoped>
.content-box {
  margin: auto;
  width: var(--content-width);
  max-width: var(--content-max-width);
}

.content {
  margin-top: 40px;
}
</style>
