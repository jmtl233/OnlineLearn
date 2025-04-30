<template>
    <div>
        <el-container>
            <el-header>
                <Header style="height: 80px"></Header>
            </el-header>
            <el-main class="main-container">
                <div class="greeting-card">
                    <div class="greeting-text">
                        你好，{{ Info.userName }} 同学！
                    </div>
                    <div class="time-info">
                        <div class="date-section">
                            <span class="icon">📅</span>
                            <span class="date-text">今天是{{ dateString }}</span>
                        </div>
                        <div class="time-section">
                            <span class="icon">⏰</span>
                            <span class="time-text">{{ timeString }}</span>
                        </div>
                    </div>
                </div>
                <router-view></router-view>
            </el-main>
        </el-container>
    </div>
</template>

<script>
import Header from "../../studentweb/contain/header/Header";
import { personal } from '../../../api/personal.js'
import Cookies from 'js-cookie'

export default {
    name: "StudentContainWeb",
    data() {
        return {
            Info: {},
            dateString: "",
            timeString: "",
            timer: null
        }
    },
    components: { Header },
    mounted() {
        personal({ 'id': Cookies.get("userId") }).then(resp => {
            this.Info = resp.data.resultData
        })

        this.updateDateTime()
        this.timer = setInterval(this.updateDateTime, 1000)
    },
    beforeDestroy() {
        if (this.timer) {
            clearInterval(this.timer)
        }
    },
    methods: {
        updateDateTime() {
            const now = new Date()
            const year = now.getFullYear()
            const month = (now.getMonth() + 1).toString().padStart(2, '0')
            const day = now.getDate().toString().padStart(2, '0')
            const week = ['日', '一', '二', '三', '四', '五', '六'][now.getDay()]
            const hours = now.getHours().toString().padStart(2, '0')
            const minutes = now.getMinutes().toString().padStart(2, '0')
            const seconds = now.getSeconds().toString().padStart(2, '0')

            this.dateString = `${year}年${month}月${day}日，星期${week}！`
            this.timeString = `${hours}时${minutes}分${seconds}秒`
        }
    },
    updated() {
        const roleId = Cookies.get("roleId")
        if (roleId != 3) {
            this.$router.push("/login")
        }
    }
}
</script>

<style scoped>
.main-container {
    height: 90vh !important;
    overflow-y: auto !important;
    padding: 0 50px 120px 50px;
    background: #f8fafc;
}

.greeting-card {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 16px;
    padding: 32px 40px;
    margin: 20px 0 35px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(241, 245, 249, 0.5);
    backdrop-filter: blur(8px);
    transition: all 0.3s ease;
}

.greeting-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.08);
}

.greeting-text {
    font-size: 28px;
    color: #1e293b;
    font-weight: 600;
    margin-bottom: 24px;
    letter-spacing: 0.5px;
}

.time-info {
    display: flex;
    gap: 32px;
    align-items: center;
}

.date-section, .time-section {
    display: flex;
    align-items: center;
    font-size: 20px;
    padding: 12px 24px;
    background: rgba(248, 250, 252, 0.8);
    border-radius: 8px;
    transition: all 0.2s ease;
}

.date-section:hover, .time-section:hover {
    transform: translateY(-2px);
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.icon {
    margin-right: 12px;
    font-size: 24px;
}

/* 统一字体样式 */
.date-text, .time-text {
    color: #475569;
    font-weight: 500;
    font-family: inherit;
}

.el-header {
    background-color: #ffffff;
    height: 80px !important;
    z-index: 99 !important;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

/* 保留原有其他样式 */
.el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 400px;
    margin: 0;
}

.el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
}

.el-submenu__title {
    font-size: 20px;
}
</style>