package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.rabbiter.ol.entity.RoleEntity;
import com.rabbiter.ol.vo.RoleVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
public interface RoleService extends IService<RoleEntity> {


    Map<String, Object> queryPage(RoleVo roleVo);
}

