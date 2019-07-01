# 自动构建说明

## SQL 转 Model
运行项目, 访问 /admin/sql2bean.html, 按提示粘贴 SQL, 复制代码后,  
在此包下 (`cn.gudqs.generator`) 新建一个 `Java Class`, 将代码覆盖粘贴即可

> sql2bean.html 可带参数, 如 添加 `tip=1` 时, 将 comment 作为注释加到字段上, 同时添加 swagger 的 `ApiModelProperty`  
同时也可指定生成代码的包名 如 pkg=cn.gudqs.test

## Model 生成 mapper,service,controller,mapper xml
首先, 编辑 generator-config.properties 文件, 一般只需要修改 `generator.basepackage`  
然后 在终端 运行 `generator.sh` 或 `generator.bat` 即可

最后记得将 generator 下无用的 model 类删除