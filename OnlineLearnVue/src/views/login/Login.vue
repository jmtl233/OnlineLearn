<template xmlns:el-form-item="">
    <div class="container">
        <!-- 修改为左右布局 -->
        <div class="layout-container">
            <!-- 左侧背景 -->
            <div class="left-bg"></div>

            <!-- 右侧表单 -->
            <div class="right-form">
                <div class="form-container">
                    <div class="title">网上学堂在线平台</div>
                    <!-- 登录表单区域 -->
                    <el-form :model="tabUser"
                             style="margin: 30px;">
                        <el-form-item>
                            <el-input style="margin-bottom: 20px;" placeholder="账号" prefix-icon="el-icon-user-solid"
                                      v-model="tabUser.account" clearable></el-input>
                        </el-form-item>
                        <!-- 密码 -->
                        <el-form-item>
                            <el-input placeholder="密码" clearable show-password prefix-icon="el-icon-lock"
                                      v-model="tabUser.password"></el-input>
                        </el-form-item>
                        <br>

                        <el-form-item:last-child>
                            <el-button size="mini" type="primary" @click="login(tabUser)"
                                       :loading="loading">登录
                            </el-button>
                            <el-button size="mini" type="info" @click="dialog = true"
                                       :loading="loading">注册
                            </el-button>
                        </el-form-item:last-child>


                    </el-form>
                </div>
            </div>
        </div>
        <el-drawer
                title="注册账号"
                :visible.sync="dialog"
                ref="drawer"
                size="480px"
                class="simple-register">
            <div class="register-container">
                <div class="register-header">
                    <i class="el-icon-edit-outline"></i>
                    <span>用户注册</span>
                </div>
                <el-form
                        :model="form"
                        :rules="rules"
                        class="symmetrical-form">
                    <div class="form-group">
                        <el-form-item label="姓名" prop="userName">
                            <el-input
                                    v-model="form.userName"
                                    prefix-icon="el-icon-user"
                                    placeholder="请输入姓名"
                                    clearable>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="账号" prop="account">
                            <el-input
                                    v-model="form.account"
                                    prefix-icon="el-icon-mobile-phone"
                                    placeholder="6-12位字母数字"
                                    clearable>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="手机号" prop="phone">
                            <el-input
                                    v-model="form.phone"
                                    prefix-icon="el-icon-phone"
                                    placeholder="11位手机号码"
                                    clearable>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="密码" prop="password">
                            <el-input
                                    v-model="form.password"
                                    type="password"
                                    prefix-icon="el-icon-lock"
                                    placeholder="8-16位含字母数字"
                                    show-password>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="确认密码" prop="confirmPassword">
                            <el-input
                                    v-model="form.confirmPassword"
                                    type="password"
                                    prefix-icon="el-icon-key"
                                    placeholder="再次输入密码"
                                    show-password>
                            </el-input>
                        </el-form-item>

                        <el-form-item label="性别" prop="sex" class="gender-form-item">
                            <el-select
                                    v-model="form.sex"
                                    placeholder="请选择性别"
                                    class="symmetrical-select">
                                <el-option
                                        label="男"
                                        value="0"
                                        class="gender-option">
                                    <i class="el-icon-male"></i> 男
                                </el-option>
                                <el-option
                                        label="女"
                                        value="1"
                                        class="gender-option">
                                    <i class="el-icon-female"></i> 女
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </div>

                    <el-button
                            type="primary"
                            class="register-btn"
                            @click="confirm(form)">
                        立即注册
                    </el-button>
                </el-form>
            </div>
        </el-drawer>
    </div>
</template>
<script>

