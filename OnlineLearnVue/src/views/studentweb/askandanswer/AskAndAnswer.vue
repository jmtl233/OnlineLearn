<template>
    <div class="qa-container">
        <!-- 头部区域 -->
        <div class="header">
            <div class="title-wrapper">
                <h1 class="title">
                    <span class="gradient-text">问答社区</span>
                    <div class="decorative-line"></div>
                </h1>
                <p class="subtitle">智慧碰撞 · 知识提升</p>
            </div>
        </div>

        <!-- 内容区域 -->
        <div class="content-wrapper">
            <transition-group name="list" tag="div" class="qa-list">
                <el-card
                        v-for="t in NotHomeWork"
                        :key="t.id"
                        class="qa-card"
                        :class="{'has-answer': t.restore}"
                        shadow="hover"
                >
                    <!-- 元信息 -->
                    <div class="meta-info">
                        <div class="left-meta">
                            <el-tag
                                    class="topic-tag"
                                    effect="dark"
                                    :color="getTopicColor(t.topic)"
                            >
                                {{ t.topic }}
                            </el-tag>
                            <div class="time-info">
                                <i class="iconfont icon-r-clock"></i>
                                {{ t.createTime || '2024-03-20' }}
                            </div>
                        </div>
                        <el-tag
                                :type="t.status === '已回复' ? 'success' : 'warning'"
                                effect="light"
                                class="status-tag"
                                :class="{'pulse': !t.restore}"
                        >
                            <i :class="t.restore ? 'iconfont icon-r-clock' : 'iconfont icon-r-clock'" />
                            {{ t.status || '待回复' }}
                        </el-tag>
                    </div>

                    <!-- 问题内容 -->
                    <div class="content-section">
                        <div class="question">
                            <div class="user-info">
                                <div class="avatar">
                                    <img v-if="t.avatar" :src="t.avatar" alt="avatar">
                                    <i v-else class="iconfont el-icon-s-opportunity"></i>
                                </div>
                                <div class="user-detail">
                                    <span class="username">{{ t.senderName }}</span>
                                    <span class="user-role">学生</span>
                                </div>
                            </div>
                            <div class="question-content">
                                <div class="content-text">
                                    <i class="decorative-quote">“</i>
                                    {{ t.content }}
                                    <i class="decorative-quote">”</i>
                                </div>
                                <div class="action-buttons">
                                    <el-button type="text" class="icon-button">
                                        <i class="iconfont icon-r-like"></i>
                                    </el-button>
                                    <el-button type="text" class="icon-button">
                                        <i class="iconfont icon-r-comment"></i>
                                    </el-button>
                                </div>
                            </div>
                        </div>

                        <!-- 回答内容 -->
                        <transition name="slide-fade">
                            <div v-if="t.restore" class="answer" key="answer">
                                <div class="answer-ribbon">老师回复</div>
                                <div class="user-info expert">
                                    <div class="avatar">
                                        <i class="iconfont el-icon-message-solid"></i>
                                    </div>
                                    <div class="user-detail">
                                        <span class="username">{{ t.recipientName }}</span>
                                        <span class="user-role">老师</span>
                                    </div>
                                </div>
                                <div class="answer-content">
                                    <div class="content-text">
                                        <i class="decorative-quote">“</i>
                                        {{ t.restore }}
                                        <i class="decorative-quote">”</i>
                                    </div>
                                    <div class="expert-badge">
                                        <i class="iconfont icon-r-medal"></i>
                                        专业认证
                                    </div>
                                </div>
                            </div>
                            <div v-else class="pending-answer" key="pending">
                                <div class="loading-wrapper">
                                    <div class="loading-dots">
                                        <div class="dot"></div>
                                        <div class="dot"></div>
                                        <div class="dot"></div>
                                    </div>
                                    <span>正在等待老师回复中...</span>
                                </div>
                            </div>
                        </transition>
                    </div>

                    <!-- 分页 -->
                    <el-pagination>
                        class="pagination"
                        background
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="page.page"
                        :page-sizes="[10, 20, 30, 40]"
                        :page-size="page.pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="NotHomeWork.length"
                    </el-pagination>
                </el-card>
            </transition-group>
        </div>
    </div>
</template>

<script>
import { askandanswer } from '../../../api/studentweb/askandanswer.js'
import Cookies from "js-cookie";

