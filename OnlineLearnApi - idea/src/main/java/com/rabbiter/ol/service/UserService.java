package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.UserEntity;
import com.rabbiter.ol.vo.LoginVo;
import com.rabbiter.ol.vo.UserVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//用户管理
public interface UserService extends IService<UserEntity> {

//用户登录认证
    Map<String, Object> queryPage(UserVo userVo);
//查询未完成任务
    List<HashMap> login(LoginVo loginVo);

    Map<String, Object> findNotDoWork(UserVo userVo);

    Map<String, Object> findNotDoHomework(UserVo userVo);

    List<HashMap> findList(UserVo userVo);

}

