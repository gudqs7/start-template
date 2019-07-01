CALL up('wq', '微信自动回复');

CREATE TABLE wechat_keyword (
  keywordId  INT PRIMARY KEY AUTO_INCREMENT,
  keyword    VARCHAR(200) NULL COMMENT '关键词',
  matchType  INT          NOT NULL DEFAULT 1 COMMENT '匹配方式: 1.完全等于 2.关键词包含用户输入 3.用户输入包含关键词',
  replyType  INT          NOT NULL DEFAULT 1 COMMENT '回复消息类型: 1.普通文本 2.可带小程序链接文本 3.图片 4.图文信息 5.小程序',
  replyData  VARCHAR(800) NULL COMMENT '回复内容, json 格式',
  updateTime TIMESTAMP    NOT NULL COMMENT '更新时间',
  status     INT          NOT NULL DEFAULT 0 COMMENT '0|1'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '公众号关键词回复表';

ALTER TABLE wechat_keyword
  ADD CONSTRAINT uk_wechat_keyword_matchType UNIQUE (keyword, matchType);

ALTER TABLE wechat_keyword
  ADD memo VARCHAR(50) NULL COMMENT '备注';