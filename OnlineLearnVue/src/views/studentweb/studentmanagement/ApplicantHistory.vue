<template>
    <div class="applicant-container">
        <div class="header-section">
            <div class="header-content">
                <el-button
                    type="primary"
                    icon="el-icon-notebook-2"
                    @click="$router.push('/studentmanagement')"
                    class="enhanced-btn"
                >
                    <span class="btn-text">班级列表</span>
                    <i class="el-icon-arrow-right"></i>
                </el-button>
                <div class="header-title">
                    <i class="el-icon-files"></i>
                    <span>申请记录查询</span>
                </div>
            </div>
            <el-divider class="gradient-divider"></el-divider>
        </div>

        <div class="table-wrapper">
            <el-table
                :data="ApplicantHistory"
                height="calc(100vh - 220px)"
                class="full-width-table"
                header-cell-class-name="table-header"
                cell-class-name="table-cell"
            >
                <el-table-column
                    prop="createTime"
                    label="申请日期"
                    width="180"
                    align="center"
                ></el-table-column>
                <el-table-column
                    prop="className"
                    label="申请班级"
                    width="220"
                    align="center"
                ></el-table-column>
                <el-table-column
                    prop="charger"
                    label="审核教师"
                    width="160"
                    align="center"
                ></el-table-column>
                <el-table-column
                    prop="chargerPhone"
                    label="教师电话"
                    width="160"
                    align="center"
                ></el-table-column>
                <el-table-column
                    label="审核状态"
                    align="center"
                >
                    <template slot-scope="scope">
                        <el-tag
                            :type="statusType(scope.row.status)"
                            effect="plain"
                            :style="tagStyle(scope.row.status)"
                            class="status-tag"
                        >
                            {{ formatStatus(scope.row.status) }}
                        </el-tag>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <div class="pagination-section">
            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="page.page"
                :page-sizes="[10, 20, 30, 40]"
                :page-size="page.pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total"
                background
            ></el-pagination>
        </div>
    </div>
</template>

<script>
import { detailhistory } from "../../../api/studentweb/studentmanagement.js";
import Cookies from "js-cookie";

export default {
    name: "ApplicantHistory",
    data() {
        return {
            ApplicantHistory: [],
            total: 0,
            page: {
                page: 1,
                pageSize: 10,
                userId: "",
                roleId: ""
            }
        };
    },
    created() {
        this.page.userId = Cookies.get("userId");
        this.page.roleId = Cookies.get("roleId");
        this.detailHistory(this.page);
    },
    methods: {
        formatStatus(status) {
            return status === "已驳回" ? "已拒绝" : status;
        },
        statusType(status) {
            return "success";
        },
        tagStyle(status) {
            const styleMap = {
                "已同意": {
                    backgroundColor: '#e8f5e9',
                    borderColor: '#66bb6a',
                    color: '#2e7d32'
                },
                "待审核": {
                    backgroundColor: '#fff3e0',
                    borderColor: '#ffa726',
                    color: '#ef6c00'
                },
                "已拒绝": {
                    backgroundColor: '#ffebee',
                    borderColor: '#ef5350',
                    color: '#c62828'
                }
            };
            return styleMap[status] || {};
        },
        handleSizeChange(size) {
            this.page.pageSize = size;
            this.detailHistory(this.page);
        },
        handleCurrentChange(page) {
            this.page.page = page;
            this.detailHistory(this.page);
        },
        detailHistory(page) {
            detailhistory(page).then(resp => {
                this.ApplicantHistory = resp.data.resultData.data.map(item => {
                    return {
                        ...item,
                        status: item.status === "已驳回" ? "已拒绝" : item.status
                    };
                });
                this.total = resp.data.resultData.total;
            });
        }
    }
};
</script>

<style scoped>
.applicant-container {
    padding: 24px;
    height: 100vh;
    background: #f5f7fa;
    box-sizing: border-box;
}

/* 表格容器新增居中样式 */
.table-wrapper {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    overflow: hidden;
    margin: 0 auto;  /* 新增居中 */
    max-width: 1200px;  /* 新增最大宽度 */
}

.full-width-table {
    width: 100%;
    border-radius: 12px;
}

/* 以下为之前的美化样式 */
.header-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 16px;
}

.enhanced-btn {
    border-radius: 8px;
    padding: 12px 24px;
    background: linear-gradient(135deg, #409EFF, #3375ff);
    border: none;
    box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
}

.enhanced-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
}

.enhanced-btn .btn-text {
    font-weight: 600;
    letter-spacing: 0.5px;
    margin-right: 8px;
}

.enhanced-btn .el-icon-arrow-right {
    margin-left: 6px;
    font-weight: bold;
}

.header-title {
    display: flex;
    align-items: center;
    color: #606266;
    font-size: 18px;
    font-weight: 500;
}

.header-title i {
    margin-right: 12px;
    font-size: 24px;
    color: #409EFF;
}

.gradient-divider {
    margin: 18px 0;
    background: linear-gradient(90deg, rgba(64, 158, 255, 0.3), transparent);
    height: 2px;
}

.status-tag {
    font-weight: 500;
    letter-spacing: 0.5px;
    border-radius: 4px;
    transition: all 0.2s ease;
}

/deep/ .el-tag.el-tag--plain {
    background-color: inherit;
    border-width: 1px;
    border-style: solid;
    font-size: 14px !important;
}

/deep/ .table-header {
    background-color: #f8f9fa !important;
    color: #606266;
    font-weight: 600;
    font-size: 14px;
}

/deep/ .el-table__row {
    transition: all 0.3s ease;
}

/deep/ .el-table__row:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

/deep/ .el-table::before {
    height: 0 !important;
}

.pagination-section {
    margin-top: 24px;
    display: flex;
    justify-content: flex-end;
    background: white;
    padding: 16px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

@media (max-width: 768px) {
    .applicant-container {
        padding: 12px;
    }

    .table-wrapper,
    .header-section,
    .pagination-section {
        border-radius: 8px;
        padding: 12px;
    }

    /deep/ .el-table__body-wrapper {
        overflow-x: auto;
    }

    .enhanced-btn {
        width: 100%;
        margin-bottom: 12px;
    }
}
</style>