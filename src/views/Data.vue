<template>
    <div class="app-container">
        <div class="address-layout">
            <div class="layout-head">
                <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 10px;margin-left: 25px">室内地址:</div>
                <div class="shopaddress2" style="float: left;">
                    <el-select v-model="shopMap" style="width: 100px" @change="changeaddress2">
                        <el-option v-for="(item, index) in indoordata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </div>

                <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 10px;margin-left: 100px">区域地址:</div>
                <div class="shopaddress2" style="float: left;">
                    <el-select v-model="shopaddress2" style="width: 250px" @change="changeaddress">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label"></el-option>
                    </el-select>
                </div>

                <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 0px;margin-left: 150px">刷新</el-button>

                <div class="shoptime" style="float: right">
                    <div style="float: left;font-size: 20px;margin-top: 10px;margin-right: 10px">日期:</div>
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
            <el-row :gutter="20" style="width: 100%;float: left;margin-top: 10px">

                <el-col :span="3" style="width: 200px;margin-left: 30px">
                    <div class="out-border">
                        <div class="layout-title" style="text-align: center;font-size: 18px">访问量</div>
                        <div class="color-main address-content">
                            <div style="text-align: center;">{{consumerNumber}}</div>
                        </div>
                    </div>
                </el-col>
                <el-col :span="3" style="width: 200px;margin-left: 30px">
                    <div class="out-border">
                        <div class="layout-title" style="text-align: center;font-size: 18px">跳出量</div>
                        <div class="color-main address-content">
                            <div style="text-align: center;">{{jmpOut}}</div>
                        </div>
                    </div>
                </el-col>
                <el-col :span="3" style="width: 200px;margin-left: 30px">
                    <div class="out-border">
                        <div class="layout-title" style="text-align: center;font-size: 18px">新访客</div>
                        <div class="color-main address-content">
                            <div style="text-align: center;">{{newConsumer}}</div>
                        </div>
                    </div>
                </el-col>
                <el-col :span="3" style="width: 200px;margin-left: 30px">
                    <div class="out-border">
                        <div class="layout-title" style="text-align: center;font-size: 18px">当前区域人数</div>
                        <div class="color-main address-content">
                            <div style="text-align: center;">{{dynamicConsumer}}</div>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>
        <div class="statistics-layout">
            <div class="layout-title" style="background-color: white;margin-right: 30px;text-align: center">小时区域外人流量统计</div>
            <el-row>
                <el-col :span="20">
                    <div style="padding: 10px;width: 100%;">
                        <div style="float: left;margin-top: 11px;font-weight: bold;margin-left: 40px;font-size: 20px">日期：</div>
                        <el-date-picker
                                style="z-index: 1;width: 50%;"
                                @change="changeday"
                                v-model="value"
                                align="right"
                                type="date"
                                placeholder="选择日期"
                                value-format="yyyy-MM-dd"
                                :picker-options="pickerOptions">
                        </el-date-picker>
                        <div style="width: 100%;">
                            <ve-line
                                    :legend-visible="false"
                                    width="550px"
                                    height="360px"
                                    :data="chartData"
                                    :settings="chartSettings"
                                    :grid="grid">
                            </ve-line>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>
        <div class="statistics-layout">
            <div class="layout-title" style="background-color: white;text-align: center">小时访问量统计</div>
            <el-row>
                <el-col :span="20">
                    <div style="padding: 10px;width: 100%;">
                        <div style="float: left;margin-top: 11px;font-weight: bold;margin-left: 40px;font-size: 20px">日期：</div>
                        <el-date-picker
                                style="z-index: 1;margin-left: 5px;float: left"
                                @change="changeday1"
                                v-model="value2"
                                align="right"
                                type="date"
                                placeholder="选择日期"
                                value-format="yyyy-MM-dd"
                                :picker-options="pickerOptions1">
                        </el-date-picker>
                        <div style="width: 100%;float: right;padding: 0">
                            <ve-line
                                    :legend-visible="false"
                                    width="550px"
                                    height="360px"
                                    :data="chartData1"
                                    :settings="chartSettings1"
                                    :grid="grid">
                            </ve-line>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>
        <el-dialog
                title="请选择区域"
                :visible.sync="dialogVisible"
                width="30%">
            <el-select v-model="shopaddress2" style="width: 250px;margin-left: 50px" @change="changeaddress">
                <el-option v-for="(item, index) in addressdata"
                           :key="index"
                           :value="item.label"
                           :label="item.label"></el-option>
            </el-select>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="chooceaddress">确 定</el-button>
            </span>
        </el-dialog>

        <el-dialog
                title="请选择室内地图"
                :visible.sync="dialogVisible2"
                width="30%">
            <el-select v-model="shopMap" style="width: 250px;margin-left: 50px" @click="chooceaddress2">
                <el-option v-for="(item, index) in indoordata"
                           :key="index"
                           :value="item.label"
                           :label="item.label">
                </el-option>
            </el-select>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible2 = false">取 消</el-button>
                <el-button type="primary" @click="chooceaddress2">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: 'Data',
        data () {
            return {
                indoordata:[],
                shopMap:'',

                dialogVisible2: false,
                dialogVisible: false,
                dialogVisiblebystaff: false,
                value: '',
                value2: '',
                value3: '',
                shopaddress2: '',
                orderCountDate: '',
                chartSettings: {
                    xAxisType: 'time',
                    area: true,
                    axisSite: {left: ['每个小时的人流量']},
                    labelMap: {'每个小时的人流量': '每个小时的人流量'}},
                chartSettings1: {
                    xAxisType: 'time',
                    area: true,
                    axisSite: {left: ['每个小时的访问量']},
                    labelMap: {'每个小时的访问量': '每个小时的访问量'}},
                chartData: {
                    columns: [],
                    rows: []
                },
                grid: {
                    right: '10%'
                },
                chartData1: {
                    columns: [],
                    rows: []
                },
                loading: false,
                dataEmpty: false,
                walkerNumber: '',
                consumerNumber: '',
                newConsumer: '',
                jmpOut: '',
                dynamicConsumer: '',
                pickerOptions: {disabledDate (time) {
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
                pickerOptions1: {
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
                    }]
                },
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
                username: '',
                addressdata: [],
                addressdatabystaff: [],
                timer: null,
                flaghaveshop: false,
                user:JSON.parse(window.sessionStorage.getItem("user"))
            }
        },
        created () {
            this.checkJurisdiction2 ()
            setTimeout(() => {
              this.judge()
            }, 400);
        },

        beforeDestroy () {
            this.destroyed()
        },
        methods: {
            checkJurisdiction2 () {
                this.getRequest('/listMapMamageNoPage',{roledesc:this.user.roledesc,username:this.user.username}).then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].indoorname
                            this.indoordata.push(add)
                        }

                        if(window.sessionStorage.getItem("address2")!=null&&window.sessionStorage.getItem("address2")!=''){
                            this.shopMap = JSON.parse(window.sessionStorage.getItem('address2'))
                        }
                        else{
                            if(this.indoordata.length!=0){
                                this.shopMap = this.indoordata[0].label
                                window.sessionStorage.setItem("address2", JSON.stringify(this.indoordata[0].label));
                            }
                        }
                    } else {
                    }
                })
            },

            judge () {
                    this.getData()
            },
            getData () {
                this.checkJurisdiction()
                this.gettime()
                this.init()
            },

            checkJurisdiction () {
                this.addressdata=[]
                this.getRequest('/listClassNoPage',{indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].adress
                            this.addressdata.push(add)
                        }
                        if(this.addressdata.length!=0){
                            this.shopaddress2 = this.addressdata[0].label
                        }
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },
            gettime () {
                this.timer = setInterval( () => {
                    if(this.shopMap===''||this.shopaddress2===''||this.value2===''){
                    }
                    else{
                        this.getcustomerdata()
                        this.getChartdata()
                        this.getPassengerflow()
                        this.Refresh()
                    }
                }, 5000)
            },
            init () {
                if (this.$store.state.shopflag === false) {
                    this.dialogVisible2 = true
                    this.dialogVisible = true
                    if(this.addressdata.length!=0){
                        this.shopaddress2 = this.addressdata[0].label
                    }
                } else {
                    this.dialogVisible = false
                    this.dialogVisible2 = false
                    this.shopaddress2 = window.sessionStorage.getItem('address')
                    this.shopMap = JSON.parse(window.sessionStorage.getItem('address2'))
                    this.gettoday()
                }
            },

            getcustomerdata () {
                this.getRequest('/getMainData',{address: this.shopaddress2,dateTime: this.value2,indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.consumerNumber = resp.data.in_class_number
                        this.newConsumer = resp.data.new_student
                        this.jmpOut = resp.data.jmpOut
                        this.dynamicConsumer = resp.data.class_now_number
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            getChartdata () {
                this.getRequest('/getInCustomerPerHour',{address: this.shopaddress2,dateTime: this.value2,indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.chartData1 = {
                            columns: ['小时', '每个小时的访问量'],
                            rows: []
                        }
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            if (resp.data[i].hours === 0) {
                                add.小时 = this.value2 + ' ' + resp.data[i].hours + '0:00:00'
                            } else {
                                add.小时 = this.value2 + ' ' + resp.data[i].hours + ':00:00'
                            }
                            add.每个小时的访问量 = resp.data[i].hour_in_class_number
                            this.chartData1.rows.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            getPassengerflow () {
                this.getRequest('/getCustomerPerHour',{address: this.shopaddress2,dateTime: this.value,indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.chartData = {
                            columns: ['小时', '每个小时的人流量'],
                            rows: []
                        }
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            if (resp.data[i].Hours === 0) {
                                add.小时 = this.value + ' ' + resp.data[i].hours + '0:00:00'
                            } else {
                                add.小时 = this.value + ' ' + resp.data[i].hours + ':00:00'
                            }
                            add.每个小时的人流量 = resp.data[i].hour_class_number
                            this.chartData.rows.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            Refresh () {
                this.getRequest('/listClassNoPage',{indoorname:this.shopMap}).then(resp => {
                    if (resp.success) {
                        this.addressdata=[]
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].adress
                            this.addressdata.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            chooceaddress () {
                this.$store.commit('addshopflag', {shopflag: true})
                window.sessionStorage.setItem('address', this.shopaddress2)
                this.dialogVisible = false
                this.gettoday()
            },

            chooceaddress2 () {
                window.sessionStorage.setItem('address2', JSON.stringify(this.shopMap))
                this.dialogVisible2 = false
                setTimeout(() => {
                    this.checkJurisdiction()
                }, 100);
            },

            destroyed () {
                clearInterval(this.timer)
            },

            changeaddress () {
                window.sessionStorage.setItem('address', this.shopaddress2)
                this.gettoday()
            },

            changeaddress2 () {
                window.sessionStorage.setItem('address2', JSON.stringify(this.shopMap))
                setTimeout(() => {
                    this.checkJurisdiction()
                }, 200);
                this.gettoday()
            },

            gettoday () {
                this.getdata()
                this.getcustomerdata()
                this.getChartdata()
                this.getPassengerflow()
            },
            getdata () {
                var aData = new Date()
                this.value = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
                this.value2 = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
                this.value3 = aData.getFullYear() + '-' + (aData.getMonth() + 1) + '-' + aData.getDate()
            },

            changeday () {
                this.getPassengerflow()
            },
            changeday1 () {
                this.getChartdata()
            },
            changeday3 () {
                this.value = this.value3
                this.value2 = this.value3
                this.changeday()
                this.changeday1()
            },
            btn2 (){
                this.$router.replace("/administrators");
                setTimeout(() => {
                    this.$router.replace("/data");
                },100)
            }
        }

    }
</script>
<style>
    .app-container {
        margin-top: 10px;
    }
    .address-layout {
    }
    .layout-title {
        color: #606266;
        padding: 15px 20px;
        background: #F2F6FC;
        font-weight: bold;
        border-radius:15px 15px 0 0;
    }
    .out-border {
        border: 1px solid #DCDFE6;
        border-radius:15px
    }

    .statistics-layout {
        float: left;
        width: 50%;
    }
    .address-content{
        padding: 20px;
        font-size: 18px;
    }
    .layout-head{
        height: 50px;
        width: 100%;
        border-bottom: 50px;
    }
    .shopaddress2{
        float: right;
        height: 50px;
        width: 150px;
    }
</style>