package com.rabbiter.ol.controller;

import java.util.Date;
import java.util.Map;


import com.rabbiter.ol.common.Result;
import com.rabbiter.ol.entity.AskQuestionsEntity;
import com.rabbiter.ol.service.AskQuestionsService;
import com.rabbiter.ol.vo.AskQuestionsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


/**
 * @author 
 * @email ${email}
 * @date 2024-02-12 00:24:21
 */
@RestController
@RequestMapping("study/askQuestions")
public class AskQuestionsController {
    @Autowired
    private AskQuestionsService askQuestionsService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public Result list(@RequestBody AskQuestionsVo askQuestionsVo) {
        askQuestionsVo.setPage((askQuestionsVo.getPage() - 1) * askQuestionsVo.getPageSize());
        Map<String, Object> page = askQuestionsService.queryPage(askQuestionsVo);
        return Result.success(page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Integer id) {
        AskQuestionsEntity askQuestions = askQuestionsService.getById(id);
        return Result.success(askQuestions);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public Result save(@RequestBody AskQuestionsEntity askQuestions) {
        askQuestions.setCreateTime(new Date());
        boolean save = askQuestionsService.save(askQuestions);
        if (save) {
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public Result update(@RequestBody AskQuestionsVo askQuestionsVo) {
        AskQuestionsEntity askQuestionsEntity = new AskQuestionsEntity();
        askQuestionsEntity.setStatus(askQuestionsVo.getStatus());
        askQuestionsEntity.setId(askQuestionsVo.getId());
        askQuestionsEntity.setRestore(askQuestionsVo.getRestore());
        boolean b = askQuestionsService.updateById(askQuestionsEntity);
        if (b) {
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody AskQuestionsEntity askQuestionsEntity) {
        boolean remove = askQuestionsService.removeById(askQuestionsEntity.getId());
        if (remove) {
            return Result.successCode();
        }
        return Result.failureCode();
    }

}
