<template>
    <div>
      <div class="layout-head">
          <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 10px;margin-left: 25px">室内地址:</div>
          <div class="shopaddress" style="float: left;">
              <el-select v-model="shopMap" style="width: 100px" @change="btn2">
                  <el-option v-for="(item, index) in indoordata"
                             :key="index"
                             :value="item.label"
                             :label="item.label">
                  </el-option>
              </el-select>
          </div>
          <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 0px;margin-left: 2px">刷新</el-button>
      </div>
      <div class="layout-head">
        <div style="float: left;margin-left: 25px;">
              <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 15px">日期:</div>
              <el-date-picker
                      style="z-index: 1;margin-right: 30px"
                      @change="changeday4"
                      v-model="value4"
                      align="right"
                      type="date"
                      placeholder="选择日期"
                      value-format="yyyy-MM-dd"
                      :picker-options="pickerOptions2">
              </el-date-picker>
        </div>
        <div style="float: left;margin-left: 350px;">
            <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 15px">日期:</div>
            <el-date-picker
                        style="z-index: 1;margin-right: 30px"
                        @change="changeday3"
                        v-model="value3"
                        align="right"
                        type="date"
                        placeholder="选择日期"
                        value-format="yyyy-MM-dd"
                        :picker-options="pickerOptions2">
            </el-date-picker>
        </div>
      </div>
        <div id="myChart2" style="width:500px;height:250px;float:left;margin-top: 10px;margin-left: 20px;"></div>
        <div id="myChart" style="width:450px;height:250px;float:left;margin-top: 10px;margin-left: 190px;"></div>
        <div id="myChart3" style="width:700px;height:250px;float:left;margin-top: 50px;margin-left: 300px;"></div>
    </div>
</template>

