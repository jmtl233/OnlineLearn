package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.ExercisesEntity;
import com.rabbiter.ol.vo.ExercisesVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//习题管理、习题难度等级维护、学习练习进度、自动批改
public interface ExercisesService extends IService<ExercisesEntity> {
//定义了一个名为 queryPage 的方法，接受一个 ExercisesVo 对象作为参数，返回一个 Map<String, Object> 对象。
//分页查询习题列表
    Map<String, Object> queryPage(ExercisesVo exercisesVo);
//查询学习未完成的习题
    Map<String, Object> findNotDoExercises(ExercisesVo exercisesVo);
}

