package com.hzot.isim.service.impl.system;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hzot.isim.entity.system.QuartzTask;
import com.hzot.isim.service.system.QuartzTaskService;
import com.hzot.isim.util.Constants;
import com.hzot.isim.util.quartz.ScheduleUtils;
import com.hzot.isim.dao.system.QuartzTaskDao;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * <p>
 * 定时任务 服务实现类
 * </p>
 *
 * @author system_user
 * @since 2018-01-24
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class QuartzTaskServiceImpl extends ServiceImpl<QuartzTaskDao, QuartzTask> implements QuartzTaskService {

    @Autowired
    private Scheduler scheduler;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init(){
        EntityWrapper<QuartzTask> wrapper = new EntityWrapper<>();
        wrapper.eq("del_flag",false);
        List<QuartzTask> scheduleJobList = selectList(wrapper);
        for(QuartzTask scheduleJob : scheduleJobList){
            CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, scheduleJob.getId());
            //如果不存在，则创建
            if(cronTrigger == null) {
                ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
            }else {
                ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
            }
        }
    }

    @Override
    public QuartzTask queryObject(String jobId) {
        return baseMapper.selectById(jobId);
    }

    @Override
    public Page<QuartzTask> queryList(EntityWrapper<QuartzTask> wrapper, Page<QuartzTask> page) {
        return selectPage(page,wrapper);
    }

    @Override
    public void saveQuartzTask(QuartzTask quartzTask) {
        baseMapper.insert(quartzTask);
        ScheduleUtils.createScheduleJob(scheduler,quartzTask);
    }

    @Override
    public void updateQuartzTask(QuartzTask quartzTask) {
        baseMapper.updateById(quartzTask);
        ScheduleUtils.updateScheduleJob(scheduler,quartzTask);
    }

    @Override
    public void deleteBatchTasks(List<String> ids) {
        for(String id : ids){
            ScheduleUtils.deleteScheduleJob(scheduler, id);
        }
        deleteBatchIds(ids);
    }

    @Override
    public int updateBatchTasksByStatus(List<String> ids, Integer status) {
        List<QuartzTask> list = selectBatchIds(ids);
        for (QuartzTask task : list){
            task.setStatus(status);
        }
        updateBatchById(list);
        return 0;
    }

    @Override
    public void run(List<String> jobIds) {
        for(String jobId : jobIds){
            ScheduleUtils.run(scheduler, queryObject(jobId));
        }
    }

    @Override
    public void paush(List<String> jobIds) {
        for(String jobId : jobIds){
            ScheduleUtils.pauseJob(scheduler, jobId);
        }
        updateBatchTasksByStatus(jobIds, Constants.QUARTZ_STATUS_PUSH);
    }

    @Override
    public void resume(List<String> jobIds) {
        for(String jobId : jobIds){
            ScheduleUtils.resumeJob(scheduler, jobId);
        }

        updateBatchTasksByStatus(jobIds, Constants.QUARTZ_STATUS_NOMAL);
    }
}
