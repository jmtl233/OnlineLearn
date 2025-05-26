package com.rabbiter.ol.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.rabbiter.ol.common.Result;
import com.rabbiter.ol.entity.ApplicantEntity;
import com.rabbiter.ol.entity.UserClassEntity;
import com.rabbiter.ol.service.ApplicantService;
import com.rabbiter.ol.service.UserClassService;
import com.rabbiter.ol.vo.ApplicantVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


//状态流转机制 ：
//status 字段控制申请流程：
//1：待审批（默认）
//2：审批通过
//其他：拒绝/作废
//通过 joinTrueOrFalse 接口阻止重复申请
/**
 * @author 
 * @email ${email}
 * @date 
 */
@RestController
@RequestMapping("study/applicant")
public class ApplicantController {
    @Autowired//注入申请服务
    private ApplicantService applicantService;


    @Autowired//注入用户班级服务
    private UserClassService userClassService;

    /**
     * 分页查询申请列表
     */
    @RequestMapping("/list")
    public Result list(@RequestBody ApplicantVo applicantVo) {
        applicantVo.setPage((applicantVo.getPage() - 1) * applicantVo.getPageSize());//计算分页起始位置
        Map<String, Object> page = applicantService.queryPage(applicantVo);
        return Result.success(page);//返回查询结果
    }

    /**
     * 列表
     */
    //查询学生是否已经加入班级或待审核
    @RequestMapping("/joinTrueOrFalse")
    public Result joinTrueOrFalse(@RequestBody ApplicantVo applicantVo) {
        QueryWrapper<UserClassEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", applicantVo.getUserId());
        List<UserClassEntity> list = userClassService.list(queryWrapper);
    // 查询待审批申请（status=1表示待处理）
        List<ApplicantEntity> list1 = applicantService.list(new QueryWrapper<ApplicantEntity>().
                eq("user_id", applicantVo.getUserId())
                .eq("status", 1));
        return Result.success((list.size() + list1.size()) != 0);//存在返回true，不存在返回false
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Integer id) {
        ApplicantEntity applicant = applicantService.getById(id);
        return Result.success(applicant);
    }

    /**
     * 保存
     */
    //创建新的申请
    @RequestMapping("/save")
    public Result save(@RequestBody ApplicantEntity applicant) {

        applicant.setCreateTime(new Date(System.currentTimeMillis()));//设置申请创建时间为当前时间
        boolean save = applicantService.save(applicant);
        if (save) {
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 修改
     */
    //更新申请状态
    @RequestMapping("/update")
    public Result update(@RequestBody ApplicantVo applicantVo) {
        ApplicantEntity applicantEntity = new ApplicantEntity();
        applicantEntity.setStatus(applicantVo.getStatus());
        applicantEntity.setId(applicantVo.getId());
        boolean b = applicantService.updateById(applicantEntity);
        if (b) {//2是已经同意的
            if (applicantVo.getStatus() == 2) {
                QueryWrapper<UserClassEntity> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("user_id", applicantVo.getUserId());
                List<UserClassEntity> list = userClassService.list(queryWrapper);
                if (list.size() > 0) {
                    return Result.failure("该学生已经加入了班级");
                }//创建班级成员记录
                UserClassEntity userClassEntity = new UserClassEntity();
                userClassEntity.setClassId(applicantVo.getClassId());
                userClassEntity.setUserId(applicantVo.getUserId());
                userClassService.save(userClassEntity);
            }
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody Integer[] ids) {
        applicantService.removeByIds(Arrays.asList(ids));
        return Result.successCode();
    }

}
