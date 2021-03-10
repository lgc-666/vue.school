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
                <template slot-scope="scope">{{scope.row.adress}}</template>
            </el-table-column>
            <el-table-column label="x1" align="center">
                <template slot-scope="scope">{{scope.row.x1}}</template>
            </el-table-column>
            <el-table-column label="y1" align="center">
                <template slot-scope="scope">{{scope.row.y1}}</template>
            </el-table-column>
            <el-table-column label="y2" align="center">
                <template slot-scope="scope">{{scope.row.y2}}</template>
            </el-table-column>
            <el-table-column label="x2" align="center">
                <template slot-scope="scope">{{scope.row.x2}}</template>
            </el-table-column>
            <el-table-column label="是否为禁区" align="center">
                <template slot-scope="scope">{{scope.row.stopjudge}}</template>
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
                    <el-input v-model="form.adress"></el-input>
                </el-form-item>
                <el-form-item label="x1">
                    <el-input v-model="form.x1"></el-input>
                </el-form-item>
                <el-form-item label="y1">
                    <el-input v-model="form.y1"></el-input>
                </el-form-item>
                <el-form-item label="x2">
                    <el-input v-model="form.x2"></el-input>
                </el-form-item>
                <el-form-item label="y2">
                    <el-input v-model="form.y2"></el-input>
                </el-form-item>
                <el-form-item label="是否为禁区">
                    <el-input v-model="form.stopjudge"></el-input>
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
                    <el-input v-model="form2.adress" placeholder="按室内划分填写"></el-input>
                </el-form-item>
                <el-form-item label="x1">
                    <el-input v-model="form2.x1" placeholder="左下角坐标"></el-input>
                </el-form-item>
                <el-form-item label="y1">
                    <el-input v-model="form2.y1" placeholder="左上角坐标"></el-input>
                </el-form-item>
                <el-form-item label="y2">
                    <el-input v-model="form2.y2" placeholder="右上角坐标"></el-input>
                </el-form-item>
                <el-form-item label="x2">
                    <el-input v-model="form2.x2" placeholder="右下角坐标"></el-input>
                </el-form-item>
                <el-form-item label="是否为禁区">
                    <el-input v-model="form2.stopjudge" placeholder="取值为0或1"></el-input>
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
        name: "Class",
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
                classid:'',
                dialogFormVisible: false,
                dialogFormVisible2: false,
                form: {
                    adress: '',
                    stopjudge:'',
                    x1:'',
                    x2:'',
                    y1:'',
                    y2:'',
                    indoorname:''
                },
                form2: {
                    adress: '',
                    stopjudge:'',
                    x1:'',
                    x2:'',
                    y1:'',
                    y2:'',
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
                this.getRequest('/listClass',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.stopjudge = resp.data.list[i].stopjudge
                            add.adress = resp.data.list[i].adress
                            add.x1 = resp.data.list[i].x1
                            add.x2 = resp.data.list[i].x2
                            add.y1 = resp.data.list[i].y1
                            add.y2 = resp.data.list[i].y2
                            add.classid = resp.data.list[i].classid
                            add.indoorname = resp.data.list[i].indoorname
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            btnquery () {
                this.list=[],l
                this.getRequest('/listClassSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.stopjudge = resp.data.list[i].stopjudge
                            add.adress = resp.data.list[i].adress
                            add.x1 = resp.data.list[i].x1
                            add.x2 = resp.data.list[i].x2
                            add.y1 = resp.data.list[i].y1
                            add.y2 = resp.data.list[i].y2
                            add.classid = resp.data.list[i].classid
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
                this.classid=row.classid
                if(row.stopjudge==null){
                    this.form.stopjudge=''
                }
                else{
                    this.form.stopjudge=row.stopjudge
                }
                this.form.adress=row.adress
                this.form.x1=row.x1
                this.form.x2=row.x2
                this.form.y1=row.y1
                this.form.y2=row.y2
                this.form.indoorname=row.indoorname
            },
            handleUpdate(row){
                this.putRequest('/updateClass',{ classid:this.classid,stopJudge:this.form.stopjudge, adress:this.form.adress, x1:this.form.x1, x2:this.form.x2, y1:this.form.y1, y2:this.form.y2,indoorname:this.form.indoorname}).then(resp => {
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
                this.deleteRequest('/deleteClass',{classid:row.classid}).then(resp => {
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
                this.postKeyValueRequest('/addClass',{stopJudge:this.form2.stopjudge, adress:this.form2.adress, x1:this.form2.x1, x2:this.form2.x2, y1:this.form2.y1, y2:this.form2.y2,indoorname:this.form2.indoorname}).then(resp => {
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