# yl-csdn
能力测试demo要求 1. 基本架构：jdk1.8 + springboot + (freemarker/velocity) + maven + git 2. 功能要求：         1. 提供一个url(http://127.0.0.1:9000/info)，可以查看当前请求的参数(包括post方式参数)、header、cookie、耗时信息。         2. 所有信息显示为一个html界面，样式不限，可自由发挥，能区分各类数据即可。可以使用vue生成更佳         3. 应用可以自服务，不需要借助外部tomcat等容器即可运行         4. 通过AOP的方式打印请求日志 3. 监控要求：可以通过url查看程序运行指标，包括jvm、qps等

# 运行方式

1.执行pack_project.sh 文件进行项目打包

2.运行&停止项目：

  2.1 windows环境下，执行win_start_stop.sh脚本
  
  2.2 linux环境下，执行linux_start_stop.sh脚本
