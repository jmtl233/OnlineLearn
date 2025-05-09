<template>
    <div class="admin-dashboard">
        <!-- 数据概览卡片 -->
        <div class="dashboard-card">
            <div class="card-header">
                <span class="edu-icon">📊</span>
                <h2>平台数据概览</h2>
            </div>

            <div class="stats-container">
                <div class="stat-item">
                    <div class="stat-value">10</div>
                    <div class="stat-label">今日活跃学员</div>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <div class="stat-value">3</div>
                    <div class="stat-label">新增课程</div>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <div class="stat-value">86%</div>
                    <div class="stat-label">课程完成率</div>
                </div>
            </div>
        </div>

        <!-- 快速入口 -->
        <div class="quick-actions">
            <div class="action-card" @click="navigateTo('/classmanagementadmin')">
                <div class="action-icon">📚</div>
                <h3>班级管理</h3>
            </div>
            <div class="action-card" @click="navigateTo('/adminstudentmanagement')">
                <div class="action-icon">👥</div>
                <h3>学生管理</h3>
            </div>
            <div class="action-card" @click="navigateTo('/testmanagement')">
                <div class="action-icon">📈</div>
                <h3>数据统计</h3>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "AdminHome",
    methods: {
        navigateTo(route) {
            // 实际项目中替换为路由跳转逻辑
            console.log(`Navigate to: ${route}`);
        }
    }
}
</script>

<style scoped>
/* 基础布局 */
.admin-dashboard {
    min-height: 100vh;
    padding: 2rem;
    background: #f8fafd;
    display: grid;
    gap: 2rem;
    align-content: start;
}

/* 数据概览卡片 */
.dashboard-card {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.card-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 2rem;
}

.card-header h2 {
    color: #2d3748;
    font-size: 1.5rem;
    font-weight: 600;
}

.edu-icon {
    font-size: 2rem;
}

/* 数据统计 */
.stats-container {
    display: flex;
    justify-content: space-around;
    gap: 1rem;
}

.stat-item {
    text-align: center;
}

.stat-value {
    color: #4299e1;
    font-size: 2.2rem;
    font-weight: 600;
    line-height: 1.2;
}

.stat-label {
    color: #718096;
    font-size: 0.95rem;
    margin-top: 0.5rem;
}

.stat-divider {
    width: 1px;
    background: #e2e8f0;
}

/* 快速入口 */
.quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
}

.action-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    cursor: pointer;
    transition: transform 0.2s ease;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.action-card:hover {
    transform: translateY(-3px);
}

.action-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.action-card h3 {
    color: #2d3748;
    font-size: 1.1rem;
    font-weight: 500;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .admin-dashboard {
        padding: 1rem;
    }

    .stats-container {
        flex-direction: column;
    }

    .stat-divider {
        height: 1px;
        width: 60%;
        margin: 1rem auto;
    }

    .stat-value {
        font-size: 1.8rem;
    }
}
</style>