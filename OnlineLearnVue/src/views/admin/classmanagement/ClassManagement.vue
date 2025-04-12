<template>
    <div>
        <el-button @click="handleAdd" type="primary">新增班级</el-button>

        <!-- 班级表单弹窗 -->
        <el-dialog
                :title="dialogTitle"
                :visible.sync="dialogFormVisible"
                @close="handleDialogClose">
            <el-form
                    :model="form"
                    :rules="rules"
                    ref="formRef"
                    label-width="120px">
                <el-form-item label="班级名称：" prop="className">
                    <el-input
                            v-model="form.className"
                            placeholder="请输入班级名称"
                            clearable></el-input>
                </el-form-item>
                <el-form-item label="班主任：" prop="userId">
                    <el-select
                            v-model="form.userId"
                            placeholder="请选择班主任"
                            clearable
                            filterable>
                        <el-option
                                v-for="teacher in teacherList"
                                :key="teacher.id"
                                :label="teacher.userName"
                                :value="teacher.id">
                        </el-option>
                    </el-select>
                </el-form-item>
            </el-form>

            <div slot="footer">
                <el-button @click="dialogFormVisible = false">取消</el-button>
                <el-button
                        type="primary"
                        @click="handleSubmit"
                        :loading="submitting">确定</el-button>
            </div>
        </el-dialog>

        <!-- 班级列表表格 -->
        <el-table
                :data="tableData"
                border
                stripe
                style="width: 100%"
                v-loading="loading">
            <el-table-column
                    prop="createTime"
                    label="创建时间"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="userName"
                    label="班主任"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="className"
                    label="班级名称">
            </el-table-column>

            <el-table-column
                    label="操作"
                    width="200"
                    fixed="right">
                <template v-slot="{row}">
                    <div class="action-buttons">
                        <el-button
                                type="primary"
                                size="mini"
                                class="btn-fix"
                                @click="handleEdit(row)">编辑</el-button>
                        <el-button
                                type="danger"
                                size="mini"
                                class="btn-fix"
                                @click="handleDelete(row)">删除</el-button>
                    </div>
                </template>
            </el-table-column>
        </el-table>

        <!-- 分页组件 -->
        <el-pagination
                class="pagination"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="pagination.page"
                :page-sizes="[10, 20, 30, 50]"
                :page-size="pagination.pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total">
        </el-pagination>
    </div>
</template>

<script>
import {
    listClass,
    deleteClass,
    listTeacher,
    saveClass,
    updateClass
} from '../../../api/admin/classmanagement.js'

export default {
    name: 'ClassManagement',
    data() {
        return {
            // 弹窗相关
            dialogFormVisible: false,
            dialogType: 'add', // add/edit
            submitting: false,

            // 表单数据
            form: {
                id: '',
                className: '',
                userId: null
            },

            // 验证规则
            rules: {
                className: [
                    { required: true, message: '请输入班级名称', trigger: 'blur' }
                ],
                userId: [
                    { required: true, message: '请选择班主任', trigger: 'change' }
                ]
            },

            // 教师列表
            teacherList: [],

            // 表格数据
            tableData: [],
            loading: false,

            // 分页
            pagination: {
                page: 1,
                pageSize: 10
            },
            total: 0
        }
    },

    computed: {
        dialogTitle() {
            return this.dialogType === 'add' ? '新增班级' : '编辑班级'
        }
    },

    created() {
        this.fetchData()
        this.fetchTeachers()
    },

    methods: {
        // 初始化数据
        async fetchData() {
            this.loading = true
            try {
                const res = await listClass({
                    page: this.pagination.page,
                    pageSize: this.pagination.pageSize
                })
                this.tableData = res.data.resultData.data
                this.total = res.data.resultData.total
            } finally {
                this.loading = false
            }
        },

        // 获取教师列表
        async fetchTeachers() {
            const res = await listTeacher({ roleId: 2 })
            this.teacherList = res.data.resultData
        },

        // 打开新增弹窗
        handleAdd() {
            this.dialogType = 'add'
            this.dialogFormVisible = true
        },

        // 打开编辑弹窗
        handleEdit(row) {
            this.dialogType = 'edit'
            this.form = {
                id: row.id,
                className: row.className,
                userId: row.userId
            }
            this.dialogFormVisible = true
        },

        // 提交表单
        async handleSubmit() {
            try {
                const valid = await this.$refs.formRef.validate()
                if (!valid) return

                this.submitting = true

                const payload = { ...this.form }
                if (this.dialogType === 'add') {
                    await saveClass(payload)
                    this.$message.success('新增成功')
                } else {
                    await updateClass(payload)
                    this.$message.success('修改成功')
                }

                this.dialogFormVisible = false
                this.fetchData()
            } catch (error) {
                console.error('操作失败:', error)
            } finally {
                this.submitting = false
            }
        },

        // 删除班级
        async handleDelete(row) {
            try {
                await this.$confirm('确定删除该班级吗？', '提示', {
                    type: 'warning'
                })

                await deleteClass({ id: row.id })
                this.$message.success('删除成功')
                this.fetchData()
            } catch (error) {
                if (error !== 'cancel') {
                    this.$message.error('删除失败')
                }
            }
        },

        // 分页处理
        handleSizeChange(pageSize) {
            this.pagination.pageSize = pageSize
            this.fetchData()
        },

        handleCurrentChange(page) {
            this.pagination.page = page
            this.fetchData()
        },

        // 弹窗关闭时重置表单
        handleDialogClose() {
            this.$refs.formRef.resetFields()
            this.form.id = ''
        }
    }
}
</script>

<style scoped>
.pagination {
    margin-top: 20px;
    text-align: right;
}

/* 添加按钮对齐样式 */
.action-buttons {
    display: flex;
    justify-content: space-around;
    align-items: center;
}
.btn-fix {
    flex: 1;
    margin-left: 5px;
    margin-right: 5px;
    min-width: 40px;  /* 根据实际情况调整 */
}
</style>