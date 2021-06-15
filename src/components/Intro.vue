<template>
  <n-card :title="contentText.introTitle">
    <p v-html="contentText.introOne" />

    <n-button text type="primary" @click="introVisible = true">{{
      contentText.explainTitle
    }}</n-button>

    <p v-html="contentText.introTwo" />

    <n-modal v-model:show="introVisible">
      <n-card
        :title="contentText.explainTitle"
        closable
        @close="introVisible = false"
      >
        <p v-html="contentText.explain"></p>
      </n-card>
    </n-modal>
  </n-card>
</template>

<script lang="ts">
import { ref, defineComponent, Ref, PropType, toRef, computed } from 'vue';
import { NCard, NButton, NModal } from 'naive-ui';
import content from '../content.js';

export default defineComponent({
  name: 'Intro',
  components: {
    NCard,
    NButton,
    NModal,
  },
  props: {
    lang: {
      type: String as PropType<'en-US' | 'zh-CN'>,
    },
  },
  setup: (props) => {
    const lang = toRef(props, 'lang');
    const contentText = computed(() => content[lang.value]);
    const introVisible: Ref<boolean> = ref(false);
    return { lang, contentText, introVisible };
  },
});
</script>

<style scoped></style>
