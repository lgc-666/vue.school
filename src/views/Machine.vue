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
            <el-table-column label="设备id" align="center">
                <template slot-scope="scope">{{scope.row.machineid}}</template>
            </el-table-column>
            <el-table-column label="所在区域" align="center">
                <template slot-scope="scope">{{scope.row.adress}}</template>
            </el-table-column>
            <el-table-column label="所属室内地图" align="center">
                <template slot-scope="scope">{{scope.row.indoorname}}</template>
            </el-table-column>
            <el-table-column label="设备状态" align="center">
                <template slot-scope="scope">{{scope.row.status}}</template>
            </el-table-column>
            <el-table-column label="能探测到的最大范围" align="center">
                <template slot-scope="scope">{{scope.row.leastrssi}}</template>
            </el-table-column>
            <el-table-column label="设备心跳" align="center">
                <template slot-scope="scope">{{scope.row.beat}}</template>
            </el-table-column>
            <el-table-column label="横坐标x" align="center">
                <template slot-scope="scope">{{scope.row.x}}</template>
            </el-table-column>
            <el-table-column label="纵坐标y" align="center">
                <template slot-scope="scope">{{scope.row.y}}</template>
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
            <el-form :model="form3" >
                <el-form-item label="设备id">
                    <el-input v-model="form3.machineid"></el-input>
                </el-form-item>
                <el-form-item label="所在区域">
                    <el-select v-model="form3.adress" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="所属室内地图">
                    <el-select v-model="form3.indoorname" placeholder="请选择所属室内地图">
                        <el-option v-for="(item, index) in indoordata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="设备状态">
                    <el-input v-model="form3.status"></el-input>
                </el-form-item>
                <el-form-item label="能探测到的最大范围">
                    <el-input v-model="form3.leastrssi"></el-input>
                </el-form-item>
                <el-form-item label="设备心跳">
                    <el-input v-model="form3.beat"></el-input>
                </el-form-item>
                <el-form-item label="横坐标x">
                    <el-input v-model="form3.x"></el-input>
                </el-form-item>
                <el-form-item label="纵坐标y">
                    <el-input v-model="form3.y"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleUpdate">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog  :visible.sync="dialogFormVisible2" width="300px">
            <el-form :model="form4" >
                <el-form-item label="设备id">
                    <el-input v-model="form4.machineid" placeholder="一个设备只有一个设备id"></el-input>
                </el-form-item>
                <el-form-item label="所在区域">
                    <el-select v-model="form4.adress" placeholder="设备安放的区域">
                        <el-option v-for="(item, index) in addressdata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="所属室内地图">
                    <el-select v-model="form4.indoorname" placeholder="请选择所属室内地图">
                        <el-option v-for="(item, index) in indoordata"
                                   :key="index"
                                   :value="item.label"
                                   :label="item.label">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="设备状态">
                    <el-input v-model="form4.status" placeholder="在线或离线"></el-input>
                </el-form-item>
                <el-form-item label="能探测到的最大范围">
                    <el-input v-model="form4.leastrssi" placeholder="取值为负数"></el-input>
                </el-form-item>
                <el-form-item label="设备心跳">
                    <el-input v-model="form4.beat" placeholder="刷新时间"></el-input>
                </el-form-item>
                <el-form-item label="横坐标x">
                    <el-input v-model="form4.x" placeholder="具体位置"></el-input>
                </el-form-item>
                <el-form-item label="纵坐标y">
                    <el-input v-model="form4.y" placeholder="具体位置"></el-input>
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
        name: "Machine",
        data () {
            return {
                listLoading: false,
                list: [],
                showinput: true,
                staffdata:'',
                placeholder: '根据设备id查询设备,支持模糊查找',
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1,
                dialogFormVisible: false,
                dialogFormVisible2: false,
                mid:'',
                form3: {
                    machineid:'',
                    adress:'',
                    status:'',
                    leastrssi:'',
                    beat:'',
                    x:'',
                    y:'',
                    indoorname:''
                },
                form4: {
                    machineid:'',
                    adress:'',
                    status:'',
                    leastrssi:'',
                    beat:'',
                    x:'',
                    y:'',
                    indoorname:''
                },
                indoordata:[],
                addressdata:[]
            }
        },
        mounted () {
            this.checkJurisdiction()
            this.checkJurisdiction2()
            this.init()
        },
        methods: {
            checkJurisdiction () {   //返回区域列表
                this.getRequest('/listClassNoPage',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].adress
                            this.addressdata.push(add)
                        }
                        this.form4.adress = this.addressdata[0].label
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
                        this.form4.indoorname = this.indoordata[0].label
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },
            init () {
                this.getRequest('/listmachine',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.machineid = resp.data.list[i].machineid
                            add.adress = resp.data.list[i].adress
                            add.status = resp.data.list[i].status
                            add.leastrssi = resp.data.list[i].leastrssi
                            add.beat = resp.data.list[i].beat
                            add.x = resp.data.list[i].x
                            add.y = resp.data.list[i].y
                            add.mid = resp.data.list[i].mid
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
                this.getRequest('/listmachineSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.machineid = resp.data.list[i].machineid
                            add.adress = resp.data.list[i].adress
                            add.status = resp.data.list[i].status
                            add.leastrssi = resp.data.list[i].leastrssi
                            add.beat = resp.data.list[i].beat
                            add.x = resp.data.list[i].x
                            add.y = resp.data.list[i].y
                            add.mid = resp.data.list[i].mid
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
                this.mid=row.mid
                this.form3.machineid=row.machineid
                this.form3.adress=row.adress
                this.form3.x=row.x
                this.form3.status=row.status
                this.form3.y=row.y
                this.form3.beat=row.beat
                this.form3.indoorname=row.indoorname
                if(row.leastrssi==null){
                    this.form3.leastrssi=''
                }
                else{
                    this.form3.leastrssi=row.leastrssi
                }

                console.log('leastrssi是:' + row.leastrssi)
            },
            handleUpdate(row){
                console.log('leastrssi是:' + this.form3.leastrssi)
                console.log('adress是:' + this.form3.adress)
                this.putRequest('/updatemachine',{ mid:this.mid,machineid:this.form3.machineid, adress:this.form3.adress, indoorname:this.form3.indoorname,x:this.form3.x, status:this.form3.status, y:this.form3.y, beat:this.form3.beat, leastRssi:this.form3.leastrssi}).then(resp => {
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
                this.deleteRequest('/deletemachine',{mid:row.mid}).then(resp => {
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
            btn3(){
                this.dialogFormVisible2 = true
            },
            add(){
                this.postKeyValueRequest('/addmachine',{machineid:this.form4.machineid, adress:this.form4.adress, indoorname:this.form4.indoorname, x:this.form4.x, status:this.form4.status, y:this.form4.y, beat:this.form4.beat, leastRssi:this.form4.leastrssi}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
                this.dialogFormVisible2 = false
            },

            blurSearchFor () {
                if (this.placeholder === '根据设备id查询设备,支持模糊查找') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '根据设备id查询设备,支持模糊查找'
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