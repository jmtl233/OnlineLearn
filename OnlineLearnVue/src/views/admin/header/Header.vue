<template>
    <div>
        <el-menu :default-active="1" mode="horizontal" style="line-height: 61px">
            <div class="cn">
                <div class="title">
                    网上学堂在线平台（管理员）
                </div>

            <!-- 用户操作菜单 -->
                <div class="blockl">
                    <el-submenu index="2">
                        <template slot="title">
                                    <i class="iconfont icon-r-user2"
                                        style="color: white;margin-right: 25px;font-size: 32px;"></i>
                        </template>
                        <el-menu-item index="/checkhomework" @click="logout()">退出</el-menu-item>
                        <el-menu-item @click="change()"> 修改密码</el-menu-item>
                    </el-submenu>
                </div>
            </div>
        </el-menu>

<!--        //修改密码对话框-->
        <div>
            <el-dialog title="修改密码" :visible.sync="dialogFormVisible" width="30%" :before-close="handleClose">
                <el-input placeholder="请输入原密码" v-model="changePassword.password" show-password></el-input>
                <el-input placeholder="请输入新密码" v-model="changePassword.newPassword" show-password></el-input>
                <el-input placeholder="请重新输入新密码" v-model="changePassword.conPassword" show-password></el-input>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogFormVisible = false"> 取 消</el-button>
                    <el-button type="primary" @click="submit(changePassword)"> 确 定</el-button>
                </span>
            </el-dialog>


        </div>

    </div>
</template>

<script>
import Cookies from "js-cookie";
import { password } from '../../../api/personal.js'

export default {
    name: "Header.vue",
    data() {
        return {

            changePassword: {     //密码修改数据模型
                password: '',
                conPassword: '',
                newPassword: '',
                id: ''             //从Cookies获取的用户ID
            },
            dialogFormVisible: false,   //对话框显示控制
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
        handleClose(done) {            //显示修改密码对话框
            this.$confirm('确认关闭？')
                .then(() => {
                    done();     //确认关闭
                })
                .catch(() => { });   //取消关闭
        },
        change() {
            this.dialogFormVisible = true   //显示弹窗
        },
       // 表单验证，验证输入两次密码是否一致、为空，在根据password（）api提交修改请求，响应成功or失败
        submit(da) {
            if (this.changePassword.password.trim() == '') {

                this.$message({
                    message: '请输入原密码',
                    type: 'error'
                });
                return;
            }
            if (this.changePassword.newPassword.trim() == '') {

                this.$message({
                    message: '请输入新密码',
                    type: 'error'
                });
                return;
            }
            if (this.changePassword.conPassword != this.changePassword.newPassword) {

                this.$message({
                    message: '两次新密码不一致',
                    type: 'error'
                });
                return;
            }//调用修改密码接口
            password(da).then(resp => {
                if (resp.data.code == 200) {
                    this.$message({
                        message: '密码修改成功 ',
                        type: 'success'
                    });
                    this.dialogFormVisible = false
                    this.studentquery(this.page)
                } else {
                    this.$message.error('原密码错误');
                }
            })
        },
        //清除用户登录信息并跳转到登录页面
        logout() {
            Cookies.remove('userId')
            Cookies.remove('classId')
            Cookies.remove('roleId')
            this.$router.push('/login')  //跳转登录页
            this.$message({
                message: '退出成功',
                type: 'success'
            });
        }
    }
}
</script>

<!--css部分-->
<style scoped>
.block {
    height: 61px;
}

.blockl {
    position: absolute;
    right: 0px;
    line-height: 61px;
    height: 61px;
}
.el-submenu /deep/ .el-submenu__title:hover {
  background-color: #424242 !important;    /* 鼠标悬停时菜单背景色 */
}


.ls {
    height: 100%;
}

.el-menu.el-menu--horizontal {
  border: none !important;
}


.title {
    line-height: 100%;
    padding: 15px 0 0 15px;
    font-weight: bold;
    color: #ffffff;
    position: absolute;
    font-size: 24px;
}
</style>
