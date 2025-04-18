package com.rabbiter.ol.service.impl;

import com.rabbiter.ol.dao.UserDao;
import com.rabbiter.ol.entity.UserEntity;
import com.rabbiter.ol.service.UserService;
import com.rabbiter.ol.vo.LoginVo;
import com.rabbiter.ol.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;


@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserDao, UserEntity> implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public Map<String, Object> queryPage(UserVo userVo) {
        Integer total = userDao.queryCount(userVo);
        List<HashMap> data = userDao.queryData(userVo);
        Map<String, Object> result = new HashMap<>();
        result.put("total",total);
        result.put("data",data);
        return result;
    }

    @Override
    public List<HashMap> login(LoginVo loginVo) {
        List<HashMap> users = userDao.login(loginVo);
        return users;
    }

    @Override
    public Map<String, Object> findNotDoWork(UserVo userVo) {
        Integer total = userDao.findNotDoWorkCount(userVo);
        List<HashMap> data = userDao.findNotDoWorkData(userVo);
        Map<String, Object> result = new HashMap<>();
        result.put("total",total);
        result.put("data",data);
        return result;
    }

    @Override
    public Map<String, Object> findNotDoHomework(UserVo userVo) {
        Integer total = userDao.findNotDoHomeworkCount(userVo);
        List<HashMap> data = userDao.findNotDoHomeworkData(userVo);
        Map<String, Object> result = new HashMap<>();
        result.put("total",total);
        result.put("data",data);
        return result;
    }

    @Override
    public List<HashMap> findList(UserVo userVo) {
        List<HashMap> data = userDao.findList(userVo);
        return data;
    }
}