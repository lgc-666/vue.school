<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="info" style="float: left;margin-top: 0px;">关闭/开启自动控制
                <el-switch
                        v-model="valuecotrol"
                        active-color="#13ce66"
                        inactive-color="#ff4949"
                        active-value="1"
                        inactive-value="0"
                        @change="changeSwitch2()">
                </el-switch>
            </el-button>
            <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 16px">刷新</el-button>
            <el-button type="success" round @click="btn3" icon="el-icon-circle-plus-outline" style="float: left;margin-top: 5px;">新增</el-button>

            <el-button type="primary" round @click="btnquery" style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 10px">查询信息</el-button>
            <el-input v-model="staffdata" style="width: 250px;float: right;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
        </div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="设备名" align="center">
                <template slot-scope="scope">{{scope.row.devicename}}</template>
            </el-table-column>
            <el-table-column label="设备id" align="center">
                <template slot-scope="scope">{{scope.row.id}}</template>
            </el-table-column>
            <el-table-column label="设备类型" align="center">
                <template slot-scope="scope">{{scope.row.devicetype}}</template>
            </el-table-column>
            <el-table-column label="设备状态" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.devicevalue"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="1"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
            <el-table-column label="设备位置" align="center">
                <template slot-scope="scope">{{scope.row.location}}</template>
            </el-table-column>
            <el-table-column label="心跳" align="center">
                <template slot-scope="scope">{{scope.row.lasttime}}</template>
            </el-table-column>
            <el-table-column label="创建时间" align="center">
                <template slot-scope="scope">{{scope.row.gentime}}</template>
            </el-table-column>
            <el-table-column label="ip" align="center">
                <template slot-scope="scope">{{scope.row.ip}}</template>
            </el-table-column>
            <el-table-column label="所属室内地图" align="center">
                <template slot-scope="scope">{{scope.row.indoorname}}</template>
            </el-table-column>
            <el-table-column label="操作" align="center">
                <template slot-scope="scope">
                    <el-button type="primary" icon="el-icon-edit" circle @click="handlecheck(scope.row)"></el-button>
                    <el-button type="danger" icon="el-icon-delete" circle @click="handleDelete(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
                background
                @current-change="handleCurrentChange"
                @size-change="handleSizeChange"
                layout="total, sizes, prev, pager, next, jumper"
                :page-sizes="[4, 5, 6, 7, 8]"
                :total="total"
                :pages="pages"
                :page-size="size"
                style="margin-top: 20px;text-align: center;">
        </el-pagination>

        <el-dialog  :visible.sync="dialogFormVisible" width="300px">
            <el-form :model="form" >
                <el-form-item label="设备名">
                    <el-input v-model="form.devicename"></el-input>
                </el-form-item>
                <el-form-item label="设备id">
                    <el-input v-model="form.id"></el-input>
                </el-form-item>
                <el-form-item label="设备类型">
                    <el-input v-model="form.devicetype"></el-input>
                </el-form-item>
                <el-form-item label="设备状态">
                    <el-input v-model="form.devicevalue"></el-input>
                </el-form-item>
                <el-form-item label="所在区域">
                    <el-select v-model="form.location" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="所属室内地图">
                    <el-select v-model="form.indoorname" placeholder="请选择所属室内地图">
                        <el-option v-for="(item, index) in indoordata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="心跳">
                    <el-input v-model="form.lasttime"></el-input>
                </el-form-item>
                <el-form-item label="创建时间">
                    <el-input v-model="form.gentime"></el-input>
                </el-form-item>
                <el-form-item label="ip">
                    <el-input v-model="form.ip"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleUpdate">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog  :visible.sync="dialogFormVisible2" width="300px">
            <el-form :model="form2" >
                <el-form-item label="设备名">
                    <el-input v-model="form2.devicename"></el-input>
                </el-form-item>
                <el-form-item label="设备id">
                    <el-input v-model="form2.id"></el-input>
                </el-form-item>
                <el-form-item label="设备类型">
                    <el-input v-model="form2.devicetype"></el-input>
                </el-form-item>
                <el-form-item label="设备状态">
                    <el-input v-model="form2.devicevalue"></el-input>
                </el-form-item>

                <el-form-item label="所在区域">
                    <el-select v-model="form2.location" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="所属室内地图">
                    <el-select v-model="form2.indoorname" placeholder="请选择所属室内地图">
                        <el-option v-for="(item, index) in indoordata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="心跳">
                    <el-input v-model="form2.lasttime"></el-input>
                </el-form-item>
                <el-form-item label="创建时间">
                    <el-input v-model="form2.gentime"></el-input>
                </el-form-item>
                <el-form-item label="ip">
                    <el-input v-model="form2.ip"></el-input>
                </el-form-item>
                <el-form-item label="端口">
                    <el-input v-model="form2.port"></el-input>
                </el-form-item>
                <el-form-item label="owner">
                    <el-input v-model="form2.owner"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible2 = false">取 消</el-button>
                <el-button type="primary" @click="add">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        name: "Device",
        data () {
            return {
                valuecotrol: "1",
                listLoading: false,
                list: [],
                showinput: true,
                staffdata:'',
                placeholder: '可以根据设备id模糊查询',
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1,
                deviceid:'',
                dialogFormVisible: false,
                dialogFormVisible2: false,
                form: {
                    devicename:'',
                    id:'',
                    devicetype:'',
                    devicevalue:'',
                    location:'',
                    lasttime:'',
                    gentime:'',
                    owner:'',
                    ip:'',
                    port:'',
                    indoorname:''
                },
                form2: {
                    devicename:'',
                    id:'',
                    devicetype:'',
                    devicevalue:'',
                    location:'',
                    lasttime:'',
                    gentime:'',
                    owner:'',
                    ip:'',
                    port:'',
                    indoorname:''
                },
                indoordata:[],
                addressdata:[]
            }
        },
        mounted () {
            this.getcontrol()
            this.checkJurisdiction2()
            this.checkJurisdiction()
            this.init()
        },
        methods: {
            checkJurisdiction () {   //返回区域列表
                this.getRequest('/listClassNoPage2',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].adress
                            this.addressdata.push(add)
                        }
                        this.form2.location = this.addressdata[0].label
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },
            checkJurisdiction2 () {   //返回地图列表
                this.getRequest('/listMapMamageNoPage',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].indoorname
                            this.indoordata.push(add)
                        }
                        this.form2.indoorname = this.indoordata[0].label
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },

            init () {
                this.getRequest('/listDevice',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.devicename = resp.data.list[i].devicename
                            add.id = resp.data.list[i].id
                            add.devicetype = resp.data.list[i].devicetype
                            add.devicevalue = resp.data.list[i].devicevalue
                            add.location = resp.data.list[i].location
                            add.lasttime = resp.data.list[i].lasttime
                            add.gentime = resp.data.list[i].gentime
                            add.owner = resp.data.list[i].owner
                            add.ip = resp.data.list[i].ip
                            add.port = resp.data.list[i].port
                            add.deviceid = resp.data.list[i].deviceid
                            add.indoorname = resp.data.list[i].indoorname
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            btnquery () {
                this.list=[],
                this.getRequest('/listDeviceSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.devicename = resp.data.list[i].devicename
                            add.id = resp.data.list[i].id
                            add.devicetype = resp.data.list[i].devicetype
                            add.devicevalue = resp.data.list[i].devicevalue
                            add.location = resp.data.list[i].location
                            add.lasttime = resp.data.list[i].lasttime
                            add.gentime = resp.data.list[i].gentime
                            add.owner = resp.data.list[i].owner
                            add.ip = resp.data.list[i].ip
                            add.port = resp.data.list[i].port
                            add.deviceid = resp.data.list[i].deviceid
                            add.indoorname = resp.data.list[i].indoorname
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            handlecheck(row){
                this.dialogFormVisible = true
                this.deviceid=row.deviceid
                this.form.devicename=row.devicename
                this.form.id=row.id
                this.form.devicetype=row.devicetype
                this.form.devicevalue=row.devicevalue
                this.form.location=row.location
                this.form.lasttime=row.lasttime
                this.form.ip=row.ip
                this.form.gentime=row.gentime
                this.form.indoorname=row.indoorname
            },
            handleUpdate(row){
                this.putRequest('/updateDevice',{ deviceid:this.deviceid,devicename:this.form.devicename, id:this.form.id, devicetype:this.form.devicetype, devicevalue:this.form.devicevalue, location:this.form.location, lasttime:this.form.lasttime, ip:this.form.ip, gentime:this.form.gentime, indoorname:this.form.indoorname}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
                this.dialogFormVisible = false
            },
            handleDelete(row){
                this.deleteRequest('/deleteDevice',{deviceid:row.deviceid}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },
            btn2 () {
                this.list=[],
                this.deleteRequest('/deleteAllCach',{}).then(resp => {
                    })
                setTimeout(() => {
                    this.init()
                }, 100);
            },
            blurSearchFor () {
                if (this.placeholder === '根据设备id查询设备,支持模糊查找') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '根据设备id查询设备,支持模糊查找'
            },
            btn3(){
                this.dialogFormVisible2 = true

            },
            add(){
                this.postKeyValueRequest('/addDevice',{owner:this.form2.owner,port:this.form2.port,devicename:this.form2.devicename, id:this.form2.id, devicetype:this.form2.devicetype, devicevalue:this.form2.devicevalue, location:this.form2.location, lasttime:this.form2.lasttime, ip:this.form2.ip, gentime:this.form2.gentime, indoorname:this.form2.indoorname}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
                this.dialogFormVisible2 = false
            },

            /**
             * 第n页
             * @param pageNum
             */
            handleCurrentChange(pageNum) {
                // console.log(`当前页: ${val}`);
                this.start = pageNum;
                this.btn2();
            },
            /**
             * 每页记录数
             * @param val
             */
            handleSizeChange(pageSize) {
                // console.log(`每页 ${val} 条`);
                this.size = pageSize;
                this.btn2();
            },

            //通过切换按钮更改设备状态
            changeSwitch (row) {
                console.log("按钮值："+row.devicevalue)
                this.putRequest('/updateStatus',{status:row.devicevalue,id:row.id,indoorname:row.indoorname}).then(resp => {
                    //if (resp.success) {
                        //this.$message.success(resp.data)
                    //} else {
                        //this.$message.error(JSON.stringify(resp.data));
                    //}
                })
            },

            getcontrol () {
                this.putRequest('/getcontrol',{}).then(resp => {
                    if (resp.success) {
                         this.valuecotrol = resp.data
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },

            changeSwitch2 () {
                console.log("按钮值2："+this.valuecotrol)
                this.putRequest('/updateStatus2',{status:this.valuecotrol}).then(resp => {
                })
            }
        }
    }
</script>

<style scoped>

</style>