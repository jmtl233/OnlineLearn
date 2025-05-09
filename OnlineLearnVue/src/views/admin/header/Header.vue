<template>
    <div>
        <el-menu
            :default-active="1"
            mode="horizontal"
            style="line-height: 61px; background-color: #8cd9f3">
            <div class="cn">
                <div class="title">
                    网上学堂在线平台（管理员）
                </div>

                <!-- 用户操作菜单 -->
                <div class="blockl">
                    <el-submenu index="2">
                        <template slot="title">
                            <i class="iconfont el-icon-user-solid"
                               style="color: #cae7f8; font-size: 32px;"></i>
                        </template>
                        <el-menu-item index="/checkhomework" @click="logout()">退出</el-menu-item>
                        <el-menu-item @click="change()">修改密码</el-menu-item>
                    </el-submenu>
                </div>
            </div>
        </el-menu>

        <!-- 修改密码对话框 -->
        <div>
            <el-dialog title="修改密码" :visible.sync="dialogFormVisible" width="30%" :before-close="handleClose">
                <el-input placeholder="请输入原密码" v-model="changePassword.password" show-password></el-input>
                <el-input placeholder="请输入新密码" v-model="changePassword.newPassword" show-password></el-input>
                <el-input placeholder="请重新输入新密码" v-model="changePassword.conPassword" show-password></el-input>
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
                conPassword: '',
                newPassword: '',
                id: ''
            },
            dialogFormVisible: false,
            info: {
                password: '',
                newPassword: '',
                id: ''
            },
            drawer: false
        }
    },
    created() {
        this.changePassword.id = Cookies.get("userId")
    },
    methods: {
        handleClose(done) {
            this.$confirm('确认关闭？')
                .then(() => { done(); })
                .catch(() => { });
        },
        change() {
            this.dialogFormVisible = true
        },
        submit(da) {
            if (this.changePassword.password.trim() == '') {
                this.$message.error('请输入原密码');
                return;
            }
            if (this.changePassword.newPassword.trim() == '') {
                this.$message.error('请输入新密码');
                return;
            }
            if (this.changePassword.conPassword != this.changePassword.newPassword) {
                this.$message.error('两次新密码不一致');
                return;
            }
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
/* 新增Flex布局容器 */
.cn {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 0 20px;
}

.title {
    color: #2c3e50 !important;
    font-size: 24px;
    font-weight: 600;
    letter-spacing: 1px;
}

/* 调整用户菜单样式 */
.blockl {
    display: flex;
    align-items: center;
}

.el-submenu {
    padding: 0 15px;
}

.el-icon-headset {
    transition: all 0.3s;
}

.el-submenu /deep/ .el-submenu__title {
    padding: 0 10px !important;
    height: 61px !important;
}

.el-submenu /deep/ .el-submenu__title:hover {
    background-color: rgba(255,255,255,0.5) !important;
}

/* 对话框样式调整 */
.el-dialog__header {
    border-bottom: 1px solid #eee;
}

.el-input {
    margin-bottom: 15px;
}
</style>