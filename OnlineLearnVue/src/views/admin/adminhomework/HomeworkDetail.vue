<!--//用户通过作业列表跳转到此页面，在通过路由传递参数到Markdown中-->
<!--//页面只显示了简单的返回按钮和禁用状态的markdown编辑器，且只读模式-->

<template>
    <div>
     <!-- 导航返回按钮，链接直接跳转到/adminhomework -->
        <router-link to="/adminhomework">
            <el-button type="success"> 返回</el-button>
        </router-link>

         <!-- Markdown内容展示区 -->
<!--        // 禁用编辑器(只读模式)-->
<!--        // 关闭双栏模式，仅单栏预览试图-->
<!--        // 禁止自动聚焦，避免光标闪烁影响阅读-->
<!--        // 绑定路由参数数据-->
<!--        // 编辑器引用，获得渲染-->
<!--        // 宽度设置-->
        <div>
            <mavon-editor
                    disabled="true"
                    :subfield="false"
                    :autofocus="false"
                    v-model=this.$route.params.data1
                    ref="md"
                    style="width: 99%;"
            >
            </mavon-editor>
        </div>
    </div>
</template>

<script>
    export default {
        name: "HomeworkDetail"    //组件注册名称
    }
</script>

<style scoped>
/*局部样式（当前为空）*/

</style>