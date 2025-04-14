<template>
    <div>
        <el-container>
            <el-header>
                <Header style="height: 80px"></Header>
            </el-header>
            <el-main>
                <div class="welcome">
                    <h2>你好，{{ Info.userName }} 同学！</h2>
                    <div class="time-display">{{ currentTime }}</div>
                </div>

                <el-row :gutter="20" class="equal-height-row">
                    <!-- 课程公告 -->
                    <el-col :span="12">
                        <el-card class="dashboard-card">
                            <div slot="header" class="clearfix">
                                <span>📢 最新公告</span>
                                <el-button
                                    style="float: right; padding: 3px 0"
                                    type="text"
                                    @click="$router.push('/announcements')">
                                    更多
                                </el-button>
                            </div>
                            <ul class="notice-list">
                                <li v-for="(item,index) in notices" :key="index">
                                    <i class="el-icon-message" style="color:#409EFF"></i>
                                    {{ item.title }}
                                    <span class="notice-time">{{ item.time }}</span>
                                </li>
                            </ul>
                        </el-card>
                    </el-col>

                    <!-- 最近学习 -->
                    <el-col :span="12">
                        <el-card class="dashboard-card">
                            <div slot="header" class="clearfix">
                                <span>📚 最近学习</span>
                            </div>
                            <el-carousel class="compact-carousel" indicator-position="outside" height="180px">
                                <el-carousel-item v-for="(course,index) in recentCourses" :key="index">
                                    <div class="course-card" @click="$router.push(`/course/${course.id}`)">
                                        <div class="course-content">
                                            <div class="text-info">
                                                <h3 class="course-title">{{ course.name }}</h3>
                                                <div class="study-time">
                                                    <i class="el-icon-time"></i>
                                                    {{ course.lastStudy }}
                                                </div>
                                            </div>
                                            <div class="progress-dashboard">
                                                <el-progress
                                                    type="dashboard"
                                                    :percentage="course.progress"
                                                    :color="getProgressColor(course.progress)"
                                                    :width="80">
                                                    <span
                                                        class="progress-percent"
                                                        :style="{color: getProgressColor(course.progress)}">
                                                        {{ course.progress }}%
                                                    </span>
                                                </el-progress>
                                            </div>
                                        </div>
                                    </div>
                                </el-carousel-item>
                            </el-carousel>
                        </el-card>
                    </el-col>
                </el-row>

                <!-- 学习进度 -->
                <el-card class="progress-card">
                    <div slot="header" class="clearfix">
                        <span>📈 学习进度</span>
                    </div>
                    <div v-for="item in progressData" :key="item.id" class="progress-item">
                        <div class="course-info">
                            <span>{{ item.course }}</span>
                            <span>{{ item.progress }}%</span>
                        </div>
                        <el-progress
                            :percentage="item.progress"
                            :color="customColors"
                            stroke-width="18"
                            :format="formatProgress"></el-progress>
                    </div>
                </el-card>

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
            currentTime: '',
            timer: null,
            notices: [
                { title: '系统维护通知', time: '2025-05-20' },
                { title: '新增Python课程公告', time: '2025-05-01' },
                { title: '学习打卡活动开始', time: '2025-05-18' },
                { title: '刘晓燕讲座报名开始啦', time: '2025-05-18' }
            ],
            recentCourses: [
                { id: 1, name: 'Python入门', lastStudy: '2小时前', progress: 65 },
                { id: 2, name: 'Web前端开发', lastStudy: '1天前', progress: 42 },
                { id: 3, name: 'Java程序设计', lastStudy: '3天前', progress: 88 }
            ],
            progressData: [
                { course: 'Python编程基础', progress: 65 },
                { course: '前端框架应用', progress: 42 },
                { course: 'Java核心技术', progress: 88 }
            ],
            customColors: [
                { color: '#f56c6c', percentage: 20 },
                { color: '#e6a23c', percentage: 40 },
                { color: '#5cb87a', percentage: 60 },
                { color: '#1989fa', percentage: 80 },
                { color: '#6f7ad3', percentage: 100 }
            ]
        }
    },
    components: { Header },
    mounted() {
        personal({ 'id': Cookies.get("userId") }).then(resp => {
            this.Info = resp.data.resultData
        })
        this.updateTime()
        this.timer = setInterval(this.updateTime, 1000)
    },
    beforeDestroy() {
        clearInterval(this.timer)
    },
    methods: {
        updateTime() {
            const date = new Date()
            const year = date.getFullYear()
            const month = date.getMonth() + 1
            const day = date.getDate()
            const weekdays = ['日', '一', '二', '三', '四', '五', '六']
            const hours = date.getHours().toString().padStart(2, '0')
            const minutes = date.getMinutes().toString().padStart(2, '0')
            const seconds = date.getSeconds().toString().padStart(2, '0')

            this.currentTime =
                `${year}年${month}月${day}日 星期${weekdays[date.getDay()]} ` +
                `${hours}:${minutes}:${seconds}`
        },
        formatProgress(percentage) {
            return `${percentage}% 已完成`
        },
        getProgressColor(percentage) {
            if (percentage >= 80) return '#5cb87a';
            if (percentage >= 60) return '#1989fa';
            if (percentage >= 40) return '#e6a23c';
            return '#f56c6c';
        }
    },
    updated() {
        const roleId = Cookies.get("roleId")
        if(roleId != 3) {
            this.$router.push("/login")
        }
    }
}
</script>

<style scoped>
.el-main {
    height: 90vh !important;
    overflow-y: auto !important;
    padding: 0 50px 120px 50px;
    margin-top: 70px;
}

.welcome {
    margin: 20px 0 35px 0;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.05);
}

.welcome h2 {
    color: #303133;
    margin-bottom: 8px;
}

.time-display {
    font-size: 18px;
    color: #606266;
}

.equal-height-row {
    display: flex;
}
.equal-height-row > .el-col {
    display: flex;
}

.dashboard-card {
    margin-bottom: 20px;
    transition: transform 0.3s;
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
}

.dashboard-card:hover {
    transform: translateY(-3px);
}

.notice-list {
    margin: 0;
    padding: 0;
    flex: 1;
    overflow-y: auto;
    max-height: 240px;
}

.notice-list li {
    list-style: none;
    padding: 12px 0;
    border-bottom: 1px solid #ebeef5;
}

.notice-list li:last-child {
    border-bottom: none;
}

.notice-time {
    float: right;
    color: #909399;
    font-size: 0.9em;
}

.compact-carousel {
    height: 180px !important;
}

.course-card {
    padding: 15px 0;
    height: calc(100% - 30px);
    cursor: pointer;
    transition: all 0.3s;
}

.course-card:hover {
    background: #f8f9fa;
    transform: scale(0.98);
}

.course-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 100%;
    padding: 0 20px;
}

.text-info {
    flex: 1;
    margin-right: 20px;
}

.course-title {
    font-size: 16px;
    font-weight: bold;
    color: #303133;
    margin-bottom: 8px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.study-time {
    color: #909399;
    font-size: 12px;
    display: flex;
    align-items: center;
}

.study-time i {
    margin-right: 5px;
    font-size: 14px;
}

.progress-dashboard {
    position: relative;
    width: 100px;
}

.progress-percent {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-weight: bold;
    font-size: 18px;
}

::v-deep .el-progress__text {
    font-size: 14px !important;
}

.progress-card {
    margin-top: 20px;
}

.progress-item {
    margin-bottom: 25px;
}

.course-info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    color: #606266;
}

.el-progress {
    margin: 12px 0;
}
</style>