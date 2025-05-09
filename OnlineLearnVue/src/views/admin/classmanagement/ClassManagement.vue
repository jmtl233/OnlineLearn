<!--数据：初始化加载班级、教师列表，分页变化需要重新加载数据-->
<!--弹窗：通过tag标记区分新增和编辑，用同个弹窗-->
<!--表单效验：对班级名称和班主任选择做必填效验-->
<!--状态管理：用dialogFormVisible来控制弹窗，form管理表单数据-->
<template>
    <div>
     <!-- 新增按钮触发对话框 -->
        <el-button  @click="saveNewClass()" type="primary"> 新增班级</el-button>
 <!-- 班级表单对话框 ，通过dialogFormVisible控制弹窗显示-->
        <el-dialog title="新增/编辑班级" :visible.sync="dialogFormVisible">
            <el-form :model="form">

                <el-form-item label="班级名称" :label-width="formLabelWidth">
                    <el-input v-model="form.className" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="班主任" :label-width="formLabelWidth">
                    <el-select v-model="form.userId" placeholder="请选择班主任">
                        <el-option v-for="c in form.allTeacher" :label="c.userName" :value="c.id" :key="c.id"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>

            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false"> 取 消</el-button>
                <el-button type="primary" @click="submit(form)"> 确 定</el-button>
            </div>
        </el-dialog>


<!--//班级列表表格，展示班级数据，可以排序和操作-->
        <el-table
                :data="tableData"
                :default-sort="{prop: 'date', order: 'descending'}"
                style="width: 100%">
<!--                //各列配置-->
            <el-table-column
                    sortable
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
                    label="班级">
            </el-table-column>

<!--//操作列（编辑和删除），scope.row获取当前的数据对象，fixed="right固定操作在右侧-->
            <el-table-column label="操作" width="260" fixed="right">
                <template slot-scope="scope">
                    <el-button
                            type="success"
                            @click="handleEdite(scope.$index, scope.row)"> 编辑
                    </el-button>
                    <el-button
                    type="danger"
                            @click="handleDelete(scope.$index, scope.row)"> 删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
<!--        //分页组件-->
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
    import {listClass,delteClass,listTeacher,saveClass,updateClass} from '../../../api/admin/classmanagement.js'
    export default {
        name: "ClassManagement",
        //数据对象data（）
        data(){
            return{
                dialogFormVisible:false,   //控制弹窗显示
                form:{
                    className:'',         //班级名称
                    userId:0,             //班主任ID
                    allTeacher:[],        //所有教师列表
                    id:'',                 //班级ID，编辑的时候启用
                },
                tableData:[],             //表格数据
                page: {
                    page: 1, //初始页
                    pageSize: 10,    //    每页的数据
                },
                param:{             //删除参数
                    id:'',
                },
                status:{
                    roleId:2      //查询教师条件，当roleID=2的时候是班主任
                },
                tag:'123',       //新增编辑
            }
        },//组件初始化
        created() {
            this.listAllClass(this.page)        // // 初始化班级列表
            this.listAllTeacher(this.status)     // 加载教师列表
        },
        methods:{
        //打开新增弹窗
            saveNewClass(){
                this.tag='new'    //标记为新增操作
               console.log(this.tag)
                this.dialogFormVisible=true  //显示弹窗

            },
            //编辑弹窗
            handleEdite(index,row){
                this.dialogFormVisible=true
                this.form.className=row.className   //回显班级名称
                this.form.userId=row.userName      //绑定班主任名称
                this.form.id=row.id       //记录班级ID
            },
              //提交表单，用tag区分新增和编辑调用不同的api
            submit(form){
                if(this.tag!='new'){    //编辑操作
                    if(typeof this.form.userId =="string"){
                        this.form.userId= ''
                    }
                    console.log(this.tag,'pppp')
                    this.dialogFormVisible=false
                    updateClass(form).then(resp=>{   //刷新列表
                        if(resp.data.code==200){

                            this.listAllClass(this.page)
                            this.$message({
                                message: '操作成功',
                                type: 'success'
                            });
                        }else {
                            this.$message.error('编辑失败');
                        }
                    })
                }else{  //新增操作
                    saveClass(form).then(resp=>{
                        this.dialogFormVisible=false
                        if(resp.data.code==200){
                            this.tag='123'
                            this.listAllClass(this.page)   //刷洗列表
                            this.$message({
                                message: '新增成功',
                                type: 'success'
                            });

                        }else {
                            this.$message.error('新增失败');
                        }
                    })
                }


            },


            listAllTeacher(status){
                listTeacher(status).then(resp=>{
                    this.form.allTeacher=resp.data.resultData
                })
            },
       //删除班级
            handleDelete(index,row){
                this.param.id=row.id
                delteClass(this.param).then(resp=>{
                    if(resp.data.code==200){
                        this.$message({
                            message: '删除成功',
                            type: 'success'
                        });
                        this.listAllClass(this.page)
                    }else {
                        this.$message.error('删除失败');
                    }
                })
            },
            listAllClass(page){
                listClass(page).then(resp=>{
                    this.tableData=resp.data.resultData.data
                })
            },
            //分页
            handleSizeChange(size) {
                this.page.pageSize = size;
                this.listAllClass(this.page)   //重新加载数据
                console.log(`每页 ${size} 条`);
            },
            handleCurrentChange(pageNum) {
                this.page.pageNum = pageNum;
                this.listAllClass(this.page)
                console.log(`当前页: ${val}`);
            },
        }
    }
</script>

<style scoped>

</style>