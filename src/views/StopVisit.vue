<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
            <el-button type="success" round @click="btn3" icon="el-icon-circle-plus-outline" style="float: left;margin-top: 5px;">新增</el-button>
            <el-button type="primary" round @click="btnquery" style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 10px">查询信息</el-button>
            <el-input v-model="staffdata" style="width: 250px;float: right;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
        </div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="区域名" align="center">
                <template slot-scope="scope">{{scope.row.address}}</template>
            </el-table-column>
            <el-table-column label="inJudge" align="center">
                <template slot-scope="scope">{{scope.row.inJudge}}</template>
            </el-table-column>
            <el-table-column label="进入时间" align="center">
                <template slot-scope="scope">{{scope.row.in_time}}</template>
            </el-table-column>
            <el-table-column label="离开时间" align="center">
                <template slot-scope="scope">{{scope.row.left_time}}</template>
            </el-table-column>
            <el-table-column label="停留时间" align="center">
                <template slot-scope="scope">{{scope.row.rt}}</template>
            </el-table-column>
            <el-table-column label="访问次数" align="center">
                <template slot-scope="scope">{{scope.row.visited_times}}</template>
            </el-table-column>
            <el-table-column label="是否已处理" align="center">
                <template slot-scope="scope">{{scope.row.handleJudge}}</template>
            </el-table-column>
            <el-table-column label="管理" align="center">
                <template slot-scope="scope">
                    <el-button type="success" icon="el-icon-thumb" plain @click="handleDo(scope.row)">处理</el-button>
                </template>
            </el-table-column>
            <el-table-column label="mac" align="center">
                <template slot-scope="scope">{{scope.row.mac}}</template>
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
                <el-form-item label="区域名">
                    <el-select v-model="form.address" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="inJudge">
                    <el-input v-model="form.inJudge"></el-input>
                </el-form-item>
                <el-form-item label="停留时间">
                    <el-input v-model="form.rt"></el-input>
                </el-form-item>
                <el-form-item label="访问次数">
                    <el-input v-model="form.visited_times"></el-input>
                </el-form-item>
                <el-form-item label="是否已处理">
                    <el-input v-model="form.handleJudge"></el-input>
                </el-form-item>
                <el-form-item label="mac">
                    <el-input v-model="form.mac"></el-input>
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
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleUpdate">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog  :visible.sync="dialogFormVisible2" width="300px">
            <el-form :model="form2" >
                <el-form-item label="区域名">
                    <el-select v-model="form2.address" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="inJudge">
                    <el-input v-model="form2.inJudge"></el-input>
                </el-form-item>
                <el-form-item label="进入时间">
                    <el-input v-model="form2.in_time"></el-input>
                </el-form-item>
                <el-form-item label="离开时间">
                    <el-input v-model="form2.left_time"></el-input>
                </el-form-item>
                <el-form-item label="停留时间">
                    <el-input v-model="form2.rt"></el-input>
                </el-form-item>
                <el-form-item label="访问次数">
                    <el-input v-model="form2.visited_times"></el-input>
                </el-form-item>
                <el-form-item label="是否已处理">
                    <el-input v-model="form2.handleJudge"></el-input>
                </el-form-item>
                <el-form-item label="mac">
                    <el-input v-model="form2.mac"></el-input>
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
        name: "StopVisit",
        data () {
            return {
                listLoading: false,
                list: [],
                showinput: true,
                staffdata:'',
                placeholder: '可以根据区域名模糊查询',
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1,
                stop_visit_id:'',
                dialogFormVisible: false,
                dialogFormVisible2: false,
                form: {
                    address: '',
                    inJudge:'',
                    in_time:'',
                    left_time:'',
                    rt:'',
                    visited_times:'',
                    handleJudge:'',
                    mac:'',
                    indoorname:''
                },
                form2: {
                    address: '',
                    inJudge:'',
                    in_time:'',
                    left_time:'',
                    rt:'',
                    visited_times:'',
                    handleJudge:'',
                    mac:'',
                    indoorname:''
                },
                indoordata:[],
                addressdata:[]
            }
        },
        mounted () {
            this.checkJurisdiction()
            this.checkJurisdiction2 ()
            this.init()
        },
        methods: {
            checkJurisdiction () {   //返回禁止区域列表
                this.getRequest('/listClassNoPageStop',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].adress
                            this.addressdata.push(add)
                        }
                        this.form2.address = this.addressdata[0].label
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
                this.getRequest('/listStopVisit',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.inJudge = resp.data.list[i].injudge
                            add.address = resp.data.list[i].address
                            add.in_time = resp.data.list[i].inTime
                            add.left_time = resp.data.list[i].leftTime
                            add.rt = resp.data.list[i].rt
                            add.visited_times = resp.data.list[i].visitedTimes
                            add.handleJudge = resp.data.list[i].handlejudge
                            add.mac = resp.data.list[i].mac
                            add.stop_visit_id = resp.data.list[i].stopVisitId
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
                this.getRequest('/listStopVisitSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.inJudge = resp.data.list[i].injudge
                            add.address = resp.data.list[i].address
                            add.in_time = resp.data.list[i].inTime
                            add.left_time = resp.data.list[i].leftTime
                            add.rt = resp.data.list[i].rt
                            add.visited_times = resp.data.list[i].visitedTimes
                            add.handleJudge = resp.data.list[i].handlejudge
                            add.mac = resp.data.list[i].mac
                            add.stop_visit_id = resp.data.list[i].stopVisitId
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
                this.stop_visit_id=row.stop_visit_id
                if(row.inJudge==null){
                    this.form.inJudge=''
                }
                else{
                    this.form.inJudge=row.inJudge
                }
                this.form.address=row.address
                this.form.in_time=row.in_time
                this.form.left_time=row.left_time
                this.form.rt=row.rt
                this.form.visited_times=row.visited_times
                this.form.handleJudge=row.handleJudge
                this.form.mac=row.mac
                this.form.indoorname=row.indoorname
            },
            handleUpdate(row){
                this.putRequest('/updateStopVisit',{ stop_visit_id:this.stop_visit_id, handleJudge:this.form.handleJudge, inJudge:this.form.inJudge, address:this.form.address, rt:this.form.rt, visited_times:this.form.visited_times, mac:this.form.mac,indoorname:this.form.indoorname}).then(resp => {
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
                this.deleteRequest('/deleteStopVisit',{stop_visit_id:row.stop_visit_id}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },
            handleDo(row){
                this.putRequest('/doStopVisit',{stop_visit_id:row.stop_visit_id,address:row.address,indoorname:row.indoorname}).then(resp => {
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
                    this.init()
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
                this.postKeyValueRequest('/addStopVisit',{handleJudge:this.form2.handleJudge, inJudge:this.form2.inJudge, address:this.form2.address, in_time:this.form2.in_time, left_time:this.form2.left_time, rt:this.form2.rt, visited_times:this.form2.visited_times, last_in_time:this.form2.last_in_time, mac:this.form2.mac, indoorname:this.form2.indoorname}).then(resp => {
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
        }
    }
</script>

<style scoped>

</style>