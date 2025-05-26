package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.rabbiter.ol.entity.UserSubjectEntity;
import com.rabbiter.ol.vo.UserSubjectVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//学科管理，包括新增、修改、删除、查询
public interface UserSubjectService extends IService<UserSubjectEntity> {
//分页查询用户学科关系
    Map<String, Object> queryPage(UserSubjectVo userSubjectVo);
}

