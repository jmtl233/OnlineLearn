package com.rabbiter.ol.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.rabbiter.ol.entity.ApplicantEntity;
import com.rabbiter.ol.vo.ApplicantVo;

import java.util.Map;
//映射数据库表 applicant 的实体类，表示“申请人”数据模型
/**
 * 
 *
 * @author 
 * @email ${email}
 * @date 
 */
//处理学生申请加入班级、管理申请状态、通过分页能力
//定义了一个名为 ApplicantService 的接口，继承自 IService<ApplicantEntity> 接口。
public interface ApplicantService extends IService<ApplicantEntity> {
//定义了一个名为 queryPage 的方法，接受一个 ApplicantVo 对象作为参数，返回一个 Map<String, Object> 对象。
    Map<String, Object> queryPage(ApplicantVo applicantVo);
}

