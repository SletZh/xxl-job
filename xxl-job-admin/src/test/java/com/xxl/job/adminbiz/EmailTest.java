package com.xxl.job.adminbiz;

import com.xxl.job.admin.XxlJobAdminApplication;
import com.xxl.job.admin.core.alarm.impl.EmailJobAlarm;
import com.xxl.job.admin.core.conf.XxlJobAdminConfig;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.MimeMessage;

/**
 * @author ZhangYuKun
 * @date 2023-6-3
 */
@SpringBootTest(classes = XxlJobAdminApplication.class)
public class EmailTest {
    private static Logger logger = LoggerFactory.getLogger(EmailJobAlarm.class);


    @Test
    public void test(){
        // make mail
        try {
            MimeMessage mimeMessage = XxlJobAdminConfig.getAdminConfig().getMailSender().createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setFrom(XxlJobAdminConfig.getAdminConfig().getEmailFrom(), "itos-zhangyk@alltrust.com.cn");
            helper.setTo("itos-zhangyk@alltrust.com.cn");
            helper.setSubject("111");
            helper.setText("111", true);

            XxlJobAdminConfig.getAdminConfig().getMailSender().send(mimeMessage);
        } catch (Exception e) {
            logger.error(">>>>>>>>>>> xxl-job, job fail alarm email send error, JobLogId:{}", 111, e);
        }

    }
}
