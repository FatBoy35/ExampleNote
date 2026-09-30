<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
import { marked } from 'marked'
import DOMPurify from 'dompurify'

interface Language {
  id: number
  name: string
  slug: string
  description: string
}

interface ModuleItem {
  id: number
  name: string
  description: string
  slug: string
}

interface KnowledgePoint {
  id: number
  title: string
  summary: string
  contentMarkdown: string
  difficulty: string
}

interface CodeExample {
  id: number
  title: string
  code: string
  expectedOutput: string
}

const languages = ref<Language[]>([])
const modules = ref<ModuleItem[]>([])
const knowledgePoints = ref<KnowledgePoint[]>([])
const examples = ref<CodeExample[]>([])
const selectedLanguageId = ref<number>(1)
const selectedModuleId = ref<number>(1)
const selectedKnowledgeId = ref<number | null>(null)
const activeExample = ref<CodeExample | null>(null)
const output = ref('')
const loading = ref(false)

const apiBase = 'http://localhost:8080/api'

async function fetchJson<T>(url: string): Promise<T> {
  const res = await fetch(url)
  if (!res.ok) {
    throw new Error('请求失败')
  }
  const body = await res.json()
  return body.data
}

async function loadLanguages() {
  languages.value = await fetchJson<Language[]>(`${apiBase}/languages`)
}

async function loadModules() {
  modules.value = await fetchJson<ModuleItem[]>(`${apiBase}/modules/${selectedLanguageId.value}`)
  if (modules.value.length > 0) {
    const firstModule = modules.value[0]
    if (firstModule) {
      selectedModuleId.value = firstModule.id
      await loadKnowledgePoints()
    }
  }
}

async function loadKnowledgePoints() {
  if (!selectedModuleId.value) return
  const list = await fetchJson<KnowledgePoint[]>(`${apiBase}/knowledge-points/${selectedModuleId.value}`)
  knowledgePoints.value = list
  if (list.length > 0) {
    const firstPoint = list[0]
    if (firstPoint) {
      selectedKnowledgeId.value = firstPoint.id
      await loadExamples(firstPoint.id)
    }
  } else {
    selectedKnowledgeId.value = null
    examples.value = []
    activeExample.value = null
    output.value = ''
  }
}

async function loadExamples(knowledgePointId: number) {
  const list = await fetchJson<CodeExample[]>(`${apiBase}/examples/${knowledgePointId}`)
  examples.value = list
  activeExample.value = list[0] ?? null
  output.value = ''
}

function selectKnowledge(id: number) {
  selectedKnowledgeId.value = id
  loadExamples(id)
}

function runJavaCode() {
  if (!activeExample.value) return
  const code = activeExample.value.code

  // show a concise preview and expected output
  output.value = `${code.trim().split('\n').slice(0, 8).join('\n')}\n\n预期：${activeExample.value.expectedOutput || 'Hello, Java!'}`
}

onMounted(async () => {
  loading.value = true
  try {
    await loadLanguages()
    await loadModules()
  } finally {
    loading.value = false
  }
})

const selectedKnowledge = computed(() => knowledgePoints.value.find((item) => item.id === selectedKnowledgeId.value) ?? null)

const renderedContent = computed(() => {
  const md = selectedKnowledge.value?.contentMarkdown ?? ''
  if (!md) return ''
  const html = marked.parse(md)
  return DOMPurify.sanitize(html)
})

const renderedSummary = computed(() => {
  const sm = selectedKnowledge.value?.summary ?? ''
  if (!sm) return ''
  return DOMPurify.sanitize(marked.parse(sm))
})

const contentFallback = '<p class="muted">无内容</p>'
</script>

<template>
  <div class="page-shell">
    <header class="topbar">
      <div>
        <div class="logo">Java Note</div>
        <div class="subtitle">Java 学习 · 示例</div>
      </div>
      <div class="top-actions">
        <span>Java</span>
        <button>管理</button>
      </div>
    </header>

    <main class="layout">
      <aside class="sidebar">
        <div class="section-title">语言</div>
        <ul class="nav-list">
          <li
            v-for="lang in languages"
            :key="lang.id"
            :class="{ active: selectedLanguageId === lang.id }"
            @click="selectedLanguageId = lang.id; loadModules()"
          >
            {{ lang.name }}
          </li>
        </ul>

        <div class="section-title">模块</div>
        <ul class="nav-list">
          <li
            v-for="item in modules"
            :key="item.id"
            :class="{ active: selectedModuleId === item.id }"
            @click="selectedModuleId = item.id; loadKnowledgePoints()"
          >
            {{ item.name }}
          </li>
        </ul>
      </aside>

      <section class="content">
        <div v-if="loading" class="empty">加载中</div>
        <template v-else>
          <div class="knowledge-list">
            <div
              v-for="item in knowledgePoints"
              :key="item.id"
              class="knowledge-item"
              :class="{ selected: selectedKnowledgeId === item.id }"
              @click="selectKnowledge(item.id)"
            >
              <div class="point-title">{{ item.title }}</div>
              <div class="point-summary">{{ item.summary }}</div>
            </div>
          </div>

          <div class="article-panel" v-if="knowledgePoints.length > 0">
            <div class="article-header">
              <h2>{{ knowledgePoints.find((item) => item.id === selectedKnowledgeId)?.title }}</h2>
              <span class="badge">{{ knowledgePoints.find((item) => item.id === selectedKnowledgeId)?.difficulty }}</span>
            </div>
            <div class="article-content">
              <div class="markdown-summary" v-html="renderedSummary"></div>
              <div class="markdown-body" v-html="renderedContent || contentFallback"></div>
            </div>
          </div>

          <div class="editor-panel" v-if="examples.length > 0">
            <div class="section-title">示例</div>
            <div class="example-tabs">
              <button
                v-for="example in examples"
                :key="example.id"
                :class="{ active: activeExample?.id === example.id }"
                @click="activeExample = example; output = ''"
              >
                {{ example.title }}
              </button>
            </div>
            <pre class="code-box">{{ activeExample?.code }}</pre>
            <div class="tool-row">
              <button class="run-btn" @click="runJavaCode">运行代码</button>
            </div>
            <div class="output-box">
              <div class="output-title">结果</div>
              <pre>{{ output || '运行查看' }}</pre>
            </div>
          </div>
        </template>
      </section>
    </main>
  </div>
