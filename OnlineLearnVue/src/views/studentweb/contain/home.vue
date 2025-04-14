<template>
    <div>
        <!-- 轮播图部分保持不变 -->
        <el-carousel :interval="4000" type="card" height="400px">
            <el-carousel-item>
                <img src="@/assets/st-bg.jpg" alt="轮播图1" style="height: 100%">
            </el-carousel-item>
            <el-carousel-item>
                <img src="@/assets/ad-bg.jpg" alt="轮播图2" style="height: 100%">
            </el-carousel-item>
            <el-carousel-item>
                <img src="@/assets/tc-bg.jpg" alt="轮播图3" style="height: 100%">
            </el-carousel-item>
        </el-carousel>

        <!-- 新增主内容区 -->
        <div class="main-content">
            <!-- 左侧列 -->
            <div class="left-column">
                <div class="section-title">
                    <i class="el-icon-notebook-2"></i>
                    <span>课程公告</span>
                </div>
                <el-card class="notice-card">
                    <el-timeline>
                        <el-timeline-item
                            v-for="(notice, index) in notices"
                            :key="index"
                            :timestamp="notice.time"
                            placement="top"
                        >
                            <el-alert
                                :title="notice.title"
                                :closable="false"
                                type="info"
                                :description="notice.content"
                            />
                        </el-timeline-item>
                    </el-timeline>
                </el-card>

                <div class="section-title" style="margin-top: 30px">
                    <i class="el-icon-date"></i>
                    <span>最近作业</span>
                </div>
                <el-card class="homework-card">
                    <el-table :data="homeworks" style="width: 100%">
                        <el-table-column prop="name" label="作业名称"></el-table-column>
                        <el-table-column prop="course" label="所属课程"></el-table-column>
                        <el-table-column prop="ddl" label="截止时间"></el-table-column>
                        <el-table-column label="状态">
                            <template slot-scope="scope">
                                <el-tag :type="scope.row.status | statusFilter">
                                    {{ scope.row.status }}
                                </el-tag>
                            </template>
                        </el-table-column>
                    </el-table>
                </el-card>
            </div>

            <!-- 右侧列 -->
            <div class="right-column">
                <div class="section-title">
                    <i class="el-icon-light-rain"></i>
                    <span>补充知识点</span>
                </div>
                <el-card
                    v-for="item in points"
                    :key="item.id"
                    class="knowledge-card"
                >
                    <div slot="header" class="card-header">
                        <el-tag type="warning">知识点</el-tag>
                        <span>{{ item.title }}</span>
                    </div>
                    <div class="text item">
                        {{ item.content }}
                        <div class="extra-info">
                            <span class="course-name">{{ item.course }}</span>
                            <el-button
                                type="text"
                                icon="el-icon-document-copy"
                                @click="handleCopy(item.content)"
                            >
                                复制内容
                            </el-button>
                        </div>
                    </div>
                </el-card>
            </div>
        </div>

        <!-- 新增底部功能区 -->
        <div class="quick-access">
            <el-row :gutter="20">
                <el-col :span="6">
                    <el-card shadow="hover" class="quick-card" @click.native="goToCourse">
                        <i class="el-icon-video-camera-solid"></i>
                        <div>开始学习</div>
                    </el-card>
                </el-col>
                <el-col :span="6">
                    <el-card shadow="hover" class="quick-card" @click.native="goToHomework">
                        <i class="el-icon-edit-outline"></i>
                        <div>作业提交</div>
                    </el-card>
                </el-col>
                <el-col :span="6">
                    <el-card shadow="hover" class="quick-card" @click.native="goToResource">
                        <i class="el-icon-folder-opened"></i>
                        <div>学习资料</div>
                    </el-card>
                </el-col>
                <el-col :span="6">
                    <el-card shadow="hover" class="quick-card" @click.native="goToProgress">
                        <i class="el-icon-data-line"></i>
                        <div>学习进度</div>
                        <el-progress
                            :percentage="progress"
                            :color="customColors"
                            :stroke-width="16"
                            status="success"
                        />
                    </el-card>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
import { stuPointList } from '@/api/admin/knowpoint'
import Cookies from "js-cookie";

export default {
    name: "Home",
    filters: {
        statusFilter(status) {
            const statusMap = {
                '未开始': 'info',
                '进行中': 'warning',
                '已提交': 'success',
                '已过期': 'danger'
            }
            return statusMap[status]
        }
    },
    data() {
        return {
            points: [],
            notices: [
                {
                    title: '数学课程更新通知',
                    content: '第三章微积分内容已更新，请同学们及时学习',
                    time: '2025-05-20'
                },
                {
                    title: '作业提交提醒',
                    content: '《大学英语》第一次作业提交截止时间：2025-05-25',
                    time: '2025-05-18'
                }
            ],
            homeworks: [
                {
                    name: '微积分练习一',
                    course: '高等数学',
                    ddl: '2025-05-25',
                    status: '进行中'
                },
                {
                    name: '英语作文',
                    course: '大学英语',
                    ddl: '2025-05-22',
                    status: '未开始'
                }
            ],
            progress: 65,
            customColors: [
                { color: '#f56c6c', percentage: 20 },
                { color: '#e6a23c', percentage: 40 },
                { color: '#5cb87a', percentage: 60 },
                { color: '#1989fa', percentage: 80 },
                { color: '#6f7ad3', percentage: 100 }
            ]
        }
    },
    created() {
        this.fetchPoints()
    },
    methods: {
        fetchPoints() {
            const classId = Cookies.get("classId")
            stuPointList({ classId }).then(res => {
                this.points = res.data.resultData
            })
        },
        handleCopy(content) {
            navigator.clipboard.writeText(content)
            this.$message.success('内容已复制到剪贴板')
        },
        goToCourse() {
            this.$router.push('/onlinelearn')
        },
        goToHomework() {
            this.$router.push('/studentpractice')
        },
        goToResource() {
            this.$router.push('/onlinelearn')
        },
        goToProgress() {
            this.$router.push('/onlinelearn')
        }
    }
}
</script>

<style scoped>
.main-content {
    display: flex;
    margin: 20px 0;
    gap: 20px;
}

.left-column {
    flex: 4;
}

.right-column {
    flex: 3;
}

.section-title {
    font-size: 20px;
    color: #2c3e50;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.notice-card {
    margin-bottom: 20px;
}

.knowledge-card {
    margin-bottom: 20px;
    transition: transform 0.3s;
}

.knowledge-card:hover {
    transform: translateY(-5px);
}

.card-header {
    display: flex;
    align-items: center;
    gap: 10px;
}

.extra-info {
    margin-top: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #909399;
}

.course-name {
    font-size: 12px;
}

.quick-access {
    margin: 30px 0;
}

.quick-card {
    text-align: center;
    cursor: pointer;
    transition: all 0.3s;
}

.quick-card:hover {
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.15);
}

.quick-card i {
    font-size: 36px;
    margin-bottom: 10px;
    color: #409EFF;
}

.el-progress {
    margin-top: 15px;
}

.homework-card ::v-deep .el-table__row {
    cursor: pointer;
}

.homework-card ::v-deep .el-table__row:hover {
    background-color: #f5f7fa;
}
</style>