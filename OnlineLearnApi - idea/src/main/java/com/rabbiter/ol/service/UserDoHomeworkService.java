package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.UserDoHomeworkEntity;
import com.rabbiter.ol.vo.UserDoHomeworkVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//作业管理：提交状态、教师批改、学生成绩查看
public interface UserDoHomeworkService extends IService<UserDoHomeworkEntity> {

//分页查询作业提交记录
    Map<String, Object> queryPage(UserDoHomeworkVo userDoHomeworkVo);
//作业批改功能
    Boolean updateModeByUserId(String userId, String homeworkId,String score,String remark);

}

