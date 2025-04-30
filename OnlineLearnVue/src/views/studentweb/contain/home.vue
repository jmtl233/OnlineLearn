<template>
    <div class="student-home">
        <!-- 全局提示条 -->
        <div class="global-alert">
            <el-alert
                title="系统维护通知：本周六凌晨2:00-4:00进行系统升级"
                type="info"
                :closable="false"
                show-icon>
            </el-alert>
        </div>

        <!-- 轮播图优化 -->
        <el-carousel
            :interval="5000"
            height="420px"
            indicator-position="outside"
            arrow="always">
            <el-carousel-item
                v-for="(item, index) in carouselItems"
                :key="index"
                class="carousel-item">
                <div class="carousel-mask"></div>
                <img
                    :src="item.src"
                    class="carousel-img"
                    @error="handleImageError(item)"><!-- 新增错误处理 -->
                @click="handleBannerClick(item.link)">
                <div class="carousel-caption">
                    <h3>{{ item.title }}</h3>
                    <p>{{ item.description }}</p>
                </div>
            </el-carousel-item>
        </el-carousel>

        <!-- 快捷导航优化 -->
        <div class="quick-nav">
            <el-row :gutter="20">
                <el-col
                    v-for="(nav, index) in quickActions"
                    :key="index"
                    :xs="12"
                    :sm="8"
                    :md="6"
                    :lg="6">
                    <div
                        class="nav-card"
                        @click="handleNavClick(nav.action)"
                        :style="{background: nav.color}">
                        <div class="nav-icon">
                            <i :class="nav.icon"></i>
                        </div>
                        <div class="nav-content">
                            <h3>{{ nav.title }}</h3>
                            <p>{{ nav.subtitle }}</p>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>

        <!-- 主要内容区优化 -->
        <div class="main-content">
            <!-- 左侧内容 -->
            <div class="left-content">
                <!-- 学习概览 -->
                <el-card class="stats-card">
                    <div slot="header" class="stats-header">
                        <div class="header-left">
                            <i class="el-icon-data-line"></i>
                            <span>学习概览</span>
                        </div>
                        <el-date-picker
                            v-model="studyDate"
                            type="week"
                            format="第 WW 周"
                            value-format="timestamp"
                            @change="fetchStudyData">
                        </el-date-picker>
                    </div>
                    <el-row :gutter="20">
                        <el-col
                            v-for="(stat, index) in studyStats"
                            :key="index"
                            :span="8">
                            <div class="stat-item">
                                <div class="stat-icon" :style="{background: stat.color}">
                                    <i :class="stat.icon"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-value">{{ stat.value }}</div>
                                    <div class="stat-label">{{ stat.label }}</div>
                                </div>
                            </div>
                        </el-col>
                    </el-row>
                </el-card>

                <!-- 最新公告优化 -->
                <el-card class="notice-card">
                    <div slot="header" class="notice-header">
                        <i class="el-icon-megaphone"></i>
                        <span>最新公告</span>
                        <el-button
                            type="text"
                            @click="showAllNotices"
                            class="more-btn">
                            查看全部 <i class="el-icon-arrow-right"></i>
                        </el-button>
                    </div>
                    <el-scrollbar height="300px">
                        <el-timeline>
                            <el-timeline-item
                                v-for="(notice, index) in notices"
                                :key="index"
                                :timestamp="notice.time"
                                :type="notice.type"
                                placement="top"
                                :color="noticeColorMap[notice.type]">
                                <el-card shadow="hover">
                                    <h4>{{ notice.title }}</h4>
                                    <p class="notice-content">{{ notice.content }}</p>
                                    <div class="notice-footer">
                                        <span class="notice-type">{{ typeMap[notice.type] }}</span>
                                        <el-button
                                            type="text"
                                            v-if="notice.attachment"
                                            @click="downloadAttachment(notice.attachment)">
                                            <i class="el-icon-paperclip"></i> 下载附件
                                        </el-button>
                                    </div>
                                </el-card>
                            </el-timeline-item>
                        </el-timeline>
                    </el-scrollbar>
                </el-card>
            </div>

            <!-- 右侧知识点优化 -->
            <div class="right-content">
                <el-card class="knowledge-card">
                    <div slot="header" class="knowledge-header">
                        <i class="el-icon-notebook-2"></i>
                        <span>补充知识点</span>
                        <el-button
                            type="text"
                            @click="refreshKnowledge"
                            class="refresh-btn">
                            <i class="el-icon-refresh"></i>
                        </el-button>
                    </div>
                    <el-skeleton :loading="loading" animated :count="3">
                        <template slot="template">
                            <el-skeleton-item
                                variant="card"
                                class="skeleton-item" />
                        </template>

                        <el-scrollbar height="560px">
                            <div
                                v-for="point in points"
                                :key="point.id"
                                class="knowledge-item"
                                @click="viewDetail(point.id)">
                                <div class="point-header">
                                    <el-tag
                                        size="mini"
                                        :type="pointTypeMap[point.type]">
                                        {{ point.courseName }}
                                    </el-tag>
                                    <span class="point-title">{{ point.title }}</span>
                                </div>
                                <div class="point-content">{{ point.content }}</div>
                                <div class="point-footer">
                                    <div class="meta-info">
                    <span class="author">
                      <i class="el-icon-user"></i>
                      {{ point.author }}
                    </span>
                                        <time class="update-time">
                                            <i class="el-icon-time"></i>
                                            {{ formatTime(point.updateTime) }}
                                        </time>
                                    </div>
                                    <el-rate
                                        v-model="point.difficulty"
                                        disabled
                                        :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                                        :max="3">
                                    </el-rate>
                                </div>
                            </div>
                        </el-scrollbar>
                    </el-skeleton>
                </el-card>
            </div>
        </div>

        <!-- 版权信息 -->
        <div class="footer">
            <p>© 2025 在线学习平台 版权所有</p>
        </div>
    </div>
