<template>
    <el-row class="aside">
        <el-col :span="24">
            <el-menu
                :default-active="$route.path"
                class="custom-menu"
                :router="true"
                background-color="#fff3e0"
                text-color="#333"
                active-text-color="#333">
                <el-menu-item index="/teacherHome">
                    <i class="iconfont el-icon-s-cooperation"></i>
                    <span slot="title" class="menu-text">首页</span>
                </el-menu-item>
                <el-menu-item index="/studentinfo">
                    <i class="iconfont el-icon-s-unfold"></i>
                    <span slot="title" class="menu-text">班级信息管理</span>
                </el-menu-item>
                <el-menu-item index="/teacherapplicant">
                    <i class="iconfont el-icon-guide"></i>
                    <span slot="title" class="menu-text">加入班级审核</span>
                </el-menu-item>
                <el-menu-item index="/scoremanagment">
                    <i class="iconfont el-icon-collection"></i>
                    <span slot="title" class="menu-text">试题管理</span>
                </el-menu-item>
                <el-menu-item index="/classmanagement">
                    <i class="iconfont el-icon-message"></i>
                    <span slot="title" class="menu-text">作业管理</span>
                </el-menu-item>
                <el-menu-item index="/coursemanagement">
                    <i class="iconfont el-icon-chat-dot-square"></i>
                    <span slot="title" class="menu-text">问答社区</span>
                </el-menu-item>
                <el-menu-item index="/personalinfo">
                    <i class="iconfont el-icon-message-solid"></i>
                    <span slot="title" class="menu-text">知识点补充</span>
                </el-menu-item>
                <el-menu-item index="/video">
                    <i class="iconfont el-icon-video-camera"></i>
                    <span slot="title" class="menu-text">视频管理</span>
                </el-menu-item>
                <el-menu-item index="/teacherpersonalinfo">
                    <i class="iconfont el-icon-user"></i>
                    <span slot="title" class="menu-text">个人信息</span>
                </el-menu-item>
            </el-menu>
        </el-col>
    </el-row>
</template>

<script>
export default {
    name: "Aside"
}
</script>

<style scoped>
.aside {
    background-color: #fff3e0;
    height: 100vh;
}

.custom-menu {
    border-right: none !important;
}

/* 菜单项样式调整 */
.el-menu-item {
    margin: 8px;
    border-radius: 4px;
    transition: all 0.3s ease;
    display: flex !important;
    align-items: center;
    padding-left: 20px !important;
}

/* 图标和文字左对齐 */
.el-menu-item > * {
    flex: 0 0 auto !important;
}

/* 图标样式调整 */
.el-menu-item .iconfont {
    font-size: 20px;
    color: #666;
    margin-right: 12px;
    transition: color 0.3s ease;
}

/* 文字样式调整 */
.menu-text {
    font-size: 15px;
    font-weight: 500;
    flex-grow: 0;
}

/* 悬停效果 */
.el-menu-item:hover {
    background-color: white !important;
}

.el-menu-item:hover .iconfont {
    color: #333 !important;
}

/* 激活状态 */
.el-menu-item.is-active {
    background-color: rgba(255, 255, 255, 0.8) !important;
}

.el-menu-item.is-active .iconfont {
    color: #333 !important;
}
</style>