<template>
    <div>
        <div class="nav-container">
            <el-menu
                class="custom-menu"
                background-color="#fff"
                text-color="#409EFF"
                active-text-color="#fff"
                :default-active="activeParentIndex"
                :router="true"
                mode="horizontal"
                @select="handleSelect">

                <!-- 左侧Logo -->
                <div class="logo-container">
                    <i class="el-icon-s-platform logo-icon"></i>
                    <span class="platform-name">网上学堂在线平台</span>
                </div>

                <!-- 导航菜单 -->
                <div class="nav-items">
                    <el-menu-item index="/home">首页</el-menu-item>
                    <el-submenu
                        index="1"
                        popper-class="nav-submenu"
                        class="no-arrow-submenu homework-submenu"
                        @mouseenter.native="showSubmenu(1)"
                        @mouseleave.native="closeSubmenu(1)">
                        <template slot="title" class="sub-title">作业管理</template>
                        <el-submenu index="1-1" class="centered-submenu">
                            <template slot="title">查看作业</template>
                            <el-menu-item index="/checkhomework">已完成</el-menu-item>
                            <el-menu-item index="/nohomework">未完成</el-menu-item>
                        </el-submenu>
                        <el-menu-item index="/askandanswer">问答</el-menu-item>
                        <el-menu-item index="/studentpractice">试题</el-menu-item>
                    </el-submenu>
                    <el-menu-item index="/onlinelearn">在线学习</el-menu-item>
                    <el-menu-item index="/studentmanagement">班级列表</el-menu-item>
                    <el-menu-item index="/practicedetail">习题记录</el-menu-item>
                    <el-menu-item index="/essentiainfo">基本信息</el-menu-item>
                </div>

                <!-- 右侧用户菜单 -->
                <div class="user-menu-wrapper">
                    <el-submenu
                        index="2"
                        popper-class="user-menu"
                        class="no-arrow-submenu"
                        @mouseenter.native="showSubmenu(2)"
                        @mouseleave.native="closeSubmenu(2)">
                        <template slot="title">
                            <div class="demo-type">
                                <div>
                                    <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
                                </div>
                            </div>
                        </template>
                        <el-menu-item
                            index="/checkhomework"
                            @click="logout()"
                            class="full-text-menu-item">退出登录</el-menu-item>
                        <el-menu-item
                            @click="change()"
                            class="full-text-menu-item">修改密码</el-menu-item>
                    </el-submenu>
                </div>
            </el-menu>
        </div>

        <!-- 修改密码对话框 -->
        <el-dialog title="修改密码" :visible.sync="dialogFormVisible" width="30%">
            <el-input placeholder="请输入原密码" v-model="changePassword.password" show-password></el-input>
            <p>
                <el-input placeholder="请输入新密码" v-model="changePassword.newPassword" show-password></el-input>
            </p>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取消</el-button>
                <el-button type="primary" @click="submit(changePassword)">确定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Cookies from "js-cookie";
import { password } from '../../../../api/personal.js'

export default {
    name: "Header",
    data() {
        return {
            activeParentIndex: '/home',
            changePassword: {
                password: '',
                newPassword: '',
                id: ''
            },
            dialogFormVisible: false,
            submenuPaths: [
                '/checkhomework',
                '/nohomework',
                '/askandanswer',
                '/studentpractice'
            ]
        }
    },
    created() {
        this.changePassword.id = Cookies.get("userId")
        this.setActiveParentIndex()
    },
    watch: {
        $route() {
            this.setActiveParentIndex()
        }
    },
    methods: {
        setActiveParentIndex() {
            const path = this.$route.path
            if(this.submenuPaths.includes(path)) {
                this.activeParentIndex = '1'
            } else {
                this.activeParentIndex = path
            }
        },
        handleSelect(index) {
            this.activeParentIndex = index
        },
        showSubmenu(index) {
            document.querySelector(`.el-submenu[index="${index}"]`).click()
        },
        closeSubmenu(index) {
            setTimeout(() => {
                const submenu = document.querySelector(`.el-submenu[index="${index}"]`)
                if (!submenu.contains(document.activeElement)) {
                    submenu.querySelector('.el-submenu__title').click()
                }
            }, 100)
        },
        change() {
            this.dialogFormVisible = true
        },
        submit(da) {
            password(da).then(resp => {
                if (resp.data.code == 200) {
                    this.$message.success('密码修改成功');
                    this.dialogFormVisible = false
                } else {
                    this.$message.error('原密码错误');
                }
            })
        },
        logout() {
            Cookies.remove('userId')
            Cookies.remove('classId')
            Cookies.remove('roleId')
            this.$router.push('/login')
            this.$message.success('退出成功');
        }
    }
}
</script>

