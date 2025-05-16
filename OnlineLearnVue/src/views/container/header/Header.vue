<template>
    <div>
        <el-menu
            :default-active="'1'"
            mode="horizontal"
            class="custom-menu"
            style="line-height: 60px">
            <div class="cn">
                <div class="title">
                    网上学堂在线平台（教师）
                </div>

                <div class="blockl">
                    <el-submenu index="2">
                        <template slot="title">
                            <!-- 使用Element UI内置图标 -->
                            <i class="el-icon-user" style="font-size: 28px; color: #D84315; margin-right: 15px;"></i>
                        </template>
                        <el-menu-item index="/checkhomework" @click="logout()">退出</el-menu-item>
                        <el-menu-item @click="change()">修改密码</el-menu-item>
                    </el-submenu>
                </div>
            </div>
        </el-menu>

        <div>
            <el-dialog title="修改密码" :visible.sync="dialogFormVisible" width="30%" :before-close="handleClose">
                <el-input placeholder="请输入原密码" v-model="changePassword.password" show-password></el-input>
                <p>
                    <el-input placeholder="请输入新密码" v-model="changePassword.newPassword" show-password></el-input>
                </p>
                <span slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="submit(changePassword)">确 定</el-button>
        </span>
            </el-dialog>
        </div>
    </div>
</template>

<script>
import Cookies from "js-cookie";
import { password } from '../../../api/personal.js'

export default {
    name: "Header",
    data() {
        return {
            changePassword: {
                password: '',
                newPassword: '',
                id: ''
            },
            dialogFormVisible: false,
            info: {
                password: '',
                newPassword: '',
                id: ''
            },
            drawer: false,
        }
    },
    created() {
        this.changePassword.id = Cookies.get("userId")
    },
    methods: {
        handleClose(done) {
            this.$confirm('确认关闭？')
                .then(_ => { done() })
                .catch(_ => {})
        },
        change() {
            this.dialogFormVisible = true
        },
        submit(da) {
            password(da).then(resp => {
                if (resp.data.code == 200) {
                    this.$message.success('密码修改成功')
                    this.dialogFormVisible = false
                    this.studentquery(this.page)
                } else {
                    this.$message.error('原密码错误')
                }
            })
        },
        logout() {
            Cookies.remove('userId')
            Cookies.remove('classId')
            Cookies.remove('roleId')
            this.$router.push('/login')
            this.$message.success('退出成功')
        }
    }
}
</script>

<style scoped>
/* 保持原有字体不变 */
.cn {
    display: flex;
    justify-content: space-between;
}

/* 导航栏背景设置 */
.custom-menu {
    background: linear-gradient(160deg, #FFF3E0 0%, #FFE0B2 100%) !important;
    border-bottom: none !important;
}

.title {
    line-height: 60px;
    padding-left: 20px;
    font-weight: bold;
    color: #EF6C00;
    font-size: 24px;
    float: left;
}

.blockl {
    float: right;
    margin-right: 30px;
}

/* 菜单项样式优化 */
.el-submenu__title {
    height: 60px !important;
    line-height: 60px !important;
}

.el-submenu__title:hover {
    background-color: rgba(255, 255, 255, 0.3) !important;
}

.el-icon-user {
    vertical-align: middle;
    transition: transform 0.2s;
}

.el-icon-user:hover {
    transform: scale(1.1);
}
</style>