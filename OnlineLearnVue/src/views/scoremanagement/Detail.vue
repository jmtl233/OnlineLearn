<template>
    <div style="overflow-y: auto; padding: 20px;">
        <el-form ref="form" :model="paramData" label-width="100px">
            <!-- 试卷基本信息 -->
            <div class="base-info">
                <el-form-item label="所属班级" prop="classId" required>
                    <el-select
                        v-model="paramData.classId"
                        filterable
                        placeholder="请选择班级"
                        style="width: 300px">
                        <el-option
                            v-for="item in queryCla"
                            :key="item.classId"
                            :label="item.className"
                            :value="item.classId"/>
                    </el-select>
                </el-form-item>

                <el-form-item :label="`${type}标题`" prop="title" required>
                    <el-input
                        v-model="paramData.title"
                        :placeholder="`请输入${type}标题`"
                        style="width: 400px"
                        clearable/>
                </el-form-item>

                <el-form-item label="考试时间" prop="examTime" required>
                    <el-date-picker
                        v-model="paramData.commitTime"
                        type="datetime"
                        value-format="yyyy-MM-dd HH:mm:ss"
                        placeholder="选择考试时间"
                        style="width: 300px"/>
                </el-form-item>

                <el-form-item label="考试时长" prop="duration" required>
                    <el-input-number
                        v-model="paramData.duration"
                        :min="30"
                        :max="300"
                        controls-position="right"
                        style="width: 150px"/>
                    <span style="margin-left: 10px; color: #666">分钟</span>
                </el-form-item>
            </div>

            <!-- 试题编辑区域 -->
            <div class="question-list">
                <div v-for="(question, index) in paramData.questions" :key="index" class="question-item">
                    <el-card shadow="hover">
                        <div class="question-header">
                            <span class="question-type">题目 {{ index + 1 }}</span>
                            <el-select
                                v-model="question.type"
                                placeholder="题型"
                                style="width: 150px; margin: 0 20px">
                                <el-option
                                    v-for="t in questionTypes"
                                    :key="t.value"
                                    :label="t.label"
                                    :value="t.value"/>
                            </el-select>

                            <el-input-number
                                v-model="question.score"
                                :min="1"
                                :max="50"
                                controls-position="right"
                                placeholder="分值"
                                style="width: 120px"/>

                            <el-button
                                class="delete-btn"
                                type="danger"
                                icon="el-icon-delete"
                                circle
                                @click="removeQuestion(index)"/>
                        </div>

                        <el-form-item label="题目内容" required>
                            <mavon-editor
                                v-model="question.content"
                                :subfield="false"
                                :autofocus="false"
                                style="margin: 10px 0;"
                                placeholder="请输入题目内容..."/>
                        </el-form-item>

                        <el-form-item label="参考答案" required>
                            <template v-if="question.type === 'choice'">
                                <div v-for="(opt, oIndex) in question.options" :key="oIndex" class="option-item">
                                    <el-radio v-model="question.answer" :label="String.fromCharCode(65 + oIndex)">
                                        {{ String.fromCharCode(65 + oIndex) }}.
                                    </el-radio>
                                    <el-input
                                        v-model="question.options[oIndex]"
                                        style="width: 300px; margin-left: 10px"/>
                                </div>
                                <el-button
                                    type="primary"
                                    size="mini"
                                    @click="addOption(question)">
                                    添加选项
                                </el-button>
                            </template>

                            <template v-else-if="question.type === 'blank'">
                                <el-input
                                    v-model="question.answer"
                                    placeholder="请输入填空答案"
                                    style="width: 400px"/>
                            </template>

                            <template v-else>
                                <mavon-editor
                                    v-model="question.answer"
                                    :subfield="false"
                                    :autofocus="false"
                                    style="margin: 10px 0;"
                                    placeholder="请输入参考答案..."/>
                            </template>
                        </el-form-item>
                    </el-card>
                </div>

                <div class="add-question">
                    <el-button type="primary" icon="el-icon-plus" @click="addQuestion">添加题目</el-button>
                </div>
            </div>

            <!-- 评分区域 -->
            <div class="scoring-area" v-if="check">
                <el-form-item label="评分">
                    <el-tooltip class="item" effect="dark" :content="mode == '已批改' ? '该作业已批改！' : '输入分数评分'" placement="top-start">
                        <el-input
                            :disabled="mode == '已批改'"
                            placeholder="请输入分数"
                            v-model="paramData.score"
                            style="width: 200px">
                        </el-input>
                    </el-tooltip>
                </el-form-item>

                <el-form-item label="备注">
                    <el-input
                        :disabled="mode == '已批改'"
                        type="textarea"
                        :rows="3"
                        placeholder="请输入备注"
                        v-model="paramData.remark"
                        style="width: 100%">
                    </el-input>
                </el-form-item>
            </div>

            <!-- 操作按钮 -->
            <div class="form-actions">
                <el-button type="danger" @click="out()">返回</el-button>
                <el-tooltip class="item" effect="dark" :content="mode == '已批改' ? '该作业已批改！' : '提交'" placement="top-start">
                    <el-button :disabled="mode == '已批改'" type="success" @click="addTest(paramData)">提交</el-button>
                </el-tooltip>
            </div>
        </el-form>
    </div>
</template>

<script>
import { pclass } from "../../api/admin/queryclass";
import { addt, saveHomework } from '../../api/teacher/test.js'
import Cookies from 'js-cookie'

