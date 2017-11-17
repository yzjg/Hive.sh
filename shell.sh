 #!/bin/bash
 #mysql emp ->hive emp_m_to_h -> use  hive  calculate   ->hive  result_h_to_m  ->mysql   result_a
 
 ETL_LOG=/opt/data/ETL/etl.log
 TODAY=`date`
 
 RUN_STR="
 ETL_LOG=/opt/data/ETL/etl.log
 TODAY=`date`
 mysql  -uroot   -proot  sqoop  -e  \"select  * from  emp  \"  
 hive  -e   \"create  table if  not  exists  emp_m_to_h  (
 empno int ,
 ename  string,
 job  string,
 mgr   string,
 hiredate  string,
 sal    double ,
 comm  double,
 deptno   int) row format delimited  fields  terminated   by  '\t'; \"
 
 
 sqoop  import   \  
 --connect  jdbc:mysql://localhost:3306/sqoop  \
 --username   root  --password  root  \
 --table  emp  \
 -m   1
 --hive-import  \
 --hive-table   emp_m_to_h  \
 --hive-overwrite   \
 --delete-target-dir   \
 --fields-terminated-by  '\t'
 
 
 hive  -e  \"create  table  if not exists  result_h_to_m (
 deptno int,
 sum_person  int
 ) row  format delimited  fields terminated  by '\t'  ;   \"
 
 
 hive  -e  \"insert  overwrite  table result_h_to_m  select  deptno,count(1)  as  sum_person  from  emp_m_to_h  group  by  deptno ;  \"
 
 mysql  -uroot  -proot sqoop  -e    \"drop  table  result_a; \"
 mysql   -uroot   -proot  sqoop  -e  \"create table result_a(deptno  int ,sum_person  int);\"
 
 sqoop export  \
 --connect  jdbc:mysql://localhost:3306/sqoop  \
 --username  root    --password   root  \
 --table  result_a  \
 -m   1  \
 --export-dir   /user/hive/warehouse/result_h_to_m   \
 --fields-terminated-by '\t'
 
     mysql  -uroot  -proot  sqoop  -e  \"select  *  from   result_a; \" >/opt/data/ETL/result_a
 
 "
 
 echo  $TODAY>>$ETL_LOG
 /bin/sh  -c "$RUN_STR" >>$$ETL_LOG
 echo  `date   +%Y/%m/%d-%H:%M:%H` ===  "success"  >>$ETL_LOG
 
 
 
 
 
 



























































