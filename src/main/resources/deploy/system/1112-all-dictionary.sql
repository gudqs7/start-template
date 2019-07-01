-- 查询辅助
SELECT *
FROM sys_dictionary;

/*
添加数据字典说明
添加大项 使用 insert into 或者 call insertParentDictionary 都行
添加小项必须使用 call insertDictionary
 */

-- first init start --

-- 学历
CALL insertParentDictionary('EDUCATION', '学历');
CALL insertDictionary(( SELECT dictionaryId FROM sys_dictionary WHERE dictionaryCode = 'EDUCATION' ), 'EDUCATION_DZ', '大专');
CALL insertDictionary(( SELECT dictionaryId FROM sys_dictionary WHERE dictionaryCode = 'EDUCATION' ), 'EDUCATION_BENKE', '本科');
CALL insertDictionary(( SELECT dictionaryId FROM sys_dictionary WHERE dictionaryCode = 'EDUCATION' ), 'EDUCATION_YJS', '研究生');
CALL insertDictionary(( SELECT dictionaryId FROM sys_dictionary WHERE dictionaryCode = 'EDUCATION' ), 'EDUCATION_BOSHI', '博士');

-- first init end --