export default {
    name: "AskAndAnswer",
    data() {
        return {
            page: {
                page: 1,
                pageSize: 10,
                userId: 0,
            },
            NotHomeWork: [],
        }
    },
    created() {
        this.page.userId = Cookies.get('userId')
        this.CheckWork(this.page)
    },
    methods: {
        handleSizeChange(size) {
            this.page.pageSize = size;
            this.listAllStudentsScore(this.page)
        },
        handleCurrentChange(pageNum) {
            this.page.pageNum = pageNum;
            this.listAllStudentsScore(this.page)
        },
        CheckWork(valid) {
            askandanswer(valid).then(resp => {
                this.NotHomeWork = resp.data.resultData.data
            })
        },
        getTopicColor(topic) {
            const colors = {
                '数学': '#3498db',
                '语文': '#e74c3c',
                '英语': '#9b59b6',
                '物理': '#2ecc71',
                '化学': '#f1c40f'
            }
            return colors[topic] || '#34495e'
        }
    }
}
</script>

<style scoped>
/* 基础样式 */
.qa-container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
}

/* 头部样式 */
.header {
    text-align: center;
    margin-bottom: 3rem;
    position: relative;
}

.title-wrapper {
    display: inline-block;
    position: relative;
}

.title {
    font-size: 2.8rem;
    margin: 0;
    position: relative;
    z-index: 1;
}

.gradient-text {
    background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: textShine 3s ease-in-out infinite;
}

.decorative-line {
    position: absolute;
    bottom: -8px;
    left: 50%;
    transform: translateX(-50%);
    width: 120%;
    height: 4px;
    background: linear-gradient(90deg, transparent, #3498db, transparent);
    opacity: 0.3;
}

.subtitle {
    color: #7f8c8d;
    font-size: 1.1rem;
    letter-spacing: 2px;
    margin-top: 1rem;
}

/* 卡片样式 */
.qa-list {
    display: grid;
    gap: 2rem;
}

.qa-card {
    border-radius: 16px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: 2px solid transparent;
    overflow: hidden;
    position: relative;
}

.qa-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.08);
    border-color: #3498db;
}

.has-answer {
    border-left: 4px solid #2ecc71;
}

/* 元信息样式 */
.meta-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #eee;
}

.topic-tag {
    border-radius: 8px;
    font-weight: bold;
    color: white !important;
    border: none;
}

.status-tag {
    border-radius: 20px;
    padding: 5px 15px;
    transition: all 0.3s ease;
}

.status-tag.pulse {
    animation: pulse 1.5s infinite;
}

/* 用户信息 */
.user-info {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 1.5rem;
}

.avatar {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: #f0f7ff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    color: #3498db;
}

.avatar img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}

.user-detail {
    display: flex;
    flex-direction: column;
}

.username {
    font-weight: 600;
    color: #2c3e50;
}

.user-role {
    font-size: 0.9rem;
    color: #7f8c8d;
}

/* 问题内容 */
.question-content {
    position: relative;
    padding-left: 2rem;
    margin-left: 1rem;
}

.decorative-quote {
    position: absolute;
    font-size: 3rem;
    color: rgba(52, 152, 219, 0.2);
    font-style: italic;
    font-family: serif;
}

.decorative-quote:first-child {
    top: -10px;
    left: -10px;
}

.decorative-quote:last-child {
    bottom: -20px;
    right: -10px;
}

.content-text {
    font-size: 1.1rem;
    line-height: 1.8;
    color: #34495e;
    position: relative;
    z-index: 1;
}

/* 回答样式 */
.answer {
    margin-top: 2rem;
    padding: 1.5rem;
    background: #fff6ef;
    border-radius: 12px;
    position: relative;
}

.answer-ribbon {
    position: absolute;
    top: -10px;
    right: -10px;
    background: #2ecc71;
    color: white;
    padding: 6px 20px;
    border-radius: 20px;
    font-size: 0.9rem;
    box-shadow: 0 2px 5px rgba(46, 204, 113, 0.3);
}

.expert .avatar {
    background: #fad4a7;
    color: #e67e22;
}

.expert-badge {
    margin-top: 1rem;
    padding: 8px 15px;
    background: rgba(231, 126, 34, 0.1);
    border-radius: 20px;
    color: #e5944e;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

/* 加载状态 */
.pending-answer {
    margin-top: 2rem;
    text-align: center;
    padding: 2rem;
    background: rgba(241, 196, 15, 0.05);
    border-radius: 12px;
}

.loading-dots {
    display: flex;
    justify-content: center;
    gap: 6px;
    margin-bottom: 1rem;
}

.dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #3498db;
    animation: bounce 1.2s infinite;
}

.dot:nth-child(2) { animation-delay: 0.2s; }
.dot:nth-child(3) { animation-delay: 0.4s; }

/* 分页样式 */
.pagination {
    margin-top: 3rem;
}

/* 动画 */
@keyframes textShine {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-8px); }
}

@media (max-width: 768px) {
    .qa-container {
        padding: 1rem;
    }

    .title {
        font-size: 2rem;
    }

    .qa-card {
        border-radius: 12px;
    }
}
</style>