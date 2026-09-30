<script setup lang="ts">
import { ref } from 'vue'

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
</script>

<template>
  <div class="admin-shell">
    <div class="admin-panel">
      <h1>后台管理</h1>
      <p>新增/编辑 Java 知识点与示例代码</p>

      <form class="admin-form" @submit.prevent="saveContent">
        <label>
          <span>标题</span>
          <input v-model="form.title" placeholder="例如：Java 变量与数据类型" />
        </label>
        <label>
          <span>概述</span>
          <textarea v-model="form.summary" placeholder="输入知识点概述" />
        </label>
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
          <textarea v-model="form.code" rows="10" placeholder="输入示例代码" />
        </label>
        <button type="submit">保存内容</button>
      </form>

      <div v-if="saved" class="success">保存成功</div>
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

