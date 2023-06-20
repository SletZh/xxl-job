package com.xxl.job.admin.dao;

import com.xxl.job.admin.core.conf.XxlJobAdminConfig;
import com.xxl.job.admin.core.model.XxlJobInfo;
import com.xxl.job.admin.core.model.XxlJobLogReport;
import com.xxl.job.admin.core.scheduler.MisfireStrategyEnum;
import com.xxl.job.admin.core.scheduler.ScheduleTypeEnum;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class XxlJobInfoDaoTest {
	private static Logger logger = LoggerFactory.getLogger(XxlJobInfoDaoTest.class);
	
	@Resource
	private XxlJobInfoDao xxlJobInfoDao;
	@Resource
	private XxlJobLogReportDao xxlJobLogReportDao;
	
	@Test
	public void pageList(){
		List<XxlJobInfo> list = xxlJobInfoDao.pageList(0, 20, 0, -1, null, null, null);
		int list_count = xxlJobInfoDao.pageListCount(0, 20, 0, -1, null, null, null);

		logger.info("", list);
		logger.info("", list_count);

		List<XxlJobInfo> list2 = xxlJobInfoDao.getJobsByGroup(1);
	}
	
	@Test
	public void save_load(){
		XxlJobInfo info = new XxlJobInfo();
		info.setJobGroup(1L);
		info.setJobDesc("desc");
		info.setAuthor("setAuthor");
		info.setAlarmEmail("setAlarmEmail");
		info.setScheduleType(ScheduleTypeEnum.FIX_RATE.name());
		info.setScheduleConf(String.valueOf(33));
		info.setMisfireStrategy(MisfireStrategyEnum.DO_NOTHING.name());
		info.setExecutorRouteStrategy("setExecutorRouteStrategy");
		info.setExecutorHandler("setExecutorHandler");
		info.setExecutorParam("setExecutorParam");
		info.setExecutorBlockStrategy("setExecutorBlockStrategy");
		info.setGlueType("setGlueType");
		info.setGlueSource("setGlueSource");
		info.setGlueRemark("setGlueRemark");
		info.setChildJobId("1");

		info.setAddTime(new Date());
		info.setUpdateTime(new Date());
		info.setGlueUpdatetime(new Date());

		int count = xxlJobInfoDao.save(info);

		XxlJobInfo info2 = xxlJobInfoDao.loadById(info.getId().intValue());
		info.setScheduleType(ScheduleTypeEnum.FIX_RATE.name());
		info.setScheduleConf(String.valueOf(44));
		info.setMisfireStrategy(MisfireStrategyEnum.FIRE_ONCE_NOW.name());
		info2.setJobDesc("desc2");
		info2.setAuthor("setAuthor2");
		info2.setAlarmEmail("setAlarmEmail2");
		info2.setExecutorRouteStrategy("setExecutorRouteStrategy2");
		info2.setExecutorHandler("setExecutorHandler2");
		info2.setExecutorParam("setExecutorParam2");
		info2.setExecutorBlockStrategy("setExecutorBlockStrategy2");
		info2.setGlueType("setGlueType2");
		info2.setGlueSource("setGlueSource2");
		info2.setGlueRemark("setGlueRemark2");
		info2.setGlueUpdatetime(new Date());
		info2.setChildJobId("1");

		info2.setUpdateTime(new Date());
		int item2 = xxlJobInfoDao.update(info2);

		xxlJobInfoDao.delete(info2.getId());

		List<XxlJobInfo> list2 = xxlJobInfoDao.getJobsByGroup(1);

		int ret3 = xxlJobInfoDao.findAllCount();

	}

	@Test
	public void save_report(){
		for (int i = 0; i < 3; i++) {

			// today
			Calendar itemDay = Calendar.getInstance();
			itemDay.add(Calendar.DAY_OF_MONTH, -i);
			itemDay.set(Calendar.HOUR_OF_DAY, 0);
			itemDay.set(Calendar.MINUTE, 0);
			itemDay.set(Calendar.SECOND, 0);
			itemDay.set(Calendar.MILLISECOND, 0);

			Date todayFrom = itemDay.getTime();

			itemDay.set(Calendar.HOUR_OF_DAY, 23);
			itemDay.set(Calendar.MINUTE, 59);
			itemDay.set(Calendar.SECOND, 59);
			itemDay.set(Calendar.MILLISECOND, 999);

			Date todayTo = itemDay.getTime();

			// refresh log-report every minute
			XxlJobLogReport xxlJobLogReport = new XxlJobLogReport();
			xxlJobLogReport.setTriggerDay(todayFrom);
			xxlJobLogReport.setRunningCount(0);
			xxlJobLogReport.setSucCount(0);
			xxlJobLogReport.setFailCount(0);

			Map<String, Object> triggerCountMap = XxlJobAdminConfig.getAdminConfig().getXxlJobLogDao().findLogReport(todayFrom, todayTo);
			if (triggerCountMap!=null && triggerCountMap.size()>0) {
				int triggerDayCount = triggerCountMap.containsKey("TRIGGERDAYCOUNT")?Integer.valueOf(String.valueOf(triggerCountMap.get("TRIGGERDAYCOUNT"))):0;
				int triggerDayCountRunning = triggerCountMap.containsKey("TRIGGERDAYCOUNTRUNNING")?Integer.valueOf(String.valueOf(triggerCountMap.get("TRIGGERDAYCOUNTRUNNING"))):0;
				int triggerDayCountSuc = triggerCountMap.containsKey("TRIGGERDAYCOUNTSUC")?Integer.valueOf(String.valueOf(triggerCountMap.get("TRIGGERDAYCOUNTSUC"))):0;
				int triggerDayCountFail = triggerDayCount - triggerDayCountRunning - triggerDayCountSuc;

				xxlJobLogReport.setRunningCount(triggerDayCountRunning);
				xxlJobLogReport.setSucCount(triggerDayCountSuc);
				xxlJobLogReport.setFailCount(triggerDayCountFail);
			}

			// do refresh
			int ret = XxlJobAdminConfig.getAdminConfig().getXxlJobLogReportDao().update(xxlJobLogReport);
			if (ret < 1) {
				XxlJobAdminConfig.getAdminConfig().getXxlJobLogReportDao().save(xxlJobLogReport);
			}
		}
	}

}
