<template>
  <!-- 原有模板代码... -->
</template>

<script>
import { saveExam } from '@/api/teacher/test' // 确保导入API方法

export default {
  // ...其他选项
  methods: {
    async saveExam() {
      try {
        // 获取表单数据
        const formData = {
          // 试题相关字段
          title: this.title,
          content: this.content,
          answer: this.answer,
          classId: this.selectedClass,
          // 其他必要字段...
        }
        
        // 调用API保存试题
        const res = await saveExam(formData)
        
        if (res.code === 200) {
          this.$message.success('试题保存成功')
          // 重置表单或跳转等操作
        } else {
          this.$message.error(res.msg || '保存失败')
        }
      } catch (error) {
        console.error('保存试题出错:', error)
        this.$message.error('保存试题失败')
      }
    },
    // ...其他方法
  }
}
</script>