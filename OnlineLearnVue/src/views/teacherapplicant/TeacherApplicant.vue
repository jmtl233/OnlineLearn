<template>
    <div class="applicant-container">
        <el-table
            :data="tableData"
            stripe
            style="width: 100%"
            class="applicant-table"
            header-cell-class-name="table-header"
            row-class-name="table-row"
        >
            <el-table-column
                prop="createTime"
                label="创建日期"
                width="180"
                align="center">
            </el-table-column>
            <el-table-column
                sortable
                prop="account"
                label="账号"
                align="center">
            </el-table-column>
            <el-table-column
                prop="userName"
                label="姓名"
                width="180"
                align="center">
            </el-table-column>
            <el-table-column
                prop="studentPhone"
                label="学生电话"
                align="center">
            </el-table-column>
            <el-table-column
                prop="status"
                label="状态"
                align="center">
                <template slot-scope="scope">
                    <el-tag
                        :type="statusType(scope.row.status)"
                        effect="dark"
                    >
                        {{ scope.row.status }}
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column
                prop="charger"
                label="审核人"
                align="center">
            </el-table-column>

            <el-table-column
                label="操作"
                width="260"
                fixed="right"
                align="center"
            >
                <template slot-scope="scope">
                    <div class="action-container">
                        <template v-if="scope.row.status === '待审核'">
                            <el-button
                                type="success"
                                size="medium"
                                class="action-btn confirm-btn"
                                @click="handleEdit(scope.row)"
                            >
                                <i class="el-icon-check"></i> 同意
                            </el-button>
                            <el-button
                                type="danger"
                                size="medium"
                                class="action-btn reject-btn"
                                @click="handleDelete(scope.row)"
                            >
                                <i class="el-icon-close"></i> 驳回
                            </el-button>
                        </template>
                        <div v-else class="status-text">
                            <i :class="statusIcon(scope.row.status)"></i>
                            {{ scope.row.status === '已同意' ? '已通过' : '已驳回' }}
                        </div>
                    </div>
                </template>
            </el-table-column>
        </el-table>

        <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="page.page"
            :page-sizes="[10, 20, 30, 40]"
            :page-size="page.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total"
            class="pagination"
        >
        </el-pagination>
    </div>
</template>

<script>
import { tapplicant, alertapplicant } from "../../api/teacher/teacherapplicant.js";
import Cookies from 'js-cookie'

export default {
    name: "TeacherApplicant",
    data() {
        return {
            tableData: [],
            total: 0,
            page: {
                page: 1,
                pageSize: 10,
                userId: '',
            },
            alertData: {}
        }
    },
    created() {
        this.page.userId = Cookies.get('userId')
        this.listUnApplicant(this.page)
    },
    methods: {
        statusType(status) {
            switch(status) {
                case '已同意': return 'success'
                case '已驳回': return 'danger'
                default: return 'info'
            }
        },//操作那一栏
        statusIcon(status) {
            return {
                'el-icon-circle-check': status === '已同意',
                'el-icon-circle-close': status === '已驳回',
                'status-icon': true
            }
        },
        handleEdit(row) {
            this.alertData = { ...row, status: 2 }
            alertapplicant(this.alertData).then(resp => {
                if (resp.data.code === 200) {
                    this.$message.success('已同意该学生加入班级')
                    this.listUnApplicant(this.page)
                } else {
                    this.$message.error('操作失败')
                }
            })
        },
        handleDelete(row) {
            this.alertData = { ...row, status: 3 }
            alertapplicant(this.alertData).then(resp => {
                if (resp.data.code === 200) {
                    this.$message.success('已驳回该申请')
                    this.listUnApplicant(this.page)
                } else {
                    this.$message.error('操作失败')
                }
            })
        },
        handleSizeChange(size) {
            this.page.pageSize = size
            this.listUnApplicant(this.page)
        },
        handleCurrentChange(pageNum) {
            this.page.page = pageNum
            this.listUnApplicant(this.page)
        },
        listUnApplicant(page) {
            tapplicant(page).then(resp => {
                this.tableData = resp.data.resultData.data
                this.total = resp.data.resultData.total || 0
            })
        }
    }
}
</script>

<style scoped>
.applicant-container {
    padding: 20px;
    background: #f5f7fa;
    border-radius: 8px;
}

.table-header {
    background-color: #409EFF !important;
    color: white;
    font-weight: 600;
}

.table-row {
    transition: all 0.3s ease;
}

.table-row:hover {
    transform: translateY(-2px);
    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}

.action-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 60px;
}

.action-btn {
    width: 100px;
    height: 36px;
    font-size: 14px;
    border-radius: 18px;
    margin: 0 5px;
    transition: all 0.3s ease;
}

.confirm-btn {
    background: linear-gradient(45deg, #67c23a, #85ce61);
    border: none;
}

.reject-btn {
    background: linear-gradient(45deg, #f56c6c, #e6a23c);
    border: none;
}

.status-text {
    color: #909399;
    font-size: 14px;
    display: flex;
    align-items: center;
}

.status-icon {
    margin-right: 5px;
    font-size: 16px;
}

.el-icon-circle-check {
    color: #67c23a;
}

.el-icon-circle-close {
    color: #f56c6c;
}

.pagination {
    margin-top: 20px;
    display: flex;
    justify-content: center;
}

.el-tag {
    font-size: 13px;
    padding: 0 10px;
    border-radius: 10px;
}

@media (max-width: 768px) {
    .action-btn {
        width: 80px;
        font-size: 13px;
        padding: 8px 12px;
    }

    .applicant-container {
        padding: 10px;
    }
}
</style>