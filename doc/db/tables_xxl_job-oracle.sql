/**
  oracle版本搭建
 */
CREATE TABLE XXL_JOB_INFO (
  ID NUMBER(11) NOT NULL,
  JOB_GROUP NUMBER(11) NOT NULL,
  JOB_DESC varchar(255) NOT NULL,
  ADD_TIME DATE ,
  UPDATE_TIME DATE ,
  AUTHOR varchar(64) ,
  ALARM_EMAIL varchar(255),
  SCHEDULE_TYPE varchar(50)  DEFAULT 'NONE',
  SCHEDULE_CONF varchar(128) ,
  MISFIRE_STRATEGY varchar(50) DEFAULT 'DO_NOTHING',
  EXECUTOR_ROUTE_STRATEGY varchar(50),
  EXECUTOR_HANDLER varchar(255),
  EXECUTOR_PARAM varchar(512),
  EXECUTOR_BLOCK_STRATEGY varchar(50),
  EXECUTOR_TIMEOUT NUMBER(11) DEFAULT '0',
  EXECUTOR_FAIL_RETRY_COUNT NUMBER(11)  DEFAULT '0',
  GLUE_TYPE varchar(50) NOT NULL,
  GLUE_SOURCE CLOB,
  GLUE_REMARK varchar(128),
  GLUE_UPDATETIME DATE,
  CHILD_JOBID varchar(255),
  TRIGGER_STATUS NUMBER(4) DEFAULT '0',
  TRIGGER_LAST_TIME NUMBER(13) DEFAULT '0',
  TRIGGER_NEXT_TIME NUMBER(13) DEFAULT '0',
  PRIMARY KEY (ID)
);
COMMENT ON COLUMN XXL_JOB_INFO.ID IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB_INFO.AUTHOR IS '作者';
COMMENT ON COLUMN XXL_JOB_INFO.ALARM_EMAIL IS '报警邮件';
COMMENT ON COLUMN XXL_JOB_INFO.SCHEDULE_TYPE IS '调度类型';
COMMENT ON COLUMN XXL_JOB_INFO.SCHEDULE_CONF IS '调度配置，值含义取决于调度类型';
COMMENT ON COLUMN XXL_JOB_INFO.MISFIRE_STRATEGY IS '调度过期策略';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_ROUTE_STRATEGY IS '执行器路由策略';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_HANDLER IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_PARAM IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_BLOCK_STRATEGY IS '阻塞处理策略';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_TIMEOUT IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN XXL_JOB_INFO.EXECUTOR_FAIL_RETRY_COUNT IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB_INFO.GLUE_TYPE IS 'GLUE类型';
COMMENT ON COLUMN XXL_JOB_INFO.GLUE_SOURCE IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB_INFO.GLUE_REMARK IS 'GLUE备注';
COMMENT ON COLUMN XXL_JOB_INFO.GLUE_UPDATETIME IS 'GLUE更新时间';
COMMENT ON COLUMN XXL_JOB_INFO.CHILD_JOBID IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN XXL_JOB_INFO.TRIGGER_STATUS IS '调度状态：0-停止，1-运行';
COMMENT ON COLUMN XXL_JOB_INFO.TRIGGER_LAST_TIME IS '上次调度时间';
COMMENT ON COLUMN XXL_JOB_INFO.TRIGGER_NEXT_TIME IS '下次调度时间';
CREATE TABLE XXL_JOB_LOG (
  ID NUMBER(20) NOT NULL,
  JOB_GROUP NUMBER(11) NOT NULL,
  JOB_ID NUMBER(11) NOT NULL,
  EXECUTOR_ADDRESS varchar(255),
  EXECUTOR_HANDLER varchar(255),
  EXECUTOR_PARAM varchar(512),
  EXECUTOR_SHARDING_PARAM varchar(20),
  EXECUTOR_FAIL_RETRY_COUNT NUMBER(11) DEFAULT '0',
  TRIGGER_TIME DATE,
  TRIGGER_CODE NUMBER(11) NOT NULL,
  TRIGGER_MSG VARCHAR2(3000),
  HANDLE_TIME DATE,
  HANDLE_CODE NUMBER(11) NOT NULL,
  HANDLE_MSG VARCHAR2(3000),
  ALARM_STATUS NUMBER(4) DEFAULT '0',
  PRIMARY KEY (ID)
);
COMMENT ON COLUMN XXL_JOB_LOG.ID IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB_LOG.JOB_ID IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB_LOG.EXECUTOR_ADDRESS IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN XXL_JOB_LOG.EXECUTOR_HANDLER IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB_LOG.EXECUTOR_PARAM IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB_LOG.EXECUTOR_SHARDING_PARAM IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN XXL_JOB_LOG.EXECUTOR_FAIL_RETRY_COUNT IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB_LOG.TRIGGER_TIME IS '调度-时间';
COMMENT ON COLUMN XXL_JOB_LOG.TRIGGER_CODE IS '调度-结果';
COMMENT ON COLUMN XXL_JOB_LOG.TRIGGER_MSG IS '调度-日志';
COMMENT ON COLUMN XXL_JOB_LOG.HANDLE_TIME IS '执行-时间';
COMMENT ON COLUMN XXL_JOB_LOG.HANDLE_CODE IS '执行-状态';
COMMENT ON COLUMN XXL_JOB_LOG.HANDLE_MSG IS '执行-日志';
COMMENT ON COLUMN XXL_JOB_LOG.ALARM_STATUS IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';