</template>

<script>
import { stuPointList } from '@/api/admin/knowpoint'
import Cookies from "js-cookie"

export default {
    name: 'StudentHome',
    data() {
        return {
            points: [],
            loading: true,
            studyDate: new Date().getTime(),
            studyStats: [
                {
                    icon: 'el-icon-document-checked',
                    value: '12.5h',
                    label: '学习时长',
                    color: '#409EFF'
                },
                {
                    icon: 'el-icon-odometer',
                    value: '85%',
                    label: '课程进度',
                    color: '#67C23A'
                },
                {
                    icon: 'el-icon-collection-tag',
                    value: '3',
                    label: '待完成任务',
                    color: '#E6A23C'
                }
            ],
            carouselItems: [
                {
                    src: require('@/assets/python.jpg'), // 建议统一命名规范
                    title: '新课程上线',
                    description: 'Python基础课程全面升级',
                    link: '/courses/123'
                },
                {
                    src: require('@/assets/java.jpg'),
                    title: 'Java核心知识',
                    description: '从入门到精通系统学习',
                    link: '/competition'
                },
                {
                    src: require('@/assets/hadoop.jpg'),
                    title: 'Hadoop实战',
                    description: '大数据处理技术精讲',
                    link: '/activity'
                }
            ],
            quickActions: [
                {
                    title: '我的课程',
                    subtitle: '继续学习',
                    icon: 'el-icon-notebook-1',
                    action: 'course',
                    color: 'linear-gradient(135deg, #409EFF, #79BBFF)'
                },
                {
                    title: '作业任务',
                    subtitle: '及时完成',
                    icon: 'el-icon-edit-outline',
                    action: 'homework',
                    color: 'linear-gradient(135deg, #67C23A, #95D475)'
                },
                {
                    title: '在线测试',
                    subtitle: '能力检测',
                    icon: 'el-icon-document-checked',
                    action: 'exam',
                    color: 'linear-gradient(135deg, #E6A23C, #EEBE77)'
                },
                {
                    title: '学习报告',
                    subtitle: '成长分析',
                    icon: 'el-icon-data-analysis',
                    action: 'report',
                    color: 'linear-gradient(135deg, #909399, #B1B3B8)'
                }
            ],
            notices: [
                {
                    title: '系统维护通知',
                    content: '本周将进行系统维护升级，请合理安排学习时间',
                    type: 'system',
                    time: '2024-03-25 10:00'
                },
                {
                    title: '课程更新公告',
                    content: '新增Python编程进阶课程，欢迎学习体验',
                    type: 'course',
                    time: '2024-03-24 15:30',
                    attachment: '/docs/python-course.pdf'
                }
            ],
            noticeColorMap: {
                system: '#409EFF',
                course: '#67C23A',
                exam: '#E6A23C'
            },
            typeMap: {
                system: '系统公告',
                course: '课程通知',
                exam: '考试信息'
            },
            pointTypeMap: {
                1: 'primary',
                2: 'success',
                3: 'warning'
            }
        }
    },
    created() {
        this.fetchKnowledgePoints()
    },
    methods: {
        handleImageError(item){
            console.error(`图片加载失败: ${item.src}`);
            this.$notify.error({
                title: '图片加载失败',
                message: `无法加载 ${item.title} 的封面图`,
                duration: 3000
            });

            // 可选：设置默认图片
            item.src = require('@/assets/python.jpg');
        },
        async fetchKnowledgePoints() {
            try {
                const classId = Cookies.get("classId")
                const { data } = await stuPointList({ classId })
                this.points = data.resultData.map(item => ({
                    ...item,
                    difficulty: Math.ceil(Math.random() * 3)
                }))
            } catch (error) {
                console.error('获取知识点失败:', error)
                this.$notify.error({
                    title: '加载失败',
                    message: '知识点数据加载失败，请稍后重试'
                })
            } finally {
                this.loading = false
            }

        },
        formatTime(timestamp) {
            if (!timestamp) return ''
            const date = new Date(timestamp)
            return `${date.getFullYear()}-${(date.getMonth()+1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`
        },
        handleNavClick(action) {
            const routeMap = {
                course: '/onlinelearn',
                homework: '/nohomework',
                exam: '/studentpractice',
                report: '/practicedetail'
            }
            this.$router.push(routeMap[action])
        },
        viewDetail(id) {
            this.$router.push(`/knowledge/${id}`)
        },
        handleBannerClick(link) {
            this.$router.push(link)
        },
        refreshKnowledge() {
            this.loading = true
            this.fetchKnowledgePoints()
        },
        showAllNotices() {
            this.$router.push('/notices')
        },
        downloadAttachment(url) {
            window.open(url, '_blank')
        }
    }
}
</script>

