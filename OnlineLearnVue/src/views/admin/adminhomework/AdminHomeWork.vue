<!--vue2+ElementUI
页面功能：管理员后台的作业管理列表页
通过cookie.get来验证管理员信息的（role）-->
<template>
    <div>
        <!--创建ElementUI的表格；用data：绑定表格数据源teacherData；
        再用default-sort：设置默认按发布时间descending（降序排序）ascending（升序）；
        固定列宽策略：优化长内容展示-->
        <el-table :data="TeacherData" :default-sort="{ prop: 'date', order: 'descending' }" style="width: 100%">
<!--            字段选择：展示作业标题、发布教师、班级等信息-->
            <el-table-column sortable fixed prop="title" label="作业标题">
            </el-table-column>
            <el-table-column prop="userName" label="发布教师" width="180">
            </el-table-column>
            <el-table-column prop="className" label="班级" width="100">
            </el-table-column>
            <el-table-column prop="subjectName" label="科目">
            </el-table-column>
            <el-table-column prop="createTime" label="发布时间">
            </el-table-column>
            <!--右侧的操作栏
            设置宽度为260px，并且强制性居右侧，利用slot-scope="scope"获取行数据-->
            <el-table-column label="操作" width="260" fixed="right">
                <template slot-scope="scope">
            <!-- type="primary" 是蓝色按钮，@click="handleEdit点击事件绑定
                scope.$index这个是行索引 scope.row行数据的标题
                             type="danger"是红色按钮预警-->
                    <el-button
                        type="primary" @click="handleEdit(scope.$index, scope.row)"> 查看</el-button>
                    <el-button type="danger" @click="handleDelete(scope.$index, scope.row)"> 删除</el-button>
                </template>
            </el-table-column>
        </el-table>
<!--        动态页码栏-->
<!--        @size-change="handleSizeChange"用于监听每页显示数量变化-->
<!--        @current-change="handleCurrentChange"用于监听当前页码变化-->
<!--        current-page="page.pageNum"显示当前的页码，如果非法输入就会重置-->
<!--        total显示总数, sizes分页下拉, prev上一页, pager页码按钮, next下一页, jumper跳转输入，小窗口自动隐藏-->
<!--        :total="TeacherData.length"计算总页数-->
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="page.pageNum"
            :page-sizes="[10, 20, 30, 40]" :page-size="page.pageSize" layout="total, sizes, prev, pager, next, jumper"
            :total="TeacherData.length">
        </el-pagination>
    </div>
</template>

<script>
// ahomework获取作业列表, deleteHomewor删除作业列表
import { ahomework, deleteHomewor } from "../../../api/admin/adminhomework.js";

export default {
    name: "AdminHomeWork",
    data() {
        return {
            TeacherData: [], //表格数据源
            page: {          //分页参数
                page: 1, //初始页
                pageSize: 10, //    每页的数据

            },
            param: {        //删除参数
                id: '',      //作业ID
            }
        }
    },

    //组件初始化，让用户能看到最新的作业列表，this.page是分页参数的对象
    created() {
        this.work(this.page)
    },
    // 跳转到作业详情，并携带当前行作业的内容
    methods: {
        handleEdit(index, row) {
            this.$router.push({
                name: 'HomeworkDetail',
                //用row.content作业内容当做参数传递
                params: {
                    data1: row.content
                }
            })
        },
        //删除制定作业，并刷新页面
        handleDelete(index, row) {
            this.param.id = row.id;   //删除作业的ID
            deleteHomewor(this.param).then(resp => {  //删除作业到调用指定得到接口
                if (resp.data.code == 200) {
                    this.$message({
                        message: '删除成功 ',  //显示成功
                        type: 'success'
                    });
                    this.work(this.page) //刷新页面
                } else {
                    this.$message.error('删除失败');  //显示删除失败
                }
            })
        },
        //用户切换每页显示条数的触发
        handleSizeChange(size) {
            this.page.pageSize = size;  //刷新每页条数
            this.work(this.page)         //重新加载数据
            console.log(`每页 ${size} 条`);
        },
        //用户切换页码时触发
        handleCurrentChange(pageNum) {
            this.page.pageNum = pageNum; //刷新页码
            this.work(this.page)        //重新加载
            console.log(`当前页: ${pageNum}`);
        },
       //用户加载作业列表数据
        work(page) {
            ahomework(page).then(resp => {  //调用ahomework的接口传入数据
                this.TeacherData = resp.data.resultData.data  //更新表格数据
                console.log(resp, '123') //调试输出
            })
        }
    },
}
</script>

<style scoped></style>