export default {
    name: "Detail",
    data() {
        return {
            check: false,
            mode: 0,
            queryCla: [],
            paramData: {
                id: '',
                classId: '',
                title: '',
                content: '',
                commitTime: '',
                answer: '',
                creator: '',
                userId: '',
                score: 0,
                remark: "",
                duration: 60,
                questions: []
            },
            param: {
                userId: '',
            },
            tag: '',
            studenttag: '',
            type: "试题",
            questionTypes: [
                { value: 'choice', label: '选择题' },
                { value: 'blank', label: '填空题' },
                { value: 'essay', label: '问答题' }
            ]
        }
    },
    computed: {

    },
    created() {
        this.paramData.creator = Cookies.get("userId")
        this.param.userId = Cookies.get("userId")
        this.queryClass(this.param)
        this.type = this.$route.query.type
        this.tag = this.$route.params.data1
        this.check = this.$route.params.check
        if (this.$route.params.data2) {
            this.paramData.userId = this.$route.params.data2.userId
            this.paramData.id = this.$route.params.data2.homeworkId
            this.paramData.title = this.$route.params.data2.title
            this.paramData.content = this.$route.params.data2.content
            this.paramData.answer = this.$route.params.data2.answer
            this.paramData.commitTime = this.$route.params.data2.commitTime
            this.paramData.commitTime = this.$route.params.data2.completionTime
            this.paramData.classId = this.$route.params.data2.classId
            this.studenttag = this.$route.params.data4
            this.mode = this.$route.params.data2.mode
            this.paramData.remark = this.$route.params.data2.remark
            this.paramData.score = this.$route.params.data2.score

            // 如果有内容，创建一个默认题目
            if (this.paramData.content) {
                this.initQuestionsFromContent();
            }
        }

        // 如果没有题目，添加一个默认题目
        if (this.paramData.questions.length === 0) {
            this.addQuestion();
        }
    },
    methods: {
        out() {
            this.tag = this.$route.params.data1
            if (this.tag == 'homework') {
                console.log(this.tag, '888')
                this.$router.push('/classmanagement')
            } else {
                this.$router.push('/scoremanagment')
            }
        },
        queryClass(pa) {
            pclass(pa).then(resp => {
                this.queryCla = resp.data.resultData
            })
        },
        addTest(paramData) {
            // 将题目内容合并到content字段
            this.prepareDataForSubmit();

            this.tag = this.$route.params.data1
            if (this.tag == 'homework') {
                saveHomework(paramData).then(resp => {
                    if (resp.data.code == 200) {
                        this.$router.push("/classmanagement")
                        this.$message({
                            message: '发布成功',
                            type: 'success'
                        });
                    } else {
                        this.$message.error('发布失败');
                    }
                })
            } else {
                addt(paramData).then(resp => {
                    if (resp.data.code == 200) {
                        this.$router.push("/scoremanagment")
                        this.$message({
                            message: '发布成功',
                            type: 'success'
                        });
                    } else {
                        this.$message.error('发布失败');
                    }
                })
            }
        },
        // 添加新题目
        addQuestion() {
            this.paramData.questions.push({
                type: 'essay',
                content: '',
                answer: '',
                score: 10,
                options: ['', '', '', '']
            });
        },
        // 删除题目
        removeQuestion(index) {
            this.paramData.questions.splice(index, 1);
            if (this.paramData.questions.length === 0) {
                this.addQuestion();
            }
        },
        // 添加选项
        addOption(question) {
            if (!question.options) {
                question.options = [];
            }
            question.options.push('');
        },
        // 从现有内容初始化题目
        initQuestionsFromContent() {
            this.paramData.questions = [{
                type: 'essay',
                content: this.paramData.content,
                answer: this.paramData.answer,
                score: 100,
                options: []
            }];
        },
        // 准备提交数据
        prepareDataForSubmit() {
            // 如果使用了新的题目格式，需要将题目合并到content和answer字段
            if (this.paramData.questions && this.paramData.questions.length > 0) {
                let contentText = '';
                let answerText = '';

                this.paramData.questions.forEach((q, index) => {
                    contentText += `## 题目 ${index + 1}：${q.type === 'choice' ? '(选择题)' : q.type === 'blank' ? '(填空题)' : '(问答题)'}\n\n`;
                    contentText += q.content + '\n\n';

                    if (q.type === 'choice' && q.options) {
                        q.options.forEach((opt, i) => {
                            contentText += `${String.fromCharCode(65 + i)}. ${opt}\n`;
                        });
                    }

                    answerText += `## 题目 ${index + 1} 答案：\n\n`;
                    answerText += q.answer + '\n\n';
                });

                this.paramData.content = contentText;
                this.paramData.answer = answerText;
            }
        }
    }
}
</script>

<style scoped>
.el-input__inner {
    margin-top: 10px;
}

.el-textarea__inner {
    margin-top: 10px;
}

.base-info {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #f9f9f9;
    border-radius: 4px;
}

.question-list {
    margin-bottom: 30px;
}

.question-item {
    margin-bottom: 20px;
}

.question-header {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.question-type {
    font-weight: bold;
    font-size: 16px;
    margin-right: 15px;
}

.option-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.add-question {
    text-align: center;
    margin: 20px 0;
}

.scoring-area {
    margin-top: 20px;
    padding: 15px;
    background-color: #f9f9f9;
    border-radius: 4px;
}

.form-actions {
    margin-top: 20px;
    text-align: right;
    padding-bottom: 30px;
}

.delete-btn {
    margin-left: auto;
}
</style>