<template>
    <div class="applicant-container">
        <el-table
            :data="tableData"
            stripe
            style="width: 100%"
            class="applicant-table"
        >
            <el-table-column
                    prop="createTime"
                    label="创建日期"
                    width="180">
            </el-table-column>
            <el-table-column
                    sortable
                    prop="account"
                    label="账号">
            </el-table-column>
            <el-table-column
                    prop="userName"
                    label="姓名"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="studentPhone"
                    label="学生电话">
            </el-table-column>
            <el-table-column
                    prop="status"
                    label="状态">
            </el-table-column>
            <el-table-column
                    prop="charger"
                    label="审核人">
            </el-table-column>


            <el-table-column
                label="操作"
                width="260"
                fixed="right"
                align="center"
            >
                <template slot-scope="scope" v-if="scope.row.status === '待审核'">
                    <div class="action-buttons">
                        <el-button
                            type="success"
                            size="medium"
                            class="action-btn"
                            @click="handleEdit(scope.row)"
                        >
                            同意
                        </el-button>
                        <el-button
                            type="danger"
                            size="medium"
                            class="action-btn"
                            @click="handleDelete(scope.row)"
                        >
                            驳回
                        </el-button>
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
                :total="tableData.length">
        </el-pagination>

    </div>
</template>

<script>
    import {tapplicant,alertapplicant} from "../../api/teacher/teacherapplicant.js";
    import Cookies from 'js-cookie'
    export default {
        name: "TeacherApplicant",
        data(){
            return{
                tableData: [],
                page: {
                    page: 1, //初始页
                    pageSize: 10,    //    每页的数据
                    userId:'',
                },

                alertData:{},
                flag:true
            }
        },
        created() {
            this.page.userId=Cookies.get('userId')
            this.listUnApplicant(this.page)
            if(this.tableData.status=='待审核'){
                this.flag=false

            }
        },
        methods: {
            handleEdit(index,row){
                this.alertData=row
                this.alertData.status=2
                alertapplicant(this.alertData).then(resp=>{
                    if(resp.data.code==200){
                        this.$message({
                            message: '您已同意该学生加入您的班级',
                            type: 'success'
                        });
                        
                        this.listUnApplicant(this.page)
                    }else {
                        this.$message.error('新增失败');
                    }
                })

            },

            handleDelete(index,row){
                this.alertData=row
                this.alertData.status=3
                alertapplicant(this.alertData).then(resp=>{
                    if(resp.data.code==200){
                        this.$message({
                            message: '您已驳回该学生加入您的班级',
                            type: 'success'
                        });
                        this.listUnApplicant(this.page)
                    }else {
                        this.$message.error('新增失败');
                    }
                })

            },

            handleSizeChange(size) {
            this.page.pageSize = size;
            // console.log(this.pageSize,'888')
            this.listUnApplicant(this.page)
            console.log(`每页 ${size} 条`);
        },
        handleCurrentChange(pageNum) {
            this.page.pageNum = pageNum;
            this.listUnApplicant(this.page)
            console.log(`当前页: ${val}`);
        },

        listUnApplicant(page) {
            tapplicant(page).then(resp => {
                this.tableData = resp.data.resultData.data
                console.log(this.tableData)
            })
        },
        }
    }
</script>

<style scoped>
.applicant-container {
    padding: 20px;
}

.action-buttons {
    display: flex;
    justify-content: space-around;
    align-items: center;
}

.action-btn {
    width: 100px;
    height: 36px;
    font-size: 14px;
    border-radius: 4px;
    transition: all 0.2s ease;
}

.action-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

/* 保持按钮激活状态的一致性 */
.action-btn:active {
    transform: translateY(0);
    box-shadow: none;
}

/* 响应式调整 */
@media (max-width: 768px) {
    .action-btn {
        width: 80px;
        font-size: 13px;
    }
}
</style>