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
                <template slot-scope="scope">{{scope.row.id}}</template>
            </el-table-column>
            <el-table-column label="设备操作" align="center">
                <template slot-scope="scope">{{scope.row.changevalue}}</template>
            </el-table-column>
            <el-table-column label="创建时间" align="center">
                <template slot-scope="scope">{{scope.row.gentime}}</template>
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
                <el-form-item label="设备id">
                    <el-input v-model="form.id"></el-input>
                </el-form-item>
                <el-form-item label="设备操作">
                    <el-input v-model="form.changevalue"></el-input>
                </el-form-item>
                <el-form-item label="创建时间">
                    <el-input v-model="form.gentime"></el-input>
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
                <el-form-item label="设备id">
                    <el-input v-model="form2.id"></el-input>
                </el-form-item>
                <el-form-item label="设备操作">
                    <el-input v-model="form2.changevalue"></el-input>
                </el-form-item>
                <el-form-item label="创建时间">
                    <el-input v-model="form2.gentime"></el-input>
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
        name: "Logrecord",
        data () {
            return {
                listLoading: false,
                list: [],
                showinput: true,
                staffdata:'',
                placeholder: '可以根据设备id模糊查询',
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1,
                logid:'',
                dialogFormVisible: false,
                dialogFormVisible2: false,
                form: {
                    id:'',
                    changevalue:'',
                    gentime:'',
                    indoorname:''
                },
                form2: {
                    id:'',
                    changevalue:'',
                    gentime:'',
                    indoorname:''
                },
                indoordata:[]
            }
        },
        mounted () {
            this.checkJurisdiction2 ()
            this.init()
        },
        methods: {
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
                this.getRequest('/listLogrecord',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.id = resp.data.list[i].id
                            add.changevalue = resp.data.list[i].changevalue
                            add.gentime = resp.data.list[i].gentime
                            add.logid = resp.data.list[i].logid
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
                this.getRequest('/listLogrecordSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.id = resp.data.list[i].id
                            add.changevalue = resp.data.list[i].changevalue
                            add.gentime = resp.data.list[i].gentime
                            add.logid = resp.data.list[i].logid
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
                this.logid=row.logid
                this.form.changevalue=row.changevalue
                this.form.id=row.id
                this.form.gentime=row.gentime
                this.form.indoorname=row.indoorname
            },
            handleUpdate(row){
                this.putRequest('/updateLogrecord',{ logid:this.logid, changevalue:this.form.changevalue, id:this.form.id, gentime:this.form.gentime,indoorname:this.form.indoorname}).then(resp => {
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
                this.deleteRequest('/deleteLogrecord',{logid:row.logid}).then(resp => {
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
                this.postKeyValueRequest('/addLogrecord',{changevalue:this.form2.changevalue, id:this.form2.id, gentime:this.form2.gentime,indoorname:this.form2.indoorname}).then(resp => {
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