import { loginRequest, register } from "../../api/login";
import Cookies from 'js-cookie'
export default {
    name: "Login",
    data() {
        var validatePass2 = (rule, value, callback) => {
            if (value === '') {
                callback(new Error('请再次输入密码'))
            } else if (value !== this.form.password) {
                callback(new Error('两次输入密码不一致!'))
            } else {
                callback()
            }
        }
        return {
            tabUser: {
                account: '',
                password: '',

            },
            form: {
                userName: '',
                account: '',
                sex: '',
                phone: '',
                password: '',
                confirmPassword: [],
                desc: ''
            },
            formLabelWidth: '80px',
            timer: null,
            dialog: false,
            loading: false,



            rules: {
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                ],
                confirmPassword: [
                    { required: true, validator: validatePass2, trigger: 'blur' }
                ]
            }
        }

    },
    created() {

    },
    methods: {

        confirm(form) {

            if (this.form.userName.trim() == '') {
                this.$message({
                    message: '姓名不能为空',
                    type: 'error'
                });
                return
            }
            if (this.form.account.trim() == '') {
                this.$message({
                    message: '账号不能为空',
                    type: 'error'
                });
                return
            }
            if (this.form.sex.trim() == '') {
                this.$message({
                    message: '请选择性别',
                    type: 'error'
                });
                return
            }
            if (this.form.phone.trim() == '') {
                this.$message({
                    message: '电话不能为空',
                    type: 'error'
                });
                return
            }
            if (this.form.password.trim() == '') {
                this.$message({
                    message: '密码不能为空',
                    type: 'error'
                });
                return
            }
            if (this.form.password !== this.form.confirmPassword) {
                this.$message({
                    message: '两次输入密码不一致',
                    type: 'error'
                });
                return
            }
            register(form).then(resp => {
                if (resp.data.code == 200) {
                    this.dialog = false;
                    this.$message({
                        message: '注册成功',
                        type: 'success'
                    });
                } else {
                    this.$message.error('注册失败，账号已存在');
                }
            })
        },
        cancelForm() {
            this.loading = false;
            this.dialog = false;
            clearTimeout(this.timer);
        },


        sendCode() {

        },
        login(tabUser) {
            loginRequest(tabUser).then(resp => {
                Cookies.set('roleId', resp.data.resultData.roleId)
                Cookies.set('userId', resp.data.resultData.userId)
                Cookies.set('classId', resp.data.resultData.classId)

                if (resp.data.code == 200) {
                    if (resp.data.resultData.roleId == 1) {
                        this.$router.push("/adminHome")
                    }
                    if (resp.data.resultData.roleId == 2) {
                        this.$router.push("/teacherHome")
                    }
                    if (resp.data.resultData.roleId == 3) {
                        this.$router.push("/studentweb")
                    }
                    this.$message({
                        message: '登录成功',
                        type: 'success'
                    });
                } else {
                    this.$message.error('账号或者密码错误');
                }
            }).catch((e) => {
                console.log(e);
                if (
                    e.response == undefined ||
                    e.response.data == undefined
                ) {
                    this.$message({
                        showClose: true,
                        message: e,
                        type: "error",
                        duration: 20000,
                    });
                } else {
                    this.$message({
                        showClose: true,
                        message: e.response.data,
                        type: "error",
                        duration: 20000,
                    });
                }
            })

        },

    }
}
</script>
<style scoped>
.container {
    height: 100vh;
    display: flex;
    background: #f0f2f5;
}

.layout-container {
    display: flex;
    width: 100%;
    height: 100%;
}

.left-bg {
    flex: 1;
    background: url("../../assets/login-bg.jpg") center/cover;
    position: relative;
}

.right-form {
    width: 480px;
    background: rgba(255, 255, 255, 0.96);
    backdrop-filter: blur(10px);
    display: flex;
    align-items: center;
    padding: 40px;
    box-shadow: -8px 0 32px rgba(0, 0, 0, 0.05);
}

.form-container {
    width: 100%;
    animation: slideIn 0.6s ease;
}

.title {
    font-size: 28px;
    color: #1a3353;
    text-align: center;
    margin-bottom: 40px;
    font-weight: 600;
    letter-spacing: 1px;
}

.el-form-item:last-child {
    display: flex;
    gap: 20px;
    margin-top: 30px;
    justify-content: center;
}

.el-button {
    width: 200px;
    height: 40px;
    border-radius: 6px;
    transition: all 0.3s;
}

