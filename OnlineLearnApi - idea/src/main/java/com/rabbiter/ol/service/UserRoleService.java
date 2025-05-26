package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.UserRoleEntity;
import com.rabbiter.ol.vo.UserRoleVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//用户--角色关系表
public interface UserRoleService extends IService<UserRoleEntity> {

//分页查询用户--角色关系
    Map<String, Object> queryPage(UserRoleVo userRoleVo);
}

