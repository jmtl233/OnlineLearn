<template>
    <div class="communication-container">
        <div
            v-if="shduleData.length <= 0"
            class="empty-state"
        >
            <i class="el-icon-document"></i>
            <span>暂无沟通记录</span>
        </div>

        <el-timeline v-else>
            <el-timeline-item
                v-for="t in shduleData"
                :key="t.id"
                :timestamp="t.createTime"
                placement="top"
                :color="t.status === 1 ? '#67C23A' : '#E6A23C'"
            >
                <el-card
                    :class="['message-card', t.status === 1 ? 'answered' : 'pending']"
                    shadow="hover"
                >
                    <!-- 状态标签 -->
                    <div class="status-tag">
                        <el-tag
                            :type="t.status === 1 ? 'success' : 'warning'"
                            effect="dark"
                        >
                            {{ t.status === 1 ? '已回复' : '待回复' }}
                        </el-tag>
                    </div>

                    <!-- 沟通主体 -->
                    <div class="communication-body">
                        <div class="participants">
                            <div class="participant">
                                <span class="name">{{ t.senderName }}</span>
                                <el-tag type="info" size="mini">提问者</el-tag>
                            </div>
                            <div class="participant">
                                <span class="name">{{ t.recipientName }}</span>
                                <el-tag type="info" size="mini">回答者</el-tag>
                            </div>
                        </div>

                        <el-divider content-position="left">问题详情</el-divider>

                        <div class="content-section">
                            <div class="question">
                                <h4 class="section-title">
                                    <i class="el-icon-question"></i>
                                    问题描述
                                </h4>
                                <el-input
                                    type="textarea"
                                    :rows="2"
                                    :value="t.content"
                                    readonly
                                    resize="none"
                                    class="readonly-input"
                                ></el-input>
                            </div>

                            <div class="answer">
                                <h4 class="section-title">
                                    <i class="el-icon-chat-dot-round"></i>
                                    {{ t.status === 1 ? '回复内容' : '等待回复' }}
                                </h4>
                                <el-input
                                    type="textarea"
                                    :rows="2"
                                    v-model="t.restore"
                                    :readonly="t.status === 1"
                                    :class="{'answered-input': t.status === 1}"
                                    :placeholder="t.status === 1 ? '' : '请输入回复内容'"
                                ></el-input>
                            </div>
                        </div>

                        <!-- 操作按钮 -->
                        <div class="action-bar">
                            <el-button
                                v-if="t.status !== 1"
                                type="success"
                                icon="el-icon-check"
                                @click="restor(t)"
                            >
                                提交回复
                            </el-button>
                            <div v-else class="answered-time">
                                <i class="el-icon-success"></i>
                                <span>已回复于 {{ t.updateTime }}</span>
                            </div>
                        </div>
                    </div>
                </el-card>
            </el-timeline-item>
        </el-timeline>

        <el-pagination
            v-if="shduleData.length > 0"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="page.page"
            :page-sizes="[10, 20, 30, 40]"
            :page-size="page.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="totalCount"
            class="pagination"
        ></el-pagination>
    </div>
</template>

<script>
import { listAllShdule, addShdule } from "../../api/shdule";
import Cookies from "js-cookie";

