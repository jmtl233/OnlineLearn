package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.rabbiter.ol.entity.VideosEntity;
import com.rabbiter.ol.vo.VideosVo;

import java.util.Map;

/**
 * 
 *
 * @author 
 * @email ${email}20
 * @date 
 */
//视频管理
public interface VideosService extends IService<VideosEntity> {

//分页查询视频列表
    Map<String, Object> queryPage(VideosVo videosVo);
}

