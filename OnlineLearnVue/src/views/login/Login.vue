<template>
  <div class="container">
    <div style="display: flex; width: 400px; height: 350px; margin: auto;
                position: absolute;
	              top: 0;
	              left: 0;
	              right: 0;
	              bottom: 0;">
      <div style="flex: 1; background-color: rgba(250,250,250,0.9);">
        <div style="text-align: center; font-size: 25px; font-weight: 600; margin: 20px; color: #070707">在线教育学习系统</div>
                    <!-- 登录表单区域 -->
                    <el-form :model="tabUser"
                        style="margin: 30px;">
                        <el-form-item>
                            <el-input style="margin-bottom: 20px;" placeholder="账号" prefix-icon="iconfont icon-r-user2"
                                v-model="tabUser.account" clearable></el-input>
                        </el-form-item>
                        <!-- 密码 -->
                        <el-form-item>
                            <el-input placeholder="密码" clearable show-password prefix-icon="iconfont icon-r-lock"
                                v-model="tabUser.password"></el-input>
                        </el-form-item>
                        <br>

                      <el-form-item>
                        <el-button size="mini" type="primary" @click="login(tabUser)"
                                   :loading="loading">登录
                        </el-button>
                        <el-button size="mini" type="info" @click="dialog = true"
                                   :loading="loading">注册
                        </el-button>
                      </el-form-item>


                    </el-form>
        </div>
        <el-drawer title="注册账号" :visible.sync="dialog" ref="drawer">
            <el-form :model="form" :rules="rules" style="padding: 0 20px 0 20px;">
                <el-form-item label="姓名" :label-width="formLabelWidth">
                    <el-input v-model="form.userName" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="账号" :label-width="formLabelWidth">
                    <el-input v-model="form.account" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="电话" :label-width="formLabelWidth">
                    <el-input v-model="form.phone" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item :show-password="true" label="密码" :label-width="formLabelWidth" prop="password">
                    <el-input :placeholder="form.password" v-model="form.password" type="password"></el-input>
                </el-form-item>
                <el-form-item :show-password="true" label="确认密码" :label-width="formLabelWidth" prop="confirmPassword">
                    <el-input :placeholder="form.confirmPassword" type="password"
                        v-model="form.confirmPassword"></el-input>
                </el-form-item>
                <el-form-item label="性别" :label-width="formLabelWidth">
                    <el-select v-model="form.sex" placeholder="请选择性别">
                        <el-option label="男" value="0"></el-option>
                        <el-option label="女" value="1"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div style="width: 100%; text-align: center">
                <el-button type="success" @click="confirm(form)"> 注册新账号</el-button>
            </div>
        </el-drawer>
    </div>
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
                // VerificationCode: '',
                // checkbox: false,
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
  overflow: hidden;
  /*background-color: #64A7C1;*/
  background-image: url("../../assets/学习1.jpg");
  background-size: 100%;
  color: #666;
}
.onfont[data-v-2529d779] {
    /* display: flex; */
    /* justify-content: center; */
    position: absolute;
    left: 50%;
    top: 120px;
}

.lr {
    width: 100%;
    display: flex;
    justify-content: space-between;
}

.login_container {
    top: 0;
    left: 0;
    width: 100%;
    overflow-y: auto;
    height: 100%;
    background: url("../../assets/login-bg.png") center top / cover no-repeat;
    z-index: 100;

}


.login_box {
    text-align: center;
    padding-top: 70px;


}

.lf {
    padding: 20px;
    position: absolute;
    bottom: 0;
    width: 100%;
    box-sizing: border-box;
}

.el-button {
    width: 100%;
  margin-left: 0 !important;
  border-radius: 20px;
}

.code {
    width: 45%;
}

.code1 {
    /* style="width: 100px; height: 30px; margin-left:5px;vertical-align: middle;" */
    display: line-inline;
    width: 45%;
    height: 28px;
    margin-left: 10px;
    vertical-align: middle;
    border-radius: 3px;
}

.rememberMe {
    color: #fff;
}
</style>
