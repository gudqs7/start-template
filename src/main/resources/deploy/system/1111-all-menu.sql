-- 查询辅助
SELECT *
FROM sys_menu;

/*
添加菜单说明

每段代码使用 -- xxx start -- 开头
每段代码使用 -- xxx end -- 结尾

所有菜单权限添加若无特殊情况, 一律使用 存储过程, 使用方式参考 deploy/README.md
 */

-- first init start --
CALL menuParent('常用', 0);
CALL menuParent('系统管理', 0);

CALL menuSimple('系统用户管理', 'userManage/userManage',
                'find,update,add,delete', (SELECT sysMenuId FROM sys_menu WHERE menuText = '系统管理'), '/admin/user/');
CALL menuSimple('系统角色管理', 'userAuth/userAuth',
                'find,update,add,delete', (SELECT sysMenuId FROM sys_menu WHERE menuText = '系统管理'), '/admin/role/');

CALL onlyAuth((SELECT sysMenuId FROM sys_menu WHERE menuText = '系统角色管理'), 'findBySysUserId', '/admin/role/');

CALL menuSimple('微信关键词回复', 'wechatKeyword/wechatKeyword',
                'find', (SELECT sysMenuId FROM sys_menu WHERE menuText = '常用'), '/admin/wechat/keyword/');

CALL onlyAuth((SELECT sysMenuId FROM sys_menu WHERE menuText = '微信关键词回复'), 'add,update,delete', '/admin/wechat/keyword/');

CALL menuSimple('系统字典', 'sysDictionary/sysDictionary',
                'find,findParent,update,add,delete', (SELECT sysMenuId FROM sys_menu WHERE menuText = '系统管理'), '/admin/sys/dictionary/');

CALL menuSimple('行政区域', 'region/region',
                'find,update,add,delete', (SELECT sysMenuId FROM sys_menu WHERE menuText = '系统管理'), '/admin/sys/region/');

-- first init end --

