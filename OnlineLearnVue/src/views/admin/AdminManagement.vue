<template>
    <div>
        <el-container>
            <el-header>
                <Header></Header>
            </el-header>
            <el-container>
                <el-aside width="200px">
                    <Aside></Aside>
                </el-aside>
                <el-main>
                    <router-view></router-view>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script>
import Header from "./header/Header.vue"
import Aside from "./aside/Aside";
import Cookies from 'js-cookie'
export default {
    name: "AdminManagement",
    components: { Aside, Header },
    updated() {
        var roleId = Cookies.get("roleId")
        if(roleId != 1) {
            this.$router.push("/login")
        }
    }
}
</script>

<style scoped>
.el-container.is-vertical {
    flex-direction: column;
    height: 100%;
}

.el-header[data-v-9aae6930],
.el-footer[data-v-9aae6930] {
    margin-left: -20px;
    margin-right: -20px;
    background-color: #504f4f;
    color: #333;
    text-align: center;
    line-height: 60px;

    border-bottom: 1px solid #504f4f;
}

.el-aside {
    background-color: #504f4f;
    color: #333;
    text-align: center;
    line-height: 200px;
}

.aside[data-v-2c9fb0d2] {
    margin-top: 10px;
    background-color: #504f4f;
}

.el-main {
    background-color: rgba(233, 238, 243, 0.1);
    color: #333;
    overflow-y: auto;
    height: 90vh;
}

body>.el-container {
    margin-bottom: 40px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
    line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
    line-height: 320px;
}</style>
