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


### 5. 前端请求验证
在浏览器开发者工具中检查：
1. 网络请求是否返回404（路径错误）
2. 响应头是否包含正确的Content-Type（如图片类型）
3. 控制台是否有CORS错误（跨域问题）

### 常见问题排查流程：
1. 确认图片文件实际已上传到服务器目录
2. 检查文件权限（Windows需赋予IIS_USER/Everyone读写权限）
3. 直接访问图片URL测试（如 http://localhost:8080/file/imageFile/xxx.jpg）
4. 查看后端日志是否有文件保存异常

建议在前端显示封面时添加默认图片容错：
```vue
<img 
  :src="item.coverUrl" 
  @error="handleImageError" 
  alt="视频封面"
  class="cover-image"
>

<script>
methods: {
  handleImageError(e) {
    e.target.src = '/default-cover.jpg'; // 添加默认封面
  }
}
</script>
```