<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <title>YL-CSDN-MONITOR</title>
        <!-- 先引入 Vue -->
        <script src="https://unpkg.com/vue/dist/vue.js"></script>
        <!-- 引入 http-vue-loader -->
        <script src="https://unpkg.com/http-vue-loader"></script>
        <!-- 引入 axios -->
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

        <!-- ace styles -->
        <link rel="stylesheet" href="/static/assets/css/ace.min.css" />
        <link rel="stylesheet" href="/static/assets/css/ace-rtl.min.css" />
        <link rel="stylesheet" href="/static/assets/css/ace-skins.min.css" />
        <link rel="stylesheet" href="/static/assets/css/datepicker.css" />
        <link rel="stylesheet" href="/static/assets/css/bootstrap-timepicker.css" />

    </head>
    <body>
    <div class="page-content">
        <div class="page-header">
            <h1>
                YL-CSDN
                <small>
                    <i class="icon-double-angle-right"></i>
                    监控系统
                </small>
            </h1>
        </div>
        <div id="yl-csdn-monitor">
            <!--请求耗时&QPS-->
            <div class="col-sm-7 infobox-container" style="width: 450px">

                <div class="infobox infobox-pink  ">
                    <div class="infobox-data">
                        <span class="infobox-data-number">${time!'null'}</span>
                        <div class="infobox-content">请求耗时</div>
                    </div>
                </div>
                <div class="infobox infobox-red  ">
                    <div class="infobox-data">
                        <span class="infobox-data-number">${qps!'null'}</span>
                        <div class="infobox-content">QPS (<font color="red"> {{timeOfNow}} </font>)</div>
                    </div>
                </div>
            </div>

            <div class="hr hr32 hr-dotted"></div>

            <!--Headers-->
            <div class="col-sm-5" style="width: 600px;display: inline-block;">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter">
                            Headers
                        </h4>
                    </div>

                    <div class="widget-body"><div class="widget-body-inner" style="display: block;">
                            <div class="widget-main no-padding">
                                <table class="table table-bordered table-striped">
                                    <thead class="thin-border-bottom">
                                    <tr>
                                        <th>
                                            <i class="blue"></i>
                                            类别
                                        </th>

                                        <th>
                                            <i class="blue"></i>
                                            值
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <#list header? keys as key>
                                        <tr>
                                            <td>${key}</td>
                                            <td><font color="red">${header[key]}</font></td>
                                        </tr>
                                    </#list>
                                    </tbody>
                                </table>
                            </div><!-- /widget-main -->
                        </div></div><!-- /widget-body -->
                </div><!-- /widget-box -->
            </div>

            <!--Cookies-->
            <div class="col-sm-5" style="width: 600px;display: inline-block;float: right">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter">
                            <i class="icon-star orange"></i>
                            Cookies
                        </h4>
                    </div>

                    <div class="widget-body"><div class="widget-body-inner" style="display: block;">
                            <div class="widget-main no-padding">
                                <table class="table table-bordered table-striped">
                                    <thead class="thin-border-bottom">
                                    <tr>
                                        <th>
                                            <i class="blue"></i>
                                            类别
                                        </th>

                                        <th>
                                            <i class="blue"></i>
                                            内容
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>cookies: </td>
                                        <td><font color="red">${cookies!'null'}</font></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!-- /widget-main -->
                        </div></div><!-- /widget-body -->
                </div><!-- /widget-box -->
            </div>

            <div class="hr hr32 hr-dotted"></div>

            <!--JVM内存使用情况-->
            <div class="col-sm-5 class-table" style="width: 600px; display: inline-block">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter">
                            <i class="icon-star orange"></i>
                            JVM内存使用情况
                        </h4>
                        （<font color="red">{{timeOfNow}}</font>时，JVM内存使用情况：）
                        <div class="widget-toolbar">
                            <a href="#" data-action="collapse">
                                <i class="icon-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                    <div class="widget-body"><div class="widget-body-inner" style="display: block;">
                            <div class="widget-main no-padding">
                                <table class="table table-bordered table-striped">
                                    <thead class="thin-border-bottom">
                                    <tr>
                                        <th style="width: 360px">
                                            <i class="blue"></i>
                                            类别
                                        </th>

                                        <th style="width: 120px">
                                            <i class="blue"></i>
                                            使用率
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <tr>
                                        <td>OS启动时JVM初始化内存(Initial memory)</td>
                                        <td>{{initial}}</td>
                                    </tr>
                                    <tr>
                                        <td>JVM使用内存(Used heap memory)</td>
                                        <td>{{used}}</td>
                                    </tr>
                                    <tr>
                                        <td>JVM最大有效内存(Max heap memory)</td>
                                        <td>{{max}}</td>
                                    </tr>
                                    <tr>
                                        <td>保证JVM可用内存(Committed memory)</td>
                                        <td>{{committed}}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!-- /widget-main -->
                        </div></div><!-- /widget-body -->
                </div><!-- /widget-box -->
            </div>

            <!--磁盘使用率-->
            <div class="col-sm-5 class-table" style="width: 600px; display: inline-block; float: right">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter">
                            <i class="icon-star orange"></i>
                            磁盘使用率
                        </h4>
                        （<font color="red">{{timeOfNow}}</font>时，磁盘使用率：）
                        <div class="widget-toolbar">
                            <a href="#" data-action="collapse">
                                <i class="icon-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                    <div class="widget-body"><div class="widget-body-inner" style="display: block;">
                            <div class="widget-main no-padding">
                                <table class="table table-bordered table-striped">
                                    <thead class="thin-border-bottom">
                                    <tr>
                                        <th style="width: 360px">
                                            <i class="blue"></i>
                                            类别
                                        </th>

                                        <th style="width: 120px">
                                            <i class="blue"></i>
                                            使用率
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <tr>
                                        <td>总磁盘空间(Total space)</td>
                                        <td>{{total}}</td>
                                    </tr>
                                    <tr>
                                        <td>未分配磁盘空间(Free space)</td>
                                        <td>{{free}}</td>
                                    </tr>
                                    <tr>
                                        <td>可用磁盘空间(Usable space)</td>
                                        <td>{{usable}}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!-- /widget-main -->
                        </div></div><!-- /widget-body -->
                </div><!-- /widget-box -->
            </div>

            <!--CPU使用情况-->
            <div class="col-sm-5 class-table" style="width: 600px">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-flat">
                        <h4 class="lighter">
                            <i class="icon-star orange"></i>
                            CPU使用情况
                        </h4>
                        （<font color="red">{{timeOfNow}}</font>时，CPU使用情况：）
                        <div class="widget-toolbar">
                            <a href="#" data-action="collapse">
                                <i class="icon-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                    <div class="widget-body"><div class="widget-body-inner" style="display: block;">
                            <div class="widget-main no-padding">
                                <table class="table table-bordered table-striped">
                                    <thead class="thin-border-bottom">
                                    <tr>
                                        <th style="width: 360px">
                                            <i class="blue"></i>
                                            线程名称
                                        </th>

                                        <th style="width: 120px">
                                            <i class="blue"></i>
                                            线程状态
                                        </th>

                                        <th  style="width: 120px">
                                            <i class="blue"></i>
                                            占用cpu时长
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <tr v-for="(item, key) in jvmInfo">
                                        <td>{{item.threadName}} </td>
                                        <td>
                                            <span v-if="item.threadState === 'RUNNABLE'" class="label label-info arrowed-right arrowed-in">{{item.threadState}}</span>
                                            <span v-if="item.threadState === 'WAITING'" class="label label-success arrowed-in arrowed-in-right">{{item.threadState}}</span>
                                            <span v-if="item.threadState === 'TIMED_WAITING'" class="label label-warning arrowed arrowed-right">{{item.threadState}}</span>
                                            <span v-if="item.threadState === 'BLOCKED'" class="label label-danger arrowed">{{item.threadState}}</span>
                                            <span v-if="item.threadState === 'TERMINATED'" class="label arrowed">{{item.threadState}}</span>
                                            <span v-if="item.threadState === 'NEW'" >{{item.threadState}}</span>
                                        </td>
                                        <td>{{item.cpuTime}} </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!-- /widget-main -->
                        </div></div><!-- /widget-body -->
                </div><!-- /widget-box -->
            </div>

        </div>
    </div>
    <script>
        var app = new Vue({
            el: '#yl-csdn-monitor',
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
                this.timer = setInterval(this.doTimer, 1000);
                setInterval(this.getInfo, 2000);
            },
            methods: {
                getInfo: function () {
                    let _this = this;
                    let url = "http://127.0.0.1:9000/jvminfo";
                    axios({
                        method: 'get',
                        url: url
                    }).then(function (resp) {
                        if(resp.status === 200){
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
                doTimer: function(){
                    let _this = this;
                    _this.timeOfNow = _this.formatDateTime();
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
    <style lang="less">
        .table thead tr {
            text-align: left;
        }
        .class-table {
            width: 600px;
        }
    </style>
</html>