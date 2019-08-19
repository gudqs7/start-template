
## 项目架构
> Spring Boot + MyBatis + 通用 Mapper(插件) + Quartz + Logback + Maven 聚合项目 + Swagger + Lombok

## 使用技术
- spring boot  
- spring java mail sender  
- spring string redis  
- spring mvc rest controller  
- mybatis 
- mybatis-mapper  替换mybatis sqlSource 实现通用mapper
- jwt 生成 token 保护请求安全性

## 开发指南
#### 本地下载项目
##### 下载内部依赖 maven 方式
`pom.xml` 下已配置

##### 下载内部依赖: git 方式
```
https://github.com/gudqs-architecture/behind/tree/master/base  
访问并下载behind项目
```
> 下载后    
执行 ./install.sh

##### 下载项目 
``` 
https://github.com/gudqs-architecture/start-template
访问并下载项目
``` 

最后以maven方式打开, 启动`cn.gudqs.MainApplication` 的 main 方法即可

#### 本地调试
> 在 install 了父项目和主依赖项目后   
直接使用 `mvn spring-boot:run -Dspring-boot.run.profiles=dev` 即可启动  
也可 mvn install 生成 jar 包后, `java -jar -Dspring.profiles.active=dev xxx.jar`  
若使用 idea 则在 Edit RunConfiguration 中的 spring boot中 environment 下的program argument  
 填入 `--spring.profiles.active=dev`

#### 数据初始化
> 在 deploy/system 下, 依次执行, `system.sql`, `procedure.sql`, `all-menu.sql`  
然后 使用 application-dev 运行项目后, 访问  
 http://localhost:9797/admin/app/index.html?jump=userAuth/userAuth  
 登录(账号 admin 密码 1) 后进入角色授权, 勾选全部后刷新网页即可  
 

## 目录结构
```
.
├── generator-config.properties  #自动生成 配置文件
├── generator.bat                #自动生成脚本 (windows)
├── generator.jar                #自动生成 jar
├── generator.sh                 #自动生成脚本(Unix,Linux,macOS)
├── src
│   └── main
│       ├── java
│       │   └── cn
│       │       └── gudqs
│       │           ├── MainApplication.java  #应用入口
│       │           ├── business
│       │           │   └── test  # 增删改查 demo
│       │           ├── consts
│       │           │   └── RedisKeyConst.java  #Redis key 常量
│       │           ├── generator  #自动生成专用临时目录
│       │           │   └── readme
│       │           │       └── README.md #自动生成说明
│       │           ├── system
│       │           │   ├── annotation
│       │           │   │   └── IpLimit.java
│       │           │   ├── aop
│       │           │   │   └── IpLimitAop.java
│       │           │   ├── configuration
│       │           │   │   └── SwaggerConfiguration.java  #swagger 文档, 覆盖 system
│       │           │   └── interceptor
│       │           │       └── ApiTokenInterceptor.java   #api 拦截器, 覆盖 system
│       │           ├── task #定时任务
│       │           └── util
│       │               └── JwtUtil.java #具体 jwt 工具类, 定义密钥, 覆盖 system
│       └── resources
│           ├── application-dev.properties   #properties 放自定义属性, yml 放 spring 认识的如 db, redis 等
│           ├── application-prod.properties  # dev 开发; test 测试; prod 生产
│           ├── application-prod.yml
│           ├── application-test.properties
│           ├── application-test.yml
│           ├── application.properties
│           ├── application.yml
│           ├── deploy
│           │   ├── README.md    #脚本提交说明
│           │   ├── business
│           │   │   └── wq
│           │   │       └── 2019-04-23-demo.sql    #SQL 脚本提交示例
│           │   └── system      #系统脚本
│           │       ├── 1111-all-menu.sql       #所有菜单记录
│           │       ├── 1112-all-dictionary.sql #所有字典记录
│           │       ├── 2019-04-22-system.sql   #用户-角色-权限-菜单
│           │       ├── 2019-04-23-procedure.sql #辅助存储过程
│           │       └── 2019-05-06-sys-dictionary.sql #字典及行政区域表
│           ├── logback.xml           #日志配置
│           ├── mybatis-mapper
│           │   ├── admin  #用户-角色-权限-菜单
│           │   ├── common #字典及行政区域
│           │   └── test
│           │       └── WechatKeywordMapper.xml  # demo
│           └── static
│               └── admin
│                   └── app
│                       ├── index.html     #覆盖 system
│                       ├── index.js       #覆盖 system
│                       ├── webConfig.js   #覆盖 system
│                       └── wechatKeyword   #demo
│                           ├── edit.html   #编辑模态框 HTML
│                           ├── wechatKeyword.css  #css
│                           ├── wechatKeyword.html #html
│                           ├── wechatKeyword.js   #js
│                           └── wechatKeyword.json #权限管理 code 文字说明

```