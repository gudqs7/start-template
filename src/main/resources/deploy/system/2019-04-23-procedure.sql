# 辅助函数: 分隔字符串
create function func_get_split_string (f_string nvarchar(1000), f_delimiter nvarchar(5), f_order int) returns nvarchar(255)
BEGIN
  -- Get the separated number of given string.
  declare result nvarchar(255) default '';
  set result = reverse(substring_index(reverse(substring_index(f_string,f_delimiter,f_order)),f_delimiter,1));
  return result;
END
;

# 辅助函数: 分隔字符后总数
create function func_get_split_string_total (f_string nvarchar(1000), f_delimiter nvarchar(5)) returns int
BEGIN
  -- Get the total number of given string.
  return 1+(length(f_string) - length(replace(f_string,f_delimiter,'')));
END
;


# 创建菜单函数
create procedure menuSimple (IN menuText nvarchar(100), IN menuUrl VARCHAR(100), IN urls VARCHAR(2000), IN parentId int, IN urlPrefix VARCHAR(100))
BEGIN
  declare authCount int default 0;
  declare i int default 0;
  DECLARE f_delimiter VARCHAR(5) DEFAULT ',';
  DECLARE menuId INT DEFAULT 0;
  SET f_delimiter=',';
  set authCount = func_get_split_string_total(urls,f_delimiter);
  INSERT INTO sys_menu (parentId, menuText, menuUrl, displayOrder, openType)
  VALUES (parentId,menuText,menuUrl,0,0);
  SELECT max(sys_menu.sysMenuId) INTO menuId FROM sys_menu;
  while i < authCount
  do
  set i = i + 1;
  INSERT INTO sys_auth (code, sysMenuId, method, url)
  VALUES (func_get_split_string(urls, f_delimiter, i), menuId, NULL, concat(urlPrefix, func_get_split_string(urls, f_delimiter, i)));
  end while;
END
;

# 创建顶级菜单函数
create procedure menuParent (IN menuText nvarchar(100), IN parentId int)
BEGIN
  DECLARE f_delimiter VARCHAR(5) DEFAULT ',';
  SET f_delimiter=',';
  INSERT INTO sys_menu (parentId, menuText, menuUrl, displayOrder, openType)
  VALUES (parentId,menuText,'',0,-1);
END
;

# 追加权限数据
CREATE PROCEDURE onlyAuth(IN menuId  INT, IN urls VARCHAR(2000), IN urlPrefix VARCHAR(100))
BEGIN
  declare cnt int default 0;
  declare i int default 0;
  DECLARE f_delimiter VARCHAR(5) DEFAULT ',';
  SET f_delimiter=',';
  set cnt = func_get_split_string_total(urls,f_delimiter);
  while i < cnt
  do
  set i = i + 1;
  INSERT INTO sys_auth (code, sysMenuId, method, url)
  VALUES (func_get_split_string(urls, f_delimiter, i), menuId, NULL, concat(urlPrefix, func_get_split_string(urls, f_delimiter, i)));
  end while;
END;

# 升级记录
CREATE PROCEDURE up(IN author NVARCHAR(50), IN memo NVARCHAR(200))
BEGIN
  INSERT INTO sys_update_record (author, recordMemo)
  VALUES (author, memo);
END;