<script>
    export default {
        name: "ClassData",
        data () {
            return {
                time:null,
                indoordata:[],
                shopMap:'',

                value3: '',
                value4: '',
                value5: '',

                //圆环图
                myChart: '',
                opinion2: [],
                opinionData2:[],
                //opinionData2: [{ value: 1, name: '校园暴力行为' }, { value: 45, name: '正常行为' }, { value: 3, name: '睡觉行为'}, { value: 3, name: '玩手机行为'}],

                //柱状图
                myChart2:'',
                opinion: [],
                opinionData: [],
                opinionother:[],
                //opinion: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"],
                //opinionData: [5, 20, 36, 10, 10, 20],

                //折线图
                myChart3:'',
                saveopinion3: [],
                opinion3: [],
                opinionData3: [],
                //opinion3: ['近一次', '近两次', '近三次', '近四次'],
                //opinionData3: [50, 48, 52, 45],
                pickerOptions2: {
                    disabledDate (time) {
                        const one = 3 * 30 * 24 * 3600 * 1000
                        const minTime = Date.now() - one
                        return time.getTime() > Date.now() || time.getTime() < minTime
                    },
                    shortcuts: [{
                        text: '今天',
                        onClick (picker) {
                            picker.$emit('pick', new Date())
                        }
                    }, {
                        text: '昨天',
                        onClick (picker) {
                            const date = new Date()
                            date.setTime(date.getTime() - 3600 * 1000 * 24)
                            picker.$emit('pick', date)
                        }
                    }, {
                        text: '一周前',
                        onClick (picker) {
                            const date = new Date()
                            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7)
                            picker.$emit('pick', date)
                        }
                    }]},
                user:JSON.parse(window.sessionStorage.getItem("user"))
            }
        },
        mounted: function () {
            this.checkJurisdiction2 ()
            this.getdata()  //初始化时间
            console.log('value3值是:' + this.value3)
            console.log('value4值是:' + this.value4)
            setTimeout(() => {
             this.drawLine()
             this.drawLine2()
             this.drawLine3()
            }, 500);
        },
        methods: {

            btn2(){
                //this.checkJurisdiction2 ()
                this.getdata()  //初始化时间
                this.saveopinion3=[]
                this.opinion3=[]
                this.opinionData3=[]
                this.deleteRequest('/deleteAllCach',{}).then(resp => {
                })
                setTimeout(() => {
                 this.drawLine()
                 this.drawLine2()
                 this.drawLine3()
                }, 300);
            },
            checkJurisdiction2 () {   //返回地图列表
                this.indoordata=[]
                this.getRequest('/listMapMamageNoPage',{roledesc:this.user.roledesc,username:this.user.username}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].indoorname
                            this.indoordata.push(add)
                        }
                        if(this.indoordata.length!=0){
                            this.shopMap = this.indoordata[0].label
                        }
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },

            drawLine () {
                this.myChart = this.$echarts.init(document.getElementById('myChart'))

                this.getRequest('/listClassNoPage',{indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.addressdata=[]
                        this.opinion2=[]
                        this.opinionData2=[]
                        console.log('data是:' + resp.data)
                        for (let i = 0; i < resp.data.length; i++) {
                            //若是普通区域
                            if(resp.data[i].stopjudge!=1){
                                console.log('resp.data.adress是:' + resp.data[i].adress)
                                this.opinion2.push(resp.data[i].adress)
                            }
                        }
                        //获取每个区域所对应的数据
                        console.log('opinion2是:' + this.opinion2)
                        console.log('opinion2.length是:' + this.opinion2.length)

                        this.sortStoptime()

                        setTimeout(() => {
                            console.log('opinionData2值是:' + this.opinionData2)
                            // 指定图表的配置项和数据
                            let option = {
                                title: {
                                    text: '当天普通区域停留几率', // 主标题
                                    subtext: '', // 副标题
                                    x: 'left' // x轴方向对齐方式
                                },
                                grid: { containLabel: true },
                                tooltip: {
                                    trigger: 'item',
                                    formatter: '{a} <br/>{b} : {d}%'
                                },
                                legend: {
                                    orient: 'vertical',
                                    icon: 'circle',
                                    align: 'left',
                                    x: 'right',
                                    y: 'bottom',
                                    //data: ['校园暴力行为', '正常行为', '睡觉行为', '玩手机行为']
                                    data:this.opinion2
                                },
                                series: [
                                    {
                                        name: '当天普通区域停留几率',
                                        type: 'pie',
                                        radius: ['50%', '70%'],
                                        avoidLabelOverlap: false,
                                        center: ['40%', '50%'],
                                        data: this.opinionData2
                                    }
                                ]
                            }
                            // 3、展示数据
                            // 使用刚指定的配置项和数据显示图表。
                            this.myChart.setOption(option);
                        }, 2000);

                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            drawLine2(){
                // 1、基于准备好的dom，初始化echarts实例
                this.myChart2 = this.$echarts.init(document.getElementById('myChart2'))
                // 2、准备数据和配置项
                //获取区域列表
                this.getRequest('/listClassNoPage',{indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.addressdata=[]
                        this.opinion=[]
                        this.opinionData=[]
                        this.opinionother=[]
                        console.log('data是:' + resp.data)
                        for (let i = 0; i < resp.data.length; i++) {
                            //若是普通区域
                            if(resp.data[i].stopjudge!=1){
                                console.log('resp.data.adress是:' + resp.data[i].adress)
                                this.opinion.push(resp.data[i].adress)
                            }
                        }
                        //获取每个区域所对应的数据
                        console.log('opinion是:' + this.opinion)
                        console.log('opinion.length是:' + this.opinion.length)

                        this.sortVisit()

                        setTimeout(() => {
                            console.log('opinionData值是:' + this.opinionData)
                            // 指定图表的配置项和数据
                            let option = {
                                title: {
                                    text: '当天访问排行'
                                },
                                tooltip: {},
                                legend: {
                                    data:['被访问次数']
                                },
                                xAxis: {
                                    //data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
                                    data:this.opinionother
                                },
                                yAxis: {},
                                series: [{
                                    name: '被访问次数',
                                    type: 'bar',
                                    //data: [5, 20, 36, 10, 10, 20]
                                    data:this.opinionData
                                }]
                            }
                            // 3、展示数据
                            // 使用刚指定的配置项和数据显示图表。
                            this.myChart2.setOption(option);
                        }, 1500);

                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            drawLine3(){
                // 1、基于准备好的dom，初始化echarts实例
                this.myChart3 = this.$echarts.init(document.getElementById('myChart3'))

                // 2、准备数据和配置项
                this.getRequest('/listClassNoPage',{indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        //先清除定时器
                        if(this.timer!=null){
                            clearInterval(this.timer);　　// 清除定时器
                            this.timer = null;
                        }

                        this.opinion3=[]
                        this.addressdata=[]
                        console.log('data是:' + resp.data)
                        for (let i = 0; i < resp.data.length; i++) {
                            //若是普通区域
                            if(resp.data[i].stopjudge!=1){
                                console.log('resp.data.adress是:' + resp.data[i].adress)
                                this.opinion3.push(resp.data[i].adress)
                            }
                        }


                        //设置定时器，每5秒执行一次任务内容(实现定时刷新数据)
                        this.timer = setInterval( () => {
                            if(window.sessionStorage.getItem("user")!=null) {  //防止退出后仍然继续请求
                                this.opinionData3= []    //重新初始化
                                this.saveopinion3=[]
                                //this.opinion3=[]
                                this.sortNow()
                            }
                            setTimeout(() => {
                                console.log('opinionData3值是:' + this.opinionData3)
                                // 指定图表的配置项和数据
                                let option = {
                                    title: {
                                        text: '普通区域人数实时情况', // 主标题
                                        subtext: '', // 副标题
                                        x: 'left' // x轴方向对齐方式
                                    },
                                    tooltip: {
                                        trigger: 'axis' // axis   item   none三个值
                                    },
                                    xAxis: {
                                        type: 'category', // 还有其他的type，可以去官网喵两眼哦
                                        //data: ['近一次', '近两次', '近三次', '近四次', '近五次'], // x轴数据
                                        data:this.saveopinion3,
                                        name: '所在区域' // x轴名称
                                    },
                                    yAxis: {
                                        type: 'value',
                                        name: '实时人数' // y轴名称
                                    },
                                    legend: {
                                        orient: 'vertical',
                                        x: 'center',
                                        y: 'top',
                                        data: ['实时人数']
                                    },
                                    series: [
                                        {
                                            name: '实时人数',
                                            //data: [0, 0, 0],
                                            data:this.opinionData3,
                                            type: 'line'
                                        }
                                    ]
                                }
                                // 3、展示数据
                                // 使用刚指定的配置项和数据显示图表。
                                this.myChart3.setOption(option);
                                this.saveopinion3=[]

                            }, 1000);
                        }, 4000)
                    } else {
                        this.$message.error(resp.data);
                    }
                })

            },

            changeday3 () {
                console.log('value3值是:' + this.value3)
                this.opinion2= [],     //重新初始化
                this.opinionData2= [],
                this.drawLine()    //更改时间则重新画图
            },

            changeday4 () {
                console.log('value4值是:' + this.value4)
                this.opinion= [],     //重新初始化
                this.opinionData= [],
                this.drawLine2()    //更改时间则重新画图
            },

            getdata () {   //获取当前时间
                var aData = new Date()
                this.value3 = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
                this.value4 = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
                this.value5 = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
            },

            sortVisit(){
                for (let i = 0; i < this.opinion.length; i++) {
                    this.getRequest('/sortVisit',{address: this.opinion[i],dateTime: this.value4,indoorname:this.shopMap}).then(resp => {
                        if (resp.success) {
                            this.opinionother.push(this.opinion[i])
                            this.opinionData.push(resp.data)
                        } else {
                            this.$message.error(resp.data);
                        }
                    })
                }
            },

            sortStoptime(){
                for (let i = 0; i < this.opinion2.length; i++) {
                    this.getRequest('/sortStoptime',{address: this.opinion2[i],dateTime: this.value3,indoorname: this.shopMap}).then(resp => {
                        if (resp.success) {
                            let add = {}
                            add.value=resp.data,
                            add.name=this.opinion2[i],
                            this.opinionData2.push(add)
                        } else {
                            this.$message.error(resp.data);
                        }
                    })
                }
            },

            sortNow(){
                this.saveopinion3=[]
                for (let i = 0; i < this.opinion3.length; i++) {
                    this.getRequest('/sortNow',{address: this.opinion3[i],indoorname:this.shopMap}).then(resp => {
                        if (resp.success) {
                                this.saveopinion3.push(this.opinion3[i])
                                this.opinionData3.push(resp.data)
                                console.log('遍历的opinion3值是:' + this.opinion3[i])
                        } else {
                            this.$message.error(resp.data);
                        }
                    })
                }
            }
        }
    }
</script>

<style scoped>
    .layout-head{
        height: 50px;
        width: 100%;
        border-bottom: 50px;
    }
    .shopaddress{
        float: right;
        height: 50px;
        width: 150px;
    }
</style>