<style scoped>
.nav-container {
    width: 100vw;
    position: relative;
    left: 50%;
    right: 50%;
    margin-left: -50vw;
    margin-right: -50vw;
}

.custom-menu {
    display: flex;
    justify-content: space-between;
    padding: 0 60px;
}

.logo-container {
    display: flex;
    align-items: center;
    margin-right: 60px;
}
.logo-icon {
    font-size: 32px;
    color: #409EFF;
    margin-right: 12px;
}
.platform-name {
    font-size: 26px;
    font-weight: 700;
    color: #409EFF;
}

.nav-items {
    flex: 1;
    display: flex;
    margin-left: 40px;
}
.el-menu-item {
    font-size: 18px !important;
    font-weight: 600 !important;
    letter-spacing: 1px;
    position: relative;
}
.el-menu-item.is-active {
    background: #409EFF !important;
    color: #fff !important;
    border-radius: 4px;
}

.user-menu-wrapper {
    margin-right: 40px;
}

.no-arrow-submenu ::v-deep .el-submenu__icon-arrow {
    display: none !important;
}

.homework-submenu ::v-deep .el-submenu__title {
    font-size: 20px !important;
    font-weight: 700 !important;  /* 确保父级菜单加粗 */
    letter-spacing: 1px;
    height: 60px;
    line-height: 60px;
}

.homework-submenu .centered-submenu.el-submenu ::v-deep .el-submenu__title {
    font-size: 18px !important;
    font-weight: 700 !important;  /* 统一加粗程度 */
    letter-spacing: 1px !important;
    height: 40px !important;
    line-height: 40px !important;
    color: #409EFF !important;
    padding: 0 20px !important;
    font-family: inherit !important;  /* 新增字体继承 */
}
</style>

<style>
.el-menu--horizontal.el-menu {
    border-bottom: none !important;
}

.el-menu--horizontal > .el-submenu .el-submenu__title {
    height: 60px !important;
    line-height: 60px !important;
    padding: 0 20px !important;
}

.nav-submenu {
    margin-top: -5px !important;
}

.nav-submenu .el-menu {
    padding: 0 !important;
}

.nav-submenu .el-menu-item {
    height: 40px !important;
    line-height: 40px !important;
    text-align: center !important;
    min-width: 120px !important;
    padding: 0 20px !important;
}

.centered-submenu .el-menu {
    padding: 0 !important;
}

.homework-submenu .centered-submenu.el-submenu ::v-deep .el-submenu__title {
    font-size: 18px !important;
    font-weight: 600 !important;
    letter-spacing: 1px !important;
    height: 40px !important;
    line-height: 40px !important;
    color: #409EFF !important;
    padding: 0 20px !important;
}

.el-menu--popup {
    min-width: 120px !important;
}

.el-menu--horizontal > .el-submenu.is-active .el-submenu__title {
    background: #409EFF !important;
    color: #fff !important;
    border-radius: 4px;
}

.user-menu .el-menu-item {
    min-width: 120px !important;
    padding: 0 20px !important;
}
</style>