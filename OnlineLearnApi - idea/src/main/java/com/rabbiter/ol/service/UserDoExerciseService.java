package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.UserDoExerciseEntity;
import com.rabbiter.ol.vo.UserDoExerciseVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//试题管理：用户完成练习、查看历史记录、统计成绩
public interface UserDoExerciseService extends IService<UserDoExerciseEntity> {

//分页查询练习记录
    Map<String, Object> queryPage(UserDoExerciseVo userDoExerciseVo);
//更新练习成绩
    void updateScoreById(Integer id, Integer score);
}

