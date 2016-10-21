CREATE DATABASE if not exists lab6_zhangr4;
use lab6_zhangr4;

CREATE FUNCTION if not exists Strip as "Strip"
USING JAR 'hdfs:///user/hive/Lab6_Input/Lab6_Hive-0.0.1-SNAPSHOT.jar';

drop table if exists doc;

CREATE TABLE doc(
  line string
)
STORED AS TEXTFILE;


load data inpath 'hdfs:///user/hive/Lab6_Input/testFile.txt' overwrite into table doc;

select * from doc;

create table word_count as
SELECT Strip(word), COUNT(*) FROM doc LATERAL VIEW explode(split(line, ' ')) lTable as word GROUP BY word;

select * from word_count;



