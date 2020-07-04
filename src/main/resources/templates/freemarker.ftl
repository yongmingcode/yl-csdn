<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <title>freemark</title>
        <!-- 先引入 Vue -->
        <script src="https://unpkg.com/vue/dist/vue.js"></script>
        <!-- 引入 http-vue-loader -->
        <script src="https://unpkg.com/http-vue-loader"></script>
        <!-- 引入 axios -->
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    </head>
    <body>
    <div id="freemarker">
        <div >
            <ul>
                <li>请求耗时： <font color="red">${time!'null'}</font></li>
                <li>cookies: <font color="red">${cookies!'null'}</font></li>
                <li>header: <br/>
                <#list header? keys as key>
                    ${key}: <font color="red">${header[key]}</font><br/>
                </#list>
                </li>
            </ul>
        </div>
        <div>
            <ul>
                <li>当前时间: <font color="red">{{timeOfNow}}</font>的内存使用率：</li>
                <li>QPS: <font color="red">${qps!'null'}</font></li>
            </ul>
            <ul>
                <li>当前时间: <font color="red">{{timeOfNow}}</font>的内存使用率：</li>
                <li>OS启动时JVM初始化内存(Initial memory): <font color="red">{{initial}}</font></li>
                <li>JVM使用内存(Used heap memory): <font color="red">{{used}}</font></li>
                <li>JVM最大有效内存(Max heap memory): <font color="red">{{max}}</font></li>
                <li>保证JVM可用内存(Committed memory): <font color="red">{{committed}}</font></li>
            </ul>
            <ul>
                <li>当前时间: <font color="red">{{timeOfNow}}</font>的磁盘使用率：</li>
                <li>总磁盘空间(Total space): <font color="red">{{total}}</font></li>
                <li>未分配磁盘空间(Free space): <font color="red">{{free}}</font></li>
                <li>可用磁盘空间(Usable space): <font color="red">{{usable}}</font></li>
            </ul>
        </div>
        <div>
            <ul>
                <li v-for="(item, key) in jvmInfo">
                    <i>{{item.threadName}} </i>
                    <i>{{item.threadState}} </i>
                    <i>{{item.cpuTime}} </i>
                </li>
            </ul>
        </div>
    </div>

    <script>
        var app = new Vue({
            el: '#freemarker',
            data: {
                timer: '',
                initial: '',
                used: '',
                max: '',
                committed: '',
                timeOfNow: '',
                total: '',
                free: '',
                usable: '',
                jvmInfo: []
            },
            created: function () {
                this.timer = setInterval(this.getInfo, 3000);
            },
            methods: {
                getInfo: function () {
                    var _this = this;
                    var url = "http://127.0.0.1:9000/jvminfo";
                    axios({
                        method: 'get',
                        url: url
                    }).then(function (resp) {
                        if(resp.status === 200){
                            _this.timeOfNow = _this.formatDateTime();

                            // 内存使用率
                            _this.initial = resp.data[0][0].initial;
                            _this.used = resp.data[0][0].used;
                            _this.max = resp.data[0][0].max;
                            _this.committed = resp.data[0][0].committed;


                            // CPU使用情况
                            _this.jvmInfo = resp.data[1];

                            // 磁盘使用率
                            _this.total = resp.data[2][0].total;
                            _this.free = resp.data[2][0].free;
                            _this.usable = resp.data[2][0].usable;

                        }
                    }).catch(function (error) {
                        return "exception=" + error;
                    });
                },
                formatDateTime: function () {
                    let date = new Date();
                    let y = date.getFullYear();
                    let MM = date.getMonth() + 1;
                    MM = MM < 10 ? "0" + MM : MM;
                    let d = date.getDate();
                    d = d < 10 ? "0" + d : d;
                    let h = date.getHours();
                    h = h < 10 ? "0" + h : h;
                    let m = date.getMinutes();
                    m = m < 10 ? "0" + m : m;
                    let s = date.getSeconds();
                    s = s < 10 ? "0" + s : s;
                    return y + "-" + MM + "-" + d + " " + h + ":" + m + ":" + s;
                }
            },
            beforeDestroy() {
                clearInterval(this.timer);
            }
        })
    </script>

    </body>
</html>