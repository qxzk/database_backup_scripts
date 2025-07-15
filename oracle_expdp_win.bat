@REM 名称：oracle_expdp_win.bat
@REM 作者：xzqv
@REM 描述：用于Windows Server系统上的Oracle数据库备份，
@REM 在是使用脚本前需要在Oracle数据库中创建directory，
@REM 创建directory的方法如下：
@REM CONN / AS SYSDBA
@REM CREATE OR REPLACE DIRECTORY DMPDIR AS '服务器实际存放备份数据的绝对路径';
@REM GRANT READ, WRITE ON DIRECTORY DMPDIR TO public;

@echo off

@REM 设置客户端字符集，与数据库字符集保持一致
set NLS_LANG=AMERICAN_AMERICA.UTF8

@REM 设置所需备份数据的用户名
set USERNAME=oe

@REM 设置所需要备份数据的用户密码
set PASSWORD=oe

@REM 设置Oracle数据库的实例名称
set INSTANCE_NAME=xzqv

@REM 设置导出数据schema的名称
@REM set SCHEMA_NAME=oe

@REM 设置Oracle数据库指定的数据导出目录
set ORACLE_DIRECTORY=DMPDIR

@REM 设置备份文件和备份日志调用的日期
@REM 时间格式：20250715，表示2025年7月15日
set BACKUP_DATE=%date:~0,4%%date:~5,2%%date:~8,2%

@REM 设置备份文件和备份日志调用的时间-时
@REM 时间格式：145058，表示14点
@REM 一天有多次备份需求，把这个参数添加到%BACKUP_DATE%的后面
set BACKUP_TIME1=%time:~0,2%

@REM 设置备份文件和备份日志调用的时间-时分
@REM 时间格式：145058，表示14点50分
@REM 一天有多次备份需求，把这个参数添加到%BACKUP_DATE%的后面
set BACKUP_TIME2=%time:~0,2%%time:~3,2%

@REM 设置备份文件和备份日志调用的时间-时分秒
@REM 时间格式：145058，表示14点50分58秒
@REM 一天有多次备份需求，把这个参数添加到%BACKUP_DATE%的后面
set BACKUP_TIME3=%time:~0,2%%time:~3,2%%time:~6,2%

@REM 备份全库数据，包括所有用户（Schema）、表空间、表、索引、存储过程等元数据和数据
expdp %USERNAME%/%PASSWORD%@%INSTANCE_NAME% directory=%ORACLE_DIRECTORY% dumpfile=%INSTANCE_NAME%-full-%BACKUP_DATE%%BACKUP_TIME2%.dmp logfile=%INSTANCE_NAME%-full-%BACKUP_DATE%%BACKUP_TIME2%.log full=y

@REM 备份指定的用户（schema）数据
@REM expdp %USERNAME%/%PASSWORD%@%INSTANCE_NAME% directory=%ORACLE_DIRECTORY% dumpfile=%INSTANCE_NAME%-%SCHEMA_NAME%-%BACKUP_DATE%%BACKUP_TIME2%.dmp logfile=%INSTANCE_NAME%-%SCHEMA_NAME%-%BACKUP_DATE%%BACKUP_TIME2%.log schemas=%SCHEMA_NAME%

@echo %INSTANCE_NAME%数据库备份已完成。