.el-button[type="primary"] {
    background: linear-gradient(45deg,rgb(98, 182, 241), #38b6ff);
}

.el-button[type="info"] {
    background: #f0f2f5;
    color: #606266;
    border: 1px solid #dcdfe6;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* 新增注册表单样式 */
.enhanced-register {
    --primary-color: #38b6ff;
    --success-color: #67c23a;
}

.register-container {
    padding: 30px 40px;
}

.register-title {
    text-align: center;
    color: #1a3353;
    font-size: 24px;
    margin-bottom: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.form-columns {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
}

.form-col {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.el-form-item {
    margin-bottom: 0;
}

.el-form-item__label {
    font-weight: 500;
    color: #606266;
    padding-bottom: 8px !important;
}

.el-input__inner {
    height: 40px;
    border-radius: 8px;
    transition: all 0.3s;
}

.el-input__inner:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 8px rgba(56, 182, 255, 0.2);
}

.gender-select {
    width: 100%;
}

.gender-select .el-input__inner {
    background: rgba(56, 182, 255, 0.1);
    border-color: rgba(56, 182, 255, 0.3);
}

.register-btn {
    width: 100%;
    height: 45px;
    margin-top: 30px;
    font-size: 16px;
    letter-spacing: 2px;
    background: linear-gradient(45deg, var(--primary-color),rgb(129, 200, 251));
    border: none;
    border-radius: 8px;
    transition: all 0.3s;
}

.register-btn:hover {
    opacity: 0.9;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(157, 232, 255, 0.93);
}

/* 下拉框样式优化 */
:deep(.gender-popper) {
    border-radius: 8px !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
}

:deep(.gender-option) {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 20px !important;
    transition: all 0.2s;
}

:deep(.gender-option:hover) {
    background-color: #f5f7fa;
}

:deep(.gender-option i) {
    color: #38b6ff;  /* 修改图标颜色 */
}

/* 简化版注册表单样式 */
.simple-register {
    --primary-color: #38b6ff;
}

.register-container {
    padding: 30px 40px;
}

.register-header {
    text-align: center;
    margin-bottom: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    font-size: 20px;
    color: #1a3353;
}

.symmetrical-form {
    max-width: 400px;
    margin: 0 auto;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 18px;
}

.el-form-item {
    margin-bottom: 0;
}

.el-form-item__label {
    display: block;
    text-align: left;
    padding-left: 8px;
    margin-bottom: 6px;
    color: #606266;
    font-weight: 500;
}

.el-input__inner,
.symmetrical-select .el-input__inner {
    width: 100%;
    height: 40px;
    border-radius: 8px;
    transition: all 0.2s;
}

.el-input__inner:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 6px rgba(56, 182, 255, 0.2);
}

.register-btn {
    width: 100%;
    height: 42px;
    margin-top: 30px;
    font-size: 16px;
    letter-spacing: 2px;
    background: linear-gradient(45deg, var(--primary-color), #99caf8);
    border: none;
    border-radius: 8px;
    transition: all 0.2s;
}

.register-btn:hover {
    opacity: 0.9;
    transform: translateY(-1px);
}

/* 统一选择器样式 */
.symmetrical-select {
    width: 100%;
}

/* 调整抽屉标题 */
:deep(.el-drawer__header) {
    margin-bottom: 20px;
    padding: 20px;
    border-bottom: 1px solid #eee;
}

:deep(.el-drawer__title) {
    font-size: 18px;
    color:rgb(70, 184, 233);
}

/* 新增性别选择器左对齐样式 */
.gender-form-item .el-form-item__label {
    text-align: left !important;
    padding-left: 0 !important;
    width: 100% !important;
}

.gender-form-item .el-select {
    width: 100%;
    text-align: left;
}

.gender-form-item .el-input__inner {
    text-align: left !important;
    padding-left: 15px !important;
}

/* 确保与确认密码输入框对齐 */
.el-form-item__content {
    display: block !important;
}
</style>
