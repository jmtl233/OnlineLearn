package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.HomeworkEntity;
import com.rabbiter.ol.vo.HomeworkVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//作业管理、作业发布与截止时间管理、作业批改、成绩统计
public interface HomeworkService extends IService<HomeworkEntity> {

//分页查询作业列表
    Map<String, Object> queryPage(HomeworkVo homeworkVo);
//查询学生未提交的作业
    Map<String, Object> findNotDoHomework(HomeworkVo homeworkVo);

}

