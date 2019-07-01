CREATE TABLE sys_user (
  sysUserId INT PRIMARY KEY AUTO_INCREMENT,
  loginName VARCHAR(50)  NOT NULL COMMENT '登录名',
  password  VARCHAR(50)  NOT NULL COMMENT '登录密码: md5(name+password)',
  nickName  VARCHAR(20)  NULL COMMENT '昵称',
  avatarUrl VARCHAR(500) NULL COMMENT '头像',
  status    INT          NOT NULL DEFAULT 1 COMMENT '状态: 0.禁用 1.启用'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '系统用户';

ALTER TABLE sys_user
  ADD CONSTRAINT uk_user_loginName UNIQUE (loginName);

INSERT INTO sys_user (loginName, password, nickName, avatarUrl)
VALUES ('admin', md5(concat('admin1')), '管理', '');


CREATE TABLE sys_role (
  sysRoleId INT PRIMARY KEY AUTO_INCREMENT,
  roleName  VARCHAR(50) NOT NULL COMMENT '角色名',
  status    INT         NOT NULL DEFAULT 1 COMMENT '状态: 0.禁用 1.启用'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '系统角色';

INSERT INTO sys_role (roleName, status)
VALUES ('admin', 1);

CREATE TABLE sys_user_role (
  sysUserId INT NOT NULL COMMENT '系统用户 id',
  sysRoleId INT NOT NULL COMMENT '角色 id'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '用户-角色关联表';

INSERT INTO sys_user_role (sysUserId, sysRoleId)
VALUES (1, 1);

CREATE TABLE sys_menu (
  sysMenuId    INT PRIMARY KEY AUTO_INCREMENT,
  parentId     INT          NULL COMMENT '父级',
  menuText     VARCHAR(50)  NOT NULL COMMENT '菜单标题',
  menuUrl      VARCHAR(200) NOT NULL COMMENT '菜单 url',
  displayOrder INT          NOT NULL DEFAULT 0 COMMENT '排序',
  openType     INT          NOT NULL DEFAULT 0 COMMENT '打开方式: -1.菜单 0.内部模块 1.iframe 2.新标签页 3.新窗口'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '系统菜单表';

CREATE TABLE sys_role_menu (
  sysRoleId INT NOT NULL,
  sysMenuId INT NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '角色-菜单关联表';

CREATE TABLE sys_auth (
  sysAuthId INT PRIMARY KEY AUTO_INCREMENT,
  sysMenuId INT          NOT NULL COMMENT '菜单 id',
  code      VARCHAR(50)  NOT NULL COMMENT '权限标识符',
  method    VARCHAR(20)  NULL COMMENT '请求方法',
  url       VARCHAR(200) NOT NULL COMMENT 'url 地址'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '权限表';

CREATE TABLE sys_role_auth (
  sysRoleId INT NOT NULL,
  sysAuthId INT NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '角色-权限关联表';

CREATE TABLE sys_update_record (
  recordId   INT PRIMARY KEY AUTO_INCREMENT,
  author     VARCHAR(50)  NOT NULL COMMENT '提交者',
  recordTime TIMESTAMP    NOT NULL COMMENT '升级时间',
  recordMemo VARCHAR(200) NOT NULL COMMENT '升级备注'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT '升级记录表';