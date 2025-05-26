package com.rabbiter.ol.controller;

import java.util.Arrays;
import java.util.Map;


import com.rabbiter.ol.common.Result;
import com.rabbiter.ol.entity.RoleEntity;
import com.rabbiter.ol.service.RoleService;
import com.rabbiter.ol.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
//实现系统角色的增删改查和分页查询。

/**
 * @author 
 * @email ${email}
 * @date 
 */
@RestController
@RequestMapping("study/role")
public class RoleController {
    @Autowired
    private RoleService roleService;

    /**
     * 查询角色列表
     */
    @RequestMapping("/list")
    public Result list(@RequestBody RoleVo roleVo) {
        roleVo.setPage((roleVo.getPage() - 1) * roleVo.getPageSize());
        Map<String, Object> page = roleService.queryPage(roleVo);
        return Result.success(page);
    }


    /**
     * 查询角色列表
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Integer id) {
        RoleEntity role = roleService.getById(id);

        return Result.success(role);
    }

    /**
     * ​新增角色
     */
    @RequestMapping("/save")
    public Result save(@RequestBody RoleEntity role) {
        boolean save = roleService.save(role);
        if (save){
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 修改角色
     */
    @RequestMapping("/update")
    public Result update(@RequestBody RoleEntity role) {
        boolean b = roleService.updateById(role);
        if (b){
            return Result.successCode();
        }
        return Result.failureCode();
    }

    /**
     * 删除批量删除角色	
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody Integer[] ids) {
        roleService.removeByIds(Arrays.asList(ids));

        return Result.successCode();
    }

}
