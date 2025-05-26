package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.KnowledgePointEntity;
import com.rabbiter.ol.vo.KnowledgePointVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
public interface KnowledgePointService extends IService<KnowledgePointEntity> {

    Map<String, Object> queryPage(KnowledgePointVo knowledgePointVo);
}

