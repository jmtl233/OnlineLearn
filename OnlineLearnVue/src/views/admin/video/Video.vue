<template>
  <el-upload
    class="upload-demo"
    action="/study/videos/uploadVideo"
    :data="{ userId: getUserId }"
    :before-upload="beforeUpload"
    :on-success="handleSuccess"
    :on-error="handleError"
    :show-file-list="false">
    <el-button type="primary">点击上传视频</el-button>
    <div slot="tip" class="el-upload__tip">支持MP4/AVI格式，大小不超过500MB</div>
  </el-upload>
</template>

<script>
export default {
  methods: {
    beforeUpload(file) {
      const isValidType = ['video/mp4', 'video/avi'].includes(file.type);
      const isLt500M = file.size / 1024 / 1024 < 500;
      
      if (!isValidType) {
        this.$message.error('只支持MP4/AVI格式!');
        return false;
      }
      if (!isLt500M) {
        this.$message.error('视频大小不能超过500MB!');
        return false;
      }
      return true;
    },
    handleSuccess(res) {
      if (res.code === 200) {
        this.$message.success('上传成功');
        this.$emit('upload-success', res.resultData.url);
      } else {
        this.$message.error(res.message || '上传失败');
      }
    },
    handleError(err) {
      this.$message.error(`上传失败：${err.message}`);
    }
  }
}
</script>



<img 
  :src="item.coverUrl" 
  @error="handleImageError" 
  alt="视频封面"
  class="cover-image"
>

<script>
methods: {
  handleImageError(e) {
    e.target.src = 'E:\\OnlineLearn\\OnlineLearnVue\\src\\assets.jpg'; // 添加默认封面
  }
}
</script>
