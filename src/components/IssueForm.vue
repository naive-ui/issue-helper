<template>
  <n-card class="card">
    <n-form
      ref="formRef"
      :model="form"
      label-width="auto"
      :rules="rules"
      label-position="top"
      size="large"
      class="form"
    >
      <n-grid cols="2" :x-gap="16">
        <!-- 选择要提交的库 -->
        <n-form-item-gi :label="contentText.repoSelectHint" path="repo">
          <n-select
            placeholder="请选择"
            v-model:value="form.repo"
            :options="repoOptions"
            class="form-select"
          />
        </n-form-item-gi>

        <!-- Issue 类别 -->

        <n-form-item-gi :label="contentText.issueTypesHint" path="type">
          <n-select
            placeholder="请选择"
            v-model:value="form.type"
            :options="issueTypeOptions"
            class="form-select"
          />
        </n-form-item-gi>
      </n-grid>

      <!-- Issue 标题 -->
      <n-form-item :label="contentText.issueTitleHint" path="title">
        <n-input v-model:value="form.title" />
      </n-form-item>

      <template v-if="isBug">
        <!-- 项目版本 -->
        <n-form-item
          :label="contentText.versionRepositoryHint"
          path="versionRepository"
        >
          <n-select
            placeholder="请选择"
            v-model:value="form.versionRepository"
            :options="version.repo"
            class="form-select"
          />
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          show-icon
          :title="contentText.firstTipTitle"
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{ contentText.firstTip }}</span>
        </n-alert>

        <n-grid cols="2" :x-gap="16">
          <!-- Vue版本 -->
          <n-form-item-gi :label="contentText.versionVueHint" path="versionVue">
            <n-select
              placeholder="请选择"
              v-model:value="form.versionVue"
              :options="version.vue"
              class="form-select"
            />
          </n-form-item-gi>

          <!-- 浏览器及其版本 -->
          <n-form-item-gi
            :label="contentText.versionBrowserHint"
            path="versionBrowser"
          >
            <n-input
              v-model:value="form.versionBrowser"
              placeholder="Chrome(89.0.4389.128)"
            />
          </n-form-item-gi>
        </n-grid>

        <n-grid cols="2" :x-gap="16">
          <!-- 系统及其版本 -->
          <n-form-item-gi
            :label="contentText.versionSystemHint"
            path="versionSystem"
          >
            <n-input
              v-model:value="form.versionSystem"
              placeholder="MacOS(11.2.3)"
            />
          </n-form-item-gi>

          <!-- Node版本 -->
          <n-form-item-gi
            :label="contentText.versionNodeHint"
            path="versionNode"
          >
            <n-input v-model:value="form.versionNode" />
          </n-form-item-gi>
        </n-grid>

        <!-- 重现链接 -->
        <n-form-item :label="contentText.reproduceHint" path="reproduce">
          <n-input v-model:value="form.reproduce" />
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          show-icon
          :title="contentText.secondTipTitle"
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{ contentText.secondTip }}</span></n-alert
        >
        <n-button
          text
          type="primary"
          @click="tipVisible = true"
          class="m-b-24"
          >{{ contentText.reproduceHintSamll }}</n-button
        >
        <n-modal v-model:show="tipVisible">
          <n-card
            :title="contentText.reproduceTitle"
            closable
            @close="tipVisible = false"
          >
            <n-p v-html="contentText.reproduceExplain" />
            <n-h3>{{ contentText.reproduceExplainTitleOne }}</n-h3>
            <n-p v-html="contentText.reproduceExplainParagraphOne" />
            <n-h3>{{ contentText.reproduceExplainTitleTwo }}</n-h3>
            <n-p>
              <n-text strong>{{ contentText.keyWords }}</n-text
              ><n-text v-html="contentText.reproduceExplainParagraphTwo" />
            </n-p>
            <n-h3>{{ contentText.reproduceExplainTitleThree }}</n-h3>
            <n-p v-html="contentText.reproduceExplainParagraphThree" />
            <n-h3>{{ contentText.reproduceExplainTitleFour }}</n-h3>
            <n-p v-html="contentText.reproduceExplainParagraphFour" />
          </n-card>
        </n-modal>

        <!-- 重现步骤 -->
        <n-form-item
          :label="contentText.stepsHint"
          path="steps"
          ingore-path-change
        >
          <n-input v-model:value="form.steps" type="textarea" />
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          show-icon
          :title="contentText.thirdTipTitle"
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{ contentText.thirdTip }}</span></n-alert
        >

        <!-- 期望的结果是什么 -->
        <n-form-item :label="contentText.expectHint" path="expected">
          <n-input v-model:value="form.expected" type="textarea"></n-input>
        </n-form-item>

        <!-- 实际的结果是什么 -->
        <n-form-item :label="contentText.actualHint" path="actual">
          <n-input v-model:value="form.actual" type="textarea"></n-input>
        </n-form-item>

        <!-- 补充说明（可选） -->
        <n-form-item :label="contentText.remarks">
          <n-input v-model:value="form.remarks" type="textarea"></n-input>
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          show-icon
          :title="contentText.fourthTipTitle"
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{ contentText.fourthTip }}</span></n-alert
        >
      </template>

      <template v-else>
        <!-- 这个功能解决了什么问题 -->
        <n-form-item
          :label="contentText.functionContent"
          path="functionContent"
        >
          <n-input v-model:value="form.functionContent" />
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          :title="contentText.functionContentTipTitle"
          show-icon
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{
            contentText.functionContentTip
          }}</span></n-alert
        >

        <!-- 你期望的 API 是怎样的 -->
        <n-form-item
          :label="contentText.functionalExpectations"
          path="functionalExpectations"
        >
          <n-input
            v-model:value="form.functionalExpectations"
            type="textarea"
          ></n-input>
        </n-form-item>
        <n-alert
          type="default"
          class="m-b-24"
          :title="contentText.functionalExpectationsTipTitle"
          show-icon
        >
          <template #icon>
            <n-icon>
              <info-24-regular />
            </n-icon>
          </template>
          <span class="alert-font">{{
            contentText.functionalExpectationsTip
          }}</span></n-alert
        >
      </template>

      <n-form-item class="preview">
        <n-button type="primary" @click="handlePreview()">{{
          contentText.preview
        }}</n-button>
      </n-form-item>
    </n-form>
  </n-card>

  <n-modal v-model:show="previewVisible">
    <n-card
      :title="contentText.dialog.title"
      closable
      @close="previewVisible = false"
      class="modal-card"
    >
      <div v-html="issueHTML" class="preview-content"></div>
      <div class="preview-footer">
        <n-button type="primary" size="large" @click="create()">{{
          contentText.dialog.button
        }}</n-button>
      </div>
    </n-card>
  </n-modal>
