-- 字典表 --
CREATE TABLE sys_dictionary (
  dictionaryId    INT PRIMARY KEY AUTO_INCREMENT,
  parentId        INT          NOT NULL DEFAULT 0 COMMENT '父字典 id',
  dictionaryCode  VARCHAR(50)  NOT NULL COMMENT '字典 key',
  dictionaryValue VARCHAR(500) NULL COMMENT '字典值',
  dictionaryMemo  VARCHAR(200) NULL COMMENT '描述',
  dictionaryType  INT          NOT NULL DEFAULT 0 COMMENT '预留字典类型',
  displayOrder    INT          NOT NULL DEFAULT 0 COMMENT '排序, 数字越大越靠前'
) ENGINE = INNODB
  DEFAULT CHARSET = utf8
  COMMENT '系统字典表';

ALTER TABLE sys_dictionary
  ADD CONSTRAINT uk_dictionary_code UNIQUE (dictionaryCode);

ALTER TABLE sys_dictionary
  ADD INDEX ix_dictionary_type (dictionaryType),
  ADD INDEX ix_dictionary_parentId (parentId);

CREATE TABLE sys_region (
  regionId   INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
  parentId   INT UNSIGNED NOT NULL DEFAULT '1' COMMENT '父区域id',
  regionName VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '区域名称',
  regionType INT          NOT NULL DEFAULT '2' COMMENT '区域类型，0-中国、1-省、2-市、3-区、4-街道'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COMMENT ='区域表';

ALTER TABLE sys_region
  ADD INDEX ix_region_parentId (parentId),
  ADD INDEX ix_region_regionType (regionType);



# 快速录入
CREATE PROCEDURE insertDictionary(IN parentId0 INT, IN dictionaryCode0 VARCHAR(50), IN dictionaryValue0 VARCHAR(500))
BEGIN
  INSERT INTO sys_dictionary (parentId, dictionaryCode, dictionaryValue, dictionaryMemo, dictionaryType, displayOrder)
  VALUES (parentId0, dictionaryCode0, dictionaryValue0, '', 0, 0);
END;
CREATE PROCEDURE insertParentDictionary(IN dictionaryCode0 VARCHAR(50), IN memo0 VARCHAR(500))
BEGIN
  INSERT INTO sys_dictionary (parentId, dictionaryCode, dictionaryValue, dictionaryMemo, dictionaryType, displayOrder)
  VALUES (0, dictionaryCode0, NULL, memo0, 0, 0);
END;
