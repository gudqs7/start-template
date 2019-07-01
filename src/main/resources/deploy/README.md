
## 存储过程

### menuParent
```sql
CALL menuParent('常用', 0);
```
> 第一个参数是菜单名称, 第二个参数是父菜单 id : 0 表示顶级, 其他可用 ` (SELECT sysMenuId FROM sys_menu WHERE menuText = 'xxx')` 语句替代


### menuSimple
```sql

CALL menuSimple('系统用户管理', 'userManage/userManage',
                'find,update,add,delete', (SELECT sysMenuId FROM sys_menu WHERE menuText = '系统管理'), '/admin/user/');
```

```
作用: 创建菜单同时创建 其下一些权限

第一个参数是菜单名称
第二个参数是菜单路径, 省去 admin/app/ 前缀即可
第三个是权限code, 用逗号分隔, 同时也是 请求 url 的组成部分
第四个是父菜单 id
第五个是 权限 url 的前缀, 如 /admin/user/, /admin/role/, /admin/auth/ ...

最后权限 url 为 /admin/user/<code> , 如 /admin/user/find , /admin/user/add ...
```

### onlyAuth
```sql
CALL onlyAuth((SELECT sysMenuId FROM sys_menu WHERE menuText = '系统角色管理'), 'findBySysUserId', '/admin/role/');
```

```
作用: 未菜单追加权限

第一个参数是 菜单 id
第二个是权限code, 作用同 menuSimple 
第三个是 权限 url 的前缀, 作用同 menuSimple 
```

### up
```sql
CALL up('wq', '微信自动回复');
```

```
作用: 放在 SQL 脚本的头部, 记录脚本是否升级
第一个参数 提交者
第二个参数 脚本文件的描述  
```

## 脚本提交规范

> 若无特殊情况, 一律放在 `deploy/person/xxx` 下, xxx 为你的名称标识  
每个脚本文件头部需 调用 up 函数记录升级信息, 参考 `deploy/person/wq/2019-04-23-demo.sql`   
脚本文件命名一律时间开头, 描述结尾