</template>

<script lang="ts">
import {
  ref,
  defineComponent,
  Ref,
  reactive,
  toRefs,
  computed,
  watch,
  onMounted,
  PropType,
  toRef,
  h,
} from 'vue';
import {
  NForm,
  NFormItem,
  NFormItemGi,
  NGrid,
  NSelect,
  NInput,
  NAlert,
  NButton,
  NIcon,
  NModal,
  NCard,
  NH3,
  NText,
  NP,
  useMessage,
} from 'naive-ui';
import { Info24Regular } from '@vicons/fluent';
import axios from 'axios';
import marked from 'marked';
import hanabi from 'hanabi';
import content from '../content.js';
import { FormData, RepoItem } from '../data';

marked.setOptions({
  renderer: new marked.Renderer(),
  highlight: (code: any) => hanabi(code),
  pedantic: false,
  gfm: true,
  breaks: false,
  sanitize: false,
  smartLists: true,
  smartypants: false,
  xhtml: false,
});

const comment = '<!-- generated by issue-helper DO NOT REMOVE -->';

export default defineComponent({
  name: 'IssueForm',
  components: {
    NForm,
    NFormItem,
    NFormItemGi,
    NGrid,
    NSelect,
    NInput,
    NAlert,
    NButton,
    NIcon,
    NModal,
    NCard,
    NH3,
    NText,
    NP,
    Info24Regular,
  },
  props: {
    lang: {
      type: String as PropType<'en-US' | 'zh-CN'>,
    },
  },
  setup: (props) => {
    const lang = toRef(props, 'lang');
    const message = useMessage();
    const contentText = computed(() => content[lang.value]);
    const repoOptions = computed(() =>
      contentText.value.repos.map((i) => {
        return { label: i.name, value: i.github };
      })
    );
    const issueTypeOptions = computed(() => contentText.value.issueTypes);
    const formRef: Ref<any> = ref(null);
    const formData: FormData = reactive({
      form: {
        repo: 'TuSimple/naive-ui',
        title: '',
        type: 'Bug',
        versionRepository: '',
        versionVue: '',
        versionBrowser: '',
        versionSystem: '',
        versionNode: '',
        reproduce: '',
        steps: '',
        expected: '',
        actual: '',
        remarks: '',
        functionContent: '',
        functionalExpectations: '',
      },
      version: {
        repo: [],
        vue: [],
      },
    });
    const issue: Ref<string> = ref('');
    const issueHTML = computed(() => marked(issue.value));
    const tipVisible: Ref<boolean> = ref(false);
    const previewVisible: Ref<boolean> = ref(false);

    const isBug = computed(() => formData.form.type === 'Bug');

    const rules = computed(() => {
      const valid = contentText.value.valid;
      let rules: any = {};
      for (let prop in valid) {
        if (prop === 'remarks' || prop === 'versionNode') {
          continue;
        }
        rules[prop] = [
          {
            required: true,
            message: valid[prop],
            trigger: ['blur', 'change', 'input'],
          },
        ];
      }

      rules['reproduce'].push({
        trigger: ['blur', 'change'],
        message: '请填写正确的重现链接',
        validator: (rule: any, val: string) => {
          return new Promise((resolve, reject) => {
            if (
              val &&
              !/(github|jsfiddle|codepen|jsbin|codesandbox|stackblitz)/gi.test(
                val
              )
            ) {
              reject(Error('请填写正确的重现链接'));
            } else {
              resolve('');
            }
          });
        },
      });
      return rules;
    });

    const versionApi = computed(() => {
      const selectRepo = contentText.value.repos.find(
        (i) => i.github === formData.form.repo
      );
      return {
        repositoryVersion: `https://registry.npm.taobao.org/${
          selectRepo.npm && selectRepo.npm
        }`,
        vueVersion: 'https://registry.npm.taobao.org/vue',
      };
    });

    async function fetchRepositoryVersion() {
      const res = await axios.get(versionApi.value.repositoryVersion);
      formData.version.repo = Object.keys(res.data.versions).map((i) => {
        return { label: i, value: i };
      });
      formData.form.versionRepository = formData.version.repo[0].value;
      const vueRes = await axios.get(versionApi.value.vueVersion);
      formData.version.vue = Object.keys(vueRes.data.versions).map((i) => {
        return { label: i, value: i };
      });
      formData.form.versionVue = formData.version.vue[0].value;
    }
    onMounted(() => {
      fetchRepositoryVersion();
    });
    watch(
      () => formData.form.repo,
      () => {
        fetchRepositoryVersion();
      }
    );

    function createIssue() {
      issue.value = isBug.value
        ? `
### ${formData.form.repo} version (版本)
${formData.form.versionRepository}

### Vue version (Vue 版本)
${formData.form.versionVue}

### Browser and its version (浏览器及其版本)
${formData.form.versionBrowser}

### System and its version (系统及其版本)
${formData.form.versionSystem}

### Node version (Node 版本)
${formData.form.versionNode}

### Reappearance link (重现链接)
${formData.form.reproduce}

### Reappearance steps (重现步骤)
${formData.form.steps}

### Expected results (期望的结果)
${formData.form.expected}

### Actual results (实际的结果)
${formData.form.actual}

### Remarks (补充说明)
${formData.form.remarks}

`.trim()
        : `

### This function solves the problem (这个功能解决的问题)
${formData.form.functionContent}

### Expected API (期望的 API)
${formData.form.functionalExpectations}

`.trim();
      previewVisible.value = true;
    }

    function handlePreview() {
      formRef.value.validate((errors: Array<{ message: string }[]>) => {
        if (!errors) {
          createIssue();
        } else {
          errors.forEach((item) => {
            message.error(item[0].message);
          });
          return false;
        }
      });
    }

    const body = computed(() => {
      const issueString = `
${comment}

${issue.value}

${comment}
`;
      return encodeURIComponent(issueString).replace(/%2B/gi, '+');
    });

    function create() {
      window.open(
        `https://github.com/${formData.form.repo}/issues/new?title=${formData.form.title}&body=${body.value}`
      );
    }
    return {
      ...toRefs(formData),
      lang,
      contentText,
      repoOptions,
      issueTypeOptions,
      formRef,
      rules,
      tipVisible,
      isBug,
      previewVisible,
      handlePreview,
      issueHTML,
      create,
    };
  },
});
</script>

<style scoped>
.card {
  margin-bottom: 24px;
}

.modal-card {
  width: calc(var(--content-width) + 32px);
  max-width: var(--content-max-width);
  margin-top: 32px;
  margin-bottom: 32px;
}

.form {
  margin-top: 10px;
}

.form-select {
  width: 100%;
}

.m-b-24 {
  margin-bottom: 24px;
}

.preview {
  margin-bottom: 10px;
  display: flex;
  justify-content: center;
}

.preview-content {
  word-wrap: break-word;
  word-break: normal;
  overflow: hidden;
}

.preview-footer {
  width: 100%;
  display: flex;
  justify-content: center;
}
</style>
