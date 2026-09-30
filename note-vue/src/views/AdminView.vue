<script setup lang="ts">
import { ref, computed } from 'vue'
import { marked } from 'marked'
import DOMPurify from 'dompurify'

const form = ref({
  title: '',
  summary: '',
  difficulty: 'BEGINNER',
  moduleId: 1,
  code: '',
})

const saved = ref(false)

async function saveContent() {
  saved.value = true
  setTimeout(() => {
    saved.value = false
  }, 1200)
}

const summaryPreview = computed(() => {
  if (!form.value.summary) return ''
  return DOMPurify.sanitize(marked.parse(form.value.summary))
})
const previewFallback = '<p class="muted">（无预览）</p>'
</script>

<template>
  <div class="admin-shell">
    <div class="admin-panel">
      <h1>内容管理</h1>
      <p>新增或编辑知识项与示例</p>

      <form class="admin-form" @submit.prevent="saveContent">
        <label>
          <span>标题</span>
          <input v-model="form.title" placeholder="例：变量与类型" />
        </label>
        <label>
          <span>概述</span>
          <textarea v-model="form.summary" placeholder="简要概述" />
        </label>
        <div class="preview">
          <div class="preview-title">预览</div>
          <div class="preview-body" v-html="summaryPreview || previewFallback"></div>
        </div>
        <label>
          <span>难度</span>
          <select v-model="form.difficulty">
            <option value="BEGINNER">BEGINNER</option>
            <option value="INTERMEDIATE">INTERMEDIATE</option>
            <option value="ADVANCED">ADVANCED</option>
          </select>
        </label>
        <label>
          <span>代码</span>
          <textarea v-model="form.code" rows="10" placeholder="示例代码" />
        </label>
        <button type="submit">保存</button>
      </form>

      <div v-if="saved" class="success">已保存</div>
    </div>
  </div>
</template>

<style scoped>
.admin-shell {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #eff6ff;
  padding: 24px;
}
.admin-panel {
  width: min(900px, 100%);
  background: white;
  border-radius: 18px;
  padding: 30px;
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.08);
}
.admin-form {
  display: grid;
  gap: 16px;
}
.admin-form label {
  display: grid;
  gap: 8px;
  font-weight: 600;
}
.preview {
  background: #f8fafc;
  padding: 12px;
  border-radius: 8px;
}
.preview-title { font-weight: 700; margin-bottom: 8px }
.preview-body { color: #0f172a }
input,
textarea,
select,
button {
  font: inherit;
}
input,
textarea,
select {
  width: 100%;
  border: 1px solid #cbd5e1;
  border-radius: 10px;
  padding: 12px;
}
button {
  border: none;
  background: #2563eb;
  color: white;
  padding: 12px 18px;
  border-radius: 10px;
  width: fit-content;
  cursor: pointer;
}
.success {
  margin-top: 14px;
  color: #166534;
  font-weight: 700;
}
</style>