<style lang="scss" scoped>
.student-home {
    background: #f5f7fa;
    min-height: 100vh;

    .global-alert {
        margin-bottom: 20px;

        ::v-deep .el-alert {
            border-radius: 0;
            padding: 12px 60px;
        }
    }

    .el-carousel {
        margin: 20px 0;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);

        .carousel-item {
            position: relative;

            .carousel-mask {
                position: absolute;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, rgba(0,0,0,0.6) 30%, transparent);
            }

            .carousel-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                cursor: pointer;
                transition: transform 0.3s;

                &:hover {
                    transform: scale(1.05);
                }
            }

            .carousel-caption {
                position: absolute;
                left: 5%;
                top: 50%;
                transform: translateY(-50%);
                color: white;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);

                h3 {
                    font-size: 36px;
                    margin-bottom: 15px;
                }

                p {
                    font-size: 18px;
                    opacity: 0.9;
                }
            }
        }
    }

    .quick-nav {
        margin: 30px 0;

        .nav-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            height: 100px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;

            &:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 16px rgba(0,0,0,0.12);
            }

            .nav-icon {
                width: 50px;
                height: 50px;
                border-radius: 8px;
                background: rgba(255,255,255,0.9);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;

                i {
                    font-size: 28px;
                    color: inherit;
                }
            }

            .nav-content {
                h4 {
                    margin: 0;
                    font-size: 16px;
                    color: #303133;
                }

                p {
                    margin: 5px 0 0;
                    font-size: 12px;
                    color: #606266;
                }
            }
        }
    }

    .main-content {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 20px;
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 25px;

        @media (max-width: 768px) {
            .el-col-xs-12 {
                margin-bottom: 15px;

                &:last-child {
                    margin-bottom: 0;
                }
            }
        }
    }

    .stats-card {
        margin-bottom: 25px;

        .stats-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;

            .header-left {
                display: flex;
                align-items: center;

                i {
                    font-size: 20px;
                    color: #409EFF;
                    margin-right: 10px;
                }

                span {
                    font-weight: 600;
                    color: #303133;
                }
            }
        }

        .stat-item {
            display: flex;
            align-items: center;
            padding: 20px;
            background: #fafafa;
            border-radius: 8px;

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;

                i {
                    color: white;
                    font-size: 24px;
                }
            }

            .stat-info {
                .stat-value {
                    font-size: 24px;
                    font-weight: bold;
                    color: #303133;
                }

                .stat-label {
                    color: #909399;
                    font-size: 14px;
                }
            }
        }
    }

    .notice-card {
        .notice-header {
            display: flex;
            align-items: center;
            padding: 0 10px;

            i {
                font-size: 20px;
                color: #E6A23C;
                margin-right: 10px;
            }

            .more-btn {
                margin-left: auto;
                padding: 0;
            }
        }

        .notice-content {
            line-height: 1.6;
            color: #606266;
        }

        .notice-footer {
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;

            .notice-type {
                padding: 4px 8px;
                border-radius: 4px;
                background: #f0f2f5;
                font-size: 12px;
            }
        }
    }

    .knowledge-card {
        .knowledge-header {
            display: flex;
            align-items: center;
            padding: 0 10px;

            i {
                font-size: 20px;
                color: #67C23A;
                margin-right: 10px;
            }

            .refresh-btn {
                margin-left: auto;
                padding: 0;
                font-size: 18px;
            }
        }

        .knowledge-item {
            background: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;

            &:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            }

            .point-header {
                display: flex;
                align-items: center;
                margin-bottom: 12px;

                .point-title {
                    margin-left: 10px;
                    font-weight: 500;
                    color: #303133;
                }
            }

            .point-content {
                color: #606266;
                font-size: 14px;
                line-height: 1.6;
                margin-bottom: 12px;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 3;
                overflow: hidden;
            }

            .point-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;

                .meta-info {
                    display: flex;
                    gap: 15px;
                    font-size: 12px;
                    color: #909399;

                    i {
                        margin-right: 4px;
                    }
                }
            }
        }
    }

    .footer {
        margin-top: 40px;
        padding: 20px;
        text-align: center;
        color: #909399;
        font-size: 14px;
        border-top: 1px solid #e4e7ed;
    }
}
</style>