</template>

<style scoped>
:global(body) {
  margin: 0;
  font-family: 'Segoe UI', sans-serif;
  background: #f3f6fb;
  color: #1f2937;
}
* {
  box-sizing: border-box;
}
button {
  cursor: pointer;
}
.page-shell {
  min-height: 100vh;
  background: linear-gradient(180deg, #eff6ff 0%, #f8fafc 100%);
}
.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 32px;
  background: #0f172a;
  color: white;
}
.logo {
  font-size: 1.8rem;
  font-weight: 700;
}
.subtitle {
  opacity: 0.78;
  font-size: 0.8rem;
}
.top-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}
.top-actions button {
  background: #3b82f6;
  border: none;
  color: white;
  padding: 8px 14px;
  border-radius: 8px;
}
.layout {
  display: grid;
  grid-template-columns: 260px 1fr;
  gap: 24px;
  padding: 24px;
}
.sidebar {
  background: white;
  border-radius: 16px;
  padding: 18px;
  box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05);
}
.section-title {
  font-size: 0.82rem;
  color: #64748b;
  font-weight: 700;
  margin: 12px 0 8px;
  text-transform: uppercase;
}
.nav-list {
  list-style: none;
  margin: 0;
  padding: 0;
}
.nav-list li {
  padding: 10px 12px;
  margin-bottom: 8px;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.2s;
}
.nav-list li:hover,
.nav-list li.active {
  background: #dbeafe;
  color: #1d4ed8;
  font-weight: 600;
}
.content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.knowledge-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 14px;
}
.knowledge-item {
  background: white;
  padding: 18px;
  border-radius: 16px;
  box-shadow: 0 8px 25px rgba(15, 23, 42, 0.04);
  cursor: pointer;
}
.knowledge-item.selected {
  border: 2px solid #60a5fa;
}
.point-title {
  font-weight: 700;
  margin-bottom: 6px;
}
.point-summary {
  color: #475569;
  font-size: 0.9rem;
}
.article-panel,
.editor-panel {
  background: white;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05);
}
.article-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}
.badge {
  background: #dbeafe;
  color: #1d4ed8;
  padding: 6px 12px;
  border-radius: 999px;
  font-size: 0.8rem;
}
.article-content pre,
.code-box,
.output-box pre {
  background: #0f172a;
  color: #e2e8f0;
  padding: 16px;
  border-radius: 12px;
  white-space: pre-wrap;
  overflow: auto;
}
.markdown-summary {
  color: #374151;
  margin-bottom: 12px;
}
.markdown-body {
  background: #ffffff;
  color: #0f172a;
  padding: 18px;
  border-radius: 12px;
}
.markdown-body h1,
.markdown-body h2,
.markdown-body h3 {
  color: #0f172a;
}
.markdown-body pre {
  background: #0f172a;
  color: #e2e8f0;
  padding: 12px;
  border-radius: 8px;
  overflow: auto;
}
.muted { color: #94a3b8 }
.example-tabs {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin: 12px 0;
}
.example-tabs button {
  border: 1px solid #cbd5e1;
  background: #f8fafc;
  padding: 8px 12px;
  border-radius: 8px;
}
.example-tabs button.active {
  background: #1d4ed8;
  border-color: #1d4ed8;
  color: white;
}
.tool-row {
  margin: 12px 0;
}
.run-btn {
  background: #10b981;
  color: white;
  border: none;
  padding: 10px 18px;
  border-radius: 10px;
}
.output-box {
  margin-top: 12px;
}
.output-title {
  font-weight: 700;
  margin-bottom: 8px;
}
.empty {
  padding: 24px;
  text-align: center;
  color: #64748b;
}
</style>
