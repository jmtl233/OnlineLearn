<!--&lt;!&ndash;左侧导航栏&ndash;&gt;-->
<!--&lt;!&ndash;包含8个核心模块导航&ndash;&gt;-->
<!--&lt;!&ndash;使用iconfont图标库&ndash;&gt;-->
<!--&lt;!&ndash;通过$route.path实现路由高亮&ndash;&gt;-->

<!--<template>-->
<!--    <el-row class="aside">-->
<!--        <el-col :span="24">-->
<!--            <el-menu :default-active="this.$route.path" background-color="#504f4f" text-color="#ffffff" :router="true"-->
<!--                active-text-color="white">-->
<!--                <el-menu-item index="/adminHome">-->
<!--                    <i class="iconfont icon-r-home" style="font-size: 26px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 首页</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/adminstudentmanagement">-->
<!--                    <i class="iconfont icon-r-team" style="font-size: 26px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 学生信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/teachermanagement">-->
<!--                    <i class="iconfont icon-r-user2" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 教师信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/adminhomework">-->
<!--                    <i class="iconfont icon-r-paper" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 作业信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/subject">-->
<!--                    <i class="iconfont icon-r-list" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 科目信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/classmanagementadmin">-->
<!--                    <i class="iconfont icon-r-building" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 班级信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/testmanagement">-->
<!--                    <i class="iconfont icon-r-edit" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 试题信息管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/knowledgepoints">-->
<!--                    <i class="iconfont icon-r-shield" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 知识点管理</span>-->
<!--                </el-menu-item>-->
<!--                <el-menu-item index="/adminpersonalinfo">-->
<!--                    <i class="iconfont icon-r-user3" style="font-size: 24px;color: white;"></i>-->
<!--                    <span slot="title" style="font-size: 20px;"> 个人信息</span>-->
<!--                </el-menu-item>-->
<!--            </el-menu>-->


<!--        </el-col>-->
<!--    </el-row>-->
<!--</template>-->

<!--<script>-->
<!--export default {-->
<!--    name: "Aside"-->
<!--}-->
<!--</script>-->

<!--<style scoped>-->

<!--.el-aside {-->
<!--    /*background-color: #;*/-->
<!--    text-align: left;-->
<!--    background-color: #222;-->

<!--}-->

<!--.aside {-->
<!--    /* margin-top: 10px; */-->
<!--    /*background-color: #6A5ACD;*/-->
<!--    text-align: left;-->
<!--}-->

<!--.el-menu-item {-->
<!--    font-size: 14px;-->
<!--    /* padding: 0 20px; */-->
<!--    cursor: pointer;-->
<!--    /* transition: border-color .3s,background-color .3s,color .3s; */-->
<!--    box-sizing: border-box;-->
<!--}-->

<!--.el-menu-item,-->
<!--.el-submenu__title {-->
<!--    /* height: 90px; */-->
<!--    /* line-height:90px; */-->
<!--    position: relative;-->
<!--    -webkit-box-sizing: border-box;-->
<!--    white-space: nowrap;-->
<!--    list-style: none;-->
<!--}-->
<!--</style>-->
<template>
    <el-row class="aside-container">
        <el-col :span="24">
            <el-menu
                :default-active="$route.path"
                :router="true"
                class="side-menu"
                background-color="#b1e8fd"
                text-color="#2c3e50"
                active-text-color="#2980b9">
                <el-menu-item
                    v-for="item in menuItems"
                    :key="item.index"
                    :index="item.index"
                    class="menu-item">
                    <i :class="item.icon" class="menu-icon"></i>
                    <span class="menu-text">{{ item.title }}</span>
                </el-menu-item>
            </el-menu>
        </el-col>
    </el-row>
</template>

<script>
export default {
    name: "Aside",
    data() {
        return {
            menuItems: [
                { index: '/adminHome', icon: 'iconfont el-icon-monitor', title: '首页' },
                { index: '/adminstudentmanagement', icon: 'iconfont el-icon-data-analysis', title: '学生信息管理' },
                { index: '/teachermanagement', icon: 'iconfont el-icon-receiving', title: '教师信息管理' },
                { index: '/adminhomework', icon: 'iconfont el-icon-notebook-2', title: '作业信息管理' },
                { index: '/subject', icon: 'iconfont el-icon-menu', title: '科目信息管理' },
                { index: '/classmanagementadmin', icon: 'iconfont el-icon-school', title: '班级信息管理' },
                { index: '/testmanagement', icon: 'iconfont el-icon-document', title: '试题信息管理' },
                { index: '/knowledgepoints', icon: 'iconfont el-icon-edit', title: '知识点管理' },
                { index: '/adminpersonalinfo', icon: 'iconfont el-icon-user-solid', title: '个人信息' }
            ]
        }
    }
}
</script>

<style scoped>
.aside-container {
    height: 100vh;
    background: #ffffff;
}

.side-menu {
    border-right: none;
    background: #ffffff !important;
}

.menu-item {
    height: 56px;
    margin: 8px 10px;
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    padding-left: 20px !important;
    display: flex;
    align-items: center;
}

.menu-item:hover {
    background: white !important;
    color: #2980b9 !important;
    box-shadow: 0 0 8px rgba(41, 128, 185, 0.3);
    transform: translateX(5px);
}

.menu-item.is-active {
    background: rgba(255, 255, 255, 0.9) !important;
    position: relative;
    color: #ffffff !important;
}

.menu-item.is-active::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    height: 70%;
    width: 3px;
    background: #2980b9;
    border-radius: 3px;
}

.menu-icon {
    font-size: 22px;
    color: #ffffff;
    margin-right: 15px;
    min-width: 30px;
    text-align: left;
}

.menu-text {
    font-size: 15px;
    font-weight: 500;
    letter-spacing: 0.3px;
    flex-grow: 1;
    text-align: left;
}

/* 激活状态样式 */
.menu-item.is-active .menu-icon {
    color: #2980b9;
}

.menu-item.is-active .menu-text {
    color: #2980b9;
    font-weight: 600;
}

/* 悬停时文字和图标颜色 */
.menu-item:hover .menu-icon,
.menu-item:hover .menu-text {
    color: #2980b9 !important;
}

/* 强制左侧对齐 */
.el-menu-item {
    justify-content: flex-start !important;
    padding-left: 20px !important;
}
</style>