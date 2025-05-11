<template>
    <div class="dashboard-container">
        <!-- 顶部欢迎区 -->
        <div class="header-card">
            <div class="header-content">
                <div class="welcome-section">
                    <h1>您好，老师！ 👩🏫</h1>
                    <p class="sub-info">您有3条待办事项 | 2个未读通知</p>
                </div>
                <div class="calendar-widget">
                    <div class="calendar-icon">📅</div>
                    <div class="date-info">
                        <div class="current-date">{{ currentDate }}</div>
                        <div class="weekday">{{ currentWeekday }}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 功能模块网格 -->
        <div class="grid-container">
            <!-- 课程管理 -->
            <div class="function-card" @click="navigateTo('/courses')">
                <div class="card-icon" style="background: #FFF3E0;">📚</div>
                <h3>课程管理</h3>
                <p>当前开课1门</p>
                <div class="stat-badge">+2 新申请</div>
            </div>

            <!-- 学生管理 -->
            <div class="function-card" @click="navigateTo('/students')">
                <div class="card-icon" style="background: #FFECB3;">🎓</div>
                <h3>学生管理</h3>
                <p>班级共10人</p>
                <div class="stat-badge">3 待审核</div>
            </div>

            <!-- 成绩分析 -->
            <div class="function-card" @click="navigateTo('/grades')">
                <div class="card-icon" style="background: #FFE0B2;">📊</div>
                <h3>成绩分析</h3>
                <p>最新考试已完成</p>
                <div class="stat-badge">查看报告 →</div>
            </div>

            <!-- 消息中心 -->
            <div class="function-card" @click="navigateTo('/messages')">
                <div class="card-icon" style="background: #FFCCBC;">📨</div>
                <h3>消息中心</h3>
                <p>2条未读消息</p>
                <div class="stat-badge">1 紧急</div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "TeacherDashboard",
    data() {
        return {
            currentDate: new Date().toLocaleDateString('zh-CN'),
            currentWeekday: new Date().toLocaleDateString('zh-CN', { weekday: 'long' })
        }
    },
    methods: {
        navigateTo(path) {
            // 实际项目中此处添加路由跳转逻辑
            console.log('Navigate to:', path)
        }
    }
}
</script>

<style scoped>
.dashboard-container {
    min-height: 100vh;
    background: linear-gradient(160deg, #FFF3E0 0%, #FFE0B2 100%);
    padding: 30px;
}

.header-card {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(255, 152, 0, 0.1);
    margin-bottom: 30px;
    padding: 2rem;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.welcome-section h1 {
    font-size: 2rem;
    color: #EF6C00;
    margin: 0;
    font-weight: 600;
}

.sub-info {
    color: #8D6E63;
    margin-top: 8px;
    font-size: 0.95rem;
}

.calendar-widget {
    display: flex;
    align-items: center;
    background: #FFF8E1;
    padding: 1rem 1.5rem;
    border-radius: 12px;
}

.calendar-icon {
    font-size: 2rem;
    margin-right: 1.5rem;
}

.date-info {
    line-height: 1.4;
}

.current-date {
    font-size: 1.2rem;
    color: #D84315;
    font-weight: 500;
}

.weekday {
    color: #8D6E63;
    font-size: 0.9rem;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
}

.function-card {
    background: rgba(255, 255, 255, 0.98);
    padding: 1.5rem;
    border-radius: 14px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
}

.function-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(255, 152, 0, 0.15);
}

.function-card::after {
    content: "";
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, #FFB74D 0%, #FF9800 100%);
    opacity: 0;
    transition: opacity 0.3s;
}

.function-card:hover::after {
    opacity: 1;
}

.card-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    margin-bottom: 1rem;
}

.function-card h3 {
    color: #4E342E;
    margin: 0.5rem 0;
    font-size: 1.3rem;
}

.function-card p {
    color: #8D6E63;
    margin: 0.3rem 0;
    font-size: 0.95rem;
}

.stat-badge {
    display: inline-block;
    background: #FFF3E0;
    color: #EF6C00;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    margin-top: 1rem;
    font-weight: 500;
}

@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        align-items: flex-start;
    }

    .calendar-widget {
        margin-top: 1.5rem;
    }

    .dashboard-container {
        padding: 20px;
    }
}

@keyframes cardEntrance {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.function-card {
    animation: cardEntrance 0.6s ease-out;
}
</style>