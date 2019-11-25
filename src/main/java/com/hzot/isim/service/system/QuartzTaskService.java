package com.hzot.isim.service.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.entity.system.QuartzTask;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**
 * <p>
 * 定时任务 服务类
 * </p>
 *
 * @author system_user
 * @since 2018-01-24
 */
public interface QuartzTaskService extends IService<QuartzTask> {

    /**
     * 根据ID，查询定时任务
     */
    QuartzTask queryObject(String jobId);

    /**
     * 分页查询定时任务列表
     */
    Page<QuartzTask> queryList(EntityWrapper<QuartzTask> wrapper,Page<QuartzTask> page);

    /**
     * 保存定时任务
     */
    void saveQuartzTask(QuartzTask quartzTask);

    /**
     * 更新定时任务
     */
    void updateQuartzTask(QuartzTask quartzTask);

    /**
     * 批量删除定时任务
     */
    void deleteBatchTasks(List<String>  ids);

    /**
     * 批量更新定时任务状态
     */
    int updateBatchTasksByStatus(List<String> ids,Integer status);

    /**
     * 立即执行
     */
    void run(List<String> jobIds);

    /**
     * 暂停运行
     */
    void paush(List<String> jobIds);

    /**
     * 恢复运行
     */
    void resume(List<String> jobIds);
}
