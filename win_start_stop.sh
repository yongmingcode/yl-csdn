echo "
请注意：
	1.该脚本文件为windows下可执行的脚本文件
	2.该脚本文件需放在项目根目录下执行
	3.执行该脚本，即为轮询执行启动和停止程序
	4.如若无法执行，可先在电脑上安装GitBash，再执行本脚本
	"

pid=`ps -ef | grep java | grep -v grep | awk '{print $2}'`
if [ ${pid} ] 
then
    kill -9 ${pid}
    echo "已结束进程"
else
    echo "未运行"
    nohup java -jar ./target/yl-csdn.jar >/dev/null 2>&1 &
    echo "已运行，请访问http://127.0.0.1:9000/info"
fi
read