CREATE TABLE XXL_JOB_LOG_REPORT (
  ID NUMBER(11) NOT NULL,
  TRIGGER_DAY DATE UNIQUE,
  RUNNING_COUNT NUMBER(11) DEFAULT '0',
  SUC_COUNT NUMBER(11) DEFAULT '0',
  FAIL_COUNT NUMBER(11) DEFAULT '0',
  UPDATE_TIME DATE ,
  PRIMARY KEY (ID)
);
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.TRIGGER_DAY IS '调度-时间';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.RUNNING_COUNT IS '运行中-日志数量';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.SUC_COUNT IS '执行成功-日志数量';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.FAIL_COUNT IS '执行失败-日志数量';

CREATE TABLE XXL_JOB_LOGGLUE (
  ID NUMBER(11) NOT NULL,
  JOB_ID NUMBER(11) NOT NULL,
  GLUE_TYPE varchar(50),
  GLUE_SOURCE CLOB,
  GLUE_REMARK varchar(128) NOT NULL,
  ADD_TIME DATE ,
  UPDATE_TIME DATE ,
  PRIMARY KEY (ID)
);
COMMENT ON COLUMN XXL_JOB_LOGGLUE.JOB_ID IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB_LOGGLUE.GLUE_TYPE IS 'GLUE类型';
COMMENT ON COLUMN XXL_JOB_LOGGLUE.GLUE_SOURCE IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB_LOGGLUE.GLUE_REMARK IS 'GLUE备注';

CREATE TABLE XXL_JOB_REGISTRY (
  ID NUMBER(11) NOT NULL,
  REGISTRY_GROUP varchar(50) NOT NULL,
  REGISTRY_KEY varchar(255) NOT NULL,
  REGISTRY_VALUE varchar(255) NOT NULL,
  UPDATE_TIME DATE ,
  PRIMARY KEY (ID)
);
--DROP TABLE XXL_JOB_GROUP;
CREATE TABLE XXL_JOB_GROUP (
  ID NUMBER(11) NOT NULL,
  APP_NAME varchar(64) NOT NULL,
  TITLE varchar(255) NOT NULL,
  ADDRESS_TYPE NUMBER(4) DEFAULT '0',
  ADDRESS_LIST VARCHAR2(3000),
  UPDATE_TIME DATE ,
  PRIMARY KEY (ID)
);
COMMENT ON COLUMN XXL_JOB_GROUP.APP_NAME IS '执行器AppName';
COMMENT ON COLUMN XXL_JOB_GROUP.TITLE IS '执行器名称';
COMMENT ON COLUMN XXL_JOB_GROUP.ADDRESS_TYPE IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN XXL_JOB_GROUP.ADDRESS_LIST IS '执行器地址列表，多地址逗号分隔';

CREATE TABLE XXL_JOB_USER (
  ID NUMBER(11) NOT NULL,
  USERNAME varchar(50) NOT NULL UNIQUE ,
  PASSWORD varchar(50) NOT NULL,
  ROLE NUMBER(4) NOT NULL,
  PERMISSION varchar(255),
  PRIMARY KEY (ID)
);

COMMENT ON COLUMN XXL_JOB_USER.USERNAME IS '账号';
COMMENT ON COLUMN XXL_JOB_USER.PASSWORD IS '密码';
COMMENT ON COLUMN XXL_JOB_USER.ROLE IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN XXL_JOB_USER.PERMISSION IS '权限：执行器ID列表，多个逗号分割';

CREATE TABLE XXL_JOB_LOCK (
  LOCK_NAME varchar(50) NOT NULL,
  PRIMARY KEY (LOCK_NAME)
);
COMMENT ON COLUMN XXL_JOB_LOCK.LOCK_NAME IS '锁名称';

-- 创建序列
CREATE SEQUENCE SEQ_XXL_JOB_INFO_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;

CREATE SEQUENCE SEQ_XXL_JOB_LOG_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;

CREATE SEQUENCE SEQ_XXL_JOB_LOG_REPORT_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;

CREATE SEQUENCE SEQ_XXL_JOB_LOGGLUE_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;

CREATE SEQUENCE SEQ_XXL_JOB_REGISTRY_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;

CREATE SEQUENCE SEQ_XXL_JOB_GROUP_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;
CREATE SEQUENCE SEQ_XXL_JOB_USER_ID
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999999999999
    START WITH 1
    NOCYCLE
    CACHE 200;
--创建索引
CREATE INDEX IDX_XXL_JOB_LOG_TRIGGER_TIME ON XXL_JOB_LOG (TRIGGER_TIME) TABLESPACE YJXCLMDATATBS PARALLEL 4 ONLINE;
CREATE INDEX IDX_XXL_JOB_LOG_HANDLE_CODE ON XXL_JOB_LOG (HANDLE_CODE) TABLESPACE YJXCLMDATATBS PARALLEL 4 ONLINE;
CREATE INDEX IDX_XXL_JOB_REGISTRY_IGKV ON XXL_JOB_REGISTRY (REGISTRY_GROUP,REGISTRY_KEY,REGISTRY_VALUE) TABLESPACE YJXCLMDATATBS PARALLEL 4 ONLINE;


INSERT INTO XXL_JOB_GROUP(ID, APP_NAME, TITLE, ADDRESS_TYPE, ADDRESS_LIST, UPDATE_TIME) VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL, SYSDATE);
INSERT INTO XXL_JOB_INFO(ID, JOB_GROUP, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, SCHEDULE_TYPE, SCHEDULE_CONF, MISFIRE_STRATEGY, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE,GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID) VALUES (202, 202, '测试任务1', SYSDATE, SYSDATE, 'XXL', '', 'CRON', '0 0 0 * * ? *', 'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', SYSDATE, '');
INSERT INTO XXL_JOB_USER(ID, USERNAME, PASSWORD, ROLE, PERMISSION) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO XXL_JOB_LOCK ( LOCK_NAME) VALUES ( 'schedule_lock');

