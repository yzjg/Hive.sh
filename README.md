# Hive.sh
# 场景：
     1.在Mysql数据库有emp表的，不直接使用Mysql进行统计的
     2.而是先将Mysql中的emp表通过sqoop框架抽取到Hive中的
     3.然后使用Hive进行统计分析的
     4.最终的结果通过sqoop框架导出到Mysql表中的
    
# 流程分析：
      1.在Hive中先创建一张emp对应的表：emp_m_to_h，代表是从Mysql中导入到Hive表中的数据的
      2.使用sqoop将Mysql中的emp表导入到Hive的表中的，emp_m_to_h
      3.创建Hive表的：result_h_to_m代表从Hive中导出到Mysql的结果数据
      4.在Hive中进行统计分析，每个部门有多少个人，然后将结果写入到Hive结果表中的额：result_h_to_m
      5.在Mysql中，创建表：result_a代表最终的计算结果
      6.将Hive结果表通过Sqoop导出到Mysql表中的:result_a






