export default {
    name: "CourseManagement",
    data() {
        return {
            shduleData: [],
            totalCount: 0,
            page: {
                page: 1,
                pageSize: 10,
                userId: Cookies.get('userId')
            },
            // 添加本地缓存记录已回复的问题ID
            answeredQuestionIds: JSON.parse(localStorage.getItem('answeredQuestionIds') || '[]'),
            // 添加本地缓存记录回复时间
            answeredQuestionTimes: JSON.parse(localStorage.getItem('answeredQuestionTimes') || '{}')
        }
    },
    created() {
        this.listShdule()
    },
    methods: {
        // 回复功能
        async restor(item) {
            try {
                // 保存原始状态用于错误回滚
                const originalStatus = item.status
                const originalRestore = item.restore

                // 确保状态值正确设置为1（已回复）
                item.status = 1
                item.restore = item.restore || ''

                // 添加更新时间
                const currentTime = new Date().toLocaleString()
                item.updateTime = currentTime

                const { data } = await addShdule(item)
                if (data.code === 200) {
                    this.$message.success('回复成功')

                    // 确保本地数据更新
                    if (data.resultData) {
                        Object.assign(item, data.resultData)
                    }

                    // 将已回复的问题ID添加到本地缓存
                    if (!this.answeredQuestionIds.includes(item.id)) {
                        this.answeredQuestionIds.push(item.id)
                        localStorage.setItem('answeredQuestionIds', JSON.stringify(this.answeredQuestionIds))
                    }

                    // 保存回复时间到本地存储
                    this.answeredQuestionTimes[item.id] = currentTime
                    localStorage.setItem('answeredQuestionTimes', JSON.stringify(this.answeredQuestionTimes))

                    // 不刷新整个列表，而是直接更新当前项的状态
                    this.$set(item, 'status', 1)
                    this.$set(item, 'updateTime', currentTime)
                } else {
                    // 回滚状态
                    item.status = originalStatus
                    item.restore = originalRestore
                    this.$message.error('回复失败')
                }
            } catch (error) {
                console.error('回复失败:', error)
                this.$message.error('回复失败')
            }
        },

        // 获取数据列表
        async listShdule() {
            try {
                const { data } = await listAllShdule(this.page)
                if (data.code === 200) {
                    // 获取新数据
                    const newData = data.resultData.data

                    // 使用本地缓存确保已回复的项目状态保持不变
                    newData.forEach(item => {
                        if (this.answeredQuestionIds.includes(item.id)) {
                            item.status = 1

                            // 从本地存储获取时间并设置
                            if (this.answeredQuestionTimes[item.id]) {
                                item.updateTime = this.answeredQuestionTimes[item.id]
                            } else if (!item.updateTime) {
                                // 如果没有存储的时间，使用当前时间并保存
                                const currentTime = new Date().toLocaleString()
                                item.updateTime = currentTime
                                this.answeredQuestionTimes[item.id] = currentTime
                                localStorage.setItem('answeredQuestionTimes', JSON.stringify(this.answeredQuestionTimes))
                            }
                        }
                    })

                    this.shduleData = newData
                    this.totalCount = data.resultData.total
                }
            } catch (error) {
                console.error('获取数据失败:', error)
            }
        },

        handleSizeChange(size) {
            this.page.pageSize = size
            this.listShdule()
        },

        handleCurrentChange(page) {
            this.page.page = page
            this.listShdule()
        }
    }
}
</script>

<style scoped>
/* 原有样式保持不变 */
.communication-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
}

.empty-state {
    text-align: center;
    padding: 60px 0;
    color: #909399;
    font-size: 18px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.empty-state i {
    font-size: 48px;
    margin-bottom: 20px;
}

.message-card {
    position: relative;
    border-radius: 8px;
    margin: 10px 0;
}

.message-card.answered {
    border-left: 3px solid #67C23A;
}

.message-card.pending {
    border-left: 3px solid #E6A23C;
}

.status-tag {
    position: absolute;
    right: 20px;
    top: -10px;
}

.participants {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
}

.participant {
    display: flex;
    align-items: center;
    gap: 8px;
}

.name {
    font-weight: 500;
    color: #303133;
}

.content-section {
    margin: 20px 0;
}

.section-title {
    color: #606266;
    font-size: 14px;
    margin: 10px 0;
    display: flex;
    align-items: center;
    gap: 6px;
}

.readonly-input >>> .el-textarea__inner {
    background-color: #f5f7fa;
    cursor: default;
}

.answered-input >>> .el-textarea__inner {
    background-color: #f6ffed;
    border-color: #b7eb8f;
}

.action-bar {
    margin-top: 20px;
    display: flex;
    justify-content: flex-end;
}

.answered-time {
    color: #67C23A;
    font-size: 13px;

    display: flex;
    align-items: center;
    gap: 5px;
}

.pagination {
    margin-top: 30px;
    text-align: center;
}

.el-timeline {
    padding-left: 20px;
}
</style>