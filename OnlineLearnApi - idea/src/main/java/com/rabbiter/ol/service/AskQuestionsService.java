package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.AskQuestionsEntity;
import com.rabbiter.ol.vo.AskQuestionsVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//管理教师问答、学生问题查看、历史记录检索
//定义了一个名为 AskQuestionsService 的接口，继承自 IService<AskQuestionsEntity> 接口。
public interface AskQuestionsService extends IService<AskQuestionsEntity> {

    Map<String, Object> queryPage(AskQuestionsVo askQuestionsVo);
}

