<template>
    <div class="dashboard-container">
        <!-- 操作头部 -->
        <div class="action-header">
            <div class="header-content">
                <h2 class="page-title">班级列表</h2>
                <div class="action-group">
                    <el-button
                        type="primary"
                        icon="el-icon-document"
                        class="modern-btn"
                        @click="$router.push('/applicanthistory')"
                    >
                        申请记录
                        <i class="el-icon-arrow-right el-icon--right"></i>
                    </el-button>
                </div>
            </div>
        </div>

        <!-- 班级信息表 -->
        <div class="table-wrapper">
            <el-table
                :data="StudentClassData"
                style="width: 100%"
                class="modern-table"
                :header-cell-style="headerStyle"
                :cell-style="cellStyle"
                fit
            >
                <!-- 班级信息列 -->
                <el-table-column label="班级信息" width="300">
                    <template slot-scope="{ row }">
                        <div class="class-info">
                            <div class="class-icon">
                                <i class="el-icon-school" />
                            </div>
                            <div class="class-details">
                                <h3 class="class-name">{{ row.className }}</h3>
                            </div>
                        </div>
                    </template>
                </el-table-column>

                <!-- 审核老师列 -->
                <el-table-column label="审核老师" min-width="260">
                    <template slot-scope="{ row }">
                        <div class="teacher-info">
                            <el-avatar
                                :size="40"
                                :src="row.reviewTeacherAvatar"
                                class="teacher-avatar"
                                :style="{backgroundColor: '#e6f7ff'}"
                            >
                                <i
                                    class="el-icon-s-custom"
                                    :style="{color: '#1890ff', fontSize: '20px'}"
                                />
                            </el-avatar>
                            <div class="teacher-details">
                                <p class="teacher-name">{{ row.reviewTeacherName }}</p>
                            </div>
                        </div>
                    </template>
                </el-table-column>

                <!-- 创建时间列 -->
                <el-table-column label="创建时间" min-width="200">
                    <template slot-scope="{ row }">
                        <div class="time-info">
                            <el-icon class="time-icon"><i class="el-icon-time" /></el-icon>
                            <span class="time-text">{{ formatDate(row.createTime) }}</span>
                        </div>
                    </template>
                </el-table-column>

                <!-- 状态列 -->
                <el-table-column label="状态" align="right" min-width="180">
                    <template slot-scope="{ row }">
                        <el-button
                            :type="flag ? 'warning' : 'primary'"
                            :icon="flag ? 'el-icon-warning' : 'el-icon-circle-plus'"
                            @click="handleAction(row.id)"
                            class="action-btn"
                            plain
                        >
                            {{ flag ? '不能加入班级' : '加入班级' }}
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!-- 分页 -->
        <div class="pagination-wrapper">
            <el-pagination
                background
                layout="prev, pager, next, jumper"
                :page-size="page.pageSize"
                :total="StudentClassData.length"
                @current-change="handleCurrentChange"
                :pager-count="5"
                class="modern-pagination"
            />
        </div>
    </div>
</template>

<script>
import { smanamgent, addClass, isFlage } from "../../../api/studentweb/studentmanagement.js";
import Cookies from "js-cookie";

export default {
    name: "StudentManagement",
    data() {
        return {
            StudentClassData: [],
            page: {
                page: 1,
                pageSize: 8,
            },
            addClassStudent: {
                classId: '',
                userId: Cookies.get('userId')
            },
            flag: Cookies.get('classId') !== 'undefined'
        }
    },
    created() {
        this.isAllFlag({ userId: Cookies.get("userId") });
        this.StudentClass(this.page);
    },
    methods: {
        handleAction(classId) {
            if (this.flag) {
                this.$message({
                    message: '您已加入班级或者已有申请',
                    type: 'warning',
                    customClass: 'action-message',
                    duration: 2000
                });
            } else {
                this.studentAddClass(classId);
            }
        },
        isAllFlag(param) {
            isFlage(param).then(resp => {
                this.flag = resp.data.resultData;
            })
        },
        handleSizeChange(size) {
            this.page.pageSize = size;
            this.StudentClass(this.page);
        },
        handleCurrentChange(pageNum) {
            this.page.page = pageNum;
            this.StudentClass(this.page);
        },
        StudentClass(page) {
            smanamgent(page).then(resp => {
                this.StudentClassData = resp.data.resultData.data;
            })
        },
        studentAddClass(classId) {
            this.addClassStudent.classId = classId;
            addClass(this.addClassStudent).then(resp => {
                if (resp.data.code === 200) {
                    this.$notify({
                        title: '申请成功',
                        message: '已提交加入申请，请等待审核',
                        type: 'success',
                        duration: 2500,
                        customClass: 'notify-success'
                    });
                    this.flag = true;
                }
            })
        },
        formatDate(date) {
            return date ? new Date(date).toLocaleDateString() : '--';
        },
        headerStyle() {
            return {
                background: '#f8fafc',
                color: '#64748b',
                fontSize: '14px',
                fontWeight: 600,
                textAlign: 'center'
            }
        },
        cellStyle() {
            return {
                color: '#475569',
                fontSize: '14px',
                textAlign: 'center'
            }
        }
    }
}
</script>

<style scoped>
.dashboard-container {
    width: 100%;
    height: 100vh;
    padding: 24px;
    box-sizing: border-box;
    background: #f8fafc;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 统一头部和表格的容器样式 */
.action-header,
.table-wrapper {
    width: 100%;
    max-width: 1280px;
    box-sizing: border-box;
}

.action-header {
    margin-bottom: 24px;
}

.header-content {
    background: white;
    padding: 20px 24px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.table-wrapper {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    flex: 1;
    overflow: hidden;
    padding: 16px;
}

/* 其他样式保持优化 */
.page-title {
    margin: 0;
    font-size: 22px;
    color: #1a2f53;
    display: flex;
    align-items: center;
}

.page-title::before {
    content: "";
    display: inline-block;
    width: 4px;
    height: 20px;
    background: #1890ff;
    margin-right: 12px;
    border-radius: 2px;
}

.modern-btn {
    padding: 12px 24px;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.modern-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(24, 144, 255, 0.3);
}

.class-info {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 16px;
    text-align: center;
}

.pagination-wrapper {
    padding: 24px 0;
    width: 100%;
    max-width: 1280px;
}
</style>