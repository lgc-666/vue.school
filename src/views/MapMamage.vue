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
            <el-table-column label="室内地图名称" align="center">
                <template slot-scope="scope">{{scope.row.indoorname}}</template>
            </el-table-column>
            <el-table-column label="fmapID" align="center">
                <template slot-scope="scope">{{scope.row.fmapID}}</template>
            </el-table-column>
            <el-table-column label="经度" align="center">
                <template slot-scope="scope">{{scope.row.longitude}}</template>
            </el-table-column>
            <el-table-column label="纬度" align="center">
                <template slot-scope="scope">{{scope.row.latitude}}</template>
            </el-table-column>
            <el-table-column label="负责人" align="center">
                <template slot-scope="scope">{{scope.row.charge}}</template>
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
                <el-form-item label="室内地图名称">
                    <el-input v-model="form3.indoorname" placeholder="室内地图名称"></el-input>
                </el-form-item>
                <el-form-item label="fmapID">
                    <el-input v-model="form3.fmapID" placeholder="室内地图所对应的ID"></el-input>
                </el-form-item>
                <el-form-item label="经度">
                    <el-input v-model="form3.longitude" placeholder="百度地图中的经度"></el-input>
                </el-form-item>
                <el-form-item label="纬度">
                    <el-input v-model="form3.latitude" placeholder="百度地图中的维度"></el-input>
                </el-form-item>
                <el-form-item label="负责人">
                    <el-select v-model="form3.charge" placeholder="该室内场所的负责人">
                        <el-option v-for="(item, index) in chargedata"
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
            <el-form :model="form4" >
                <el-form-item label="室内地图名称">
                    <el-input v-model="form4.indoorname" placeholder="室内地图名称"></el-input>
                </el-form-item>
                <el-form-item label="fmapID">
                    <el-input v-model="form4.fmapID" placeholder="室内地图所对应的ID"></el-input>
                </el-form-item>
                <el-form-item label="经度">
                    <el-input v-model="form4.longitude" placeholder="百度地图中的经度"></el-input>
                </el-form-item>
                <el-form-item label="纬度">
                    <el-input v-model="form4.latitude" placeholder="百度地图中的维度"></el-input>
                </el-form-item>
                <el-form-item label="负责人">
                    <el-select v-model="form4.charge" placeholder="请选择该室内场所的负责人">
                        <el-option v-for="(item, index) in chargedata"
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
        name: "MapMamage",
        data () {
            return {
                listLoading: false,
                list: [],
                showinput: true,
                staffdata:'',
                placeholder: '根据负责人查询室内地图,支持模糊查找',
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1,
                dialogFormVisible: false,
                dialogFormVisible2: false,
                id:'',
                form3: {
                    indoorname:'',
                    fmapID:'',
                    longitude:'',
                    latitude:'',
                    charge:''
                },
                form4: {
                    indoorname:'',
                    fmapID:'',
                    longitude:'',
                    latitude:'',
                    charge:''
                },
                chargedata:[]
            }
        },
        mounted () {
            this.checkJurisdiction2()
            this.init()
        },
        methods: {
            init () {
                this.getRequest('/listMapMamage',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.id = resp.data.list[i].id
                            add.indoorname = resp.data.list[i].indoorname
                            add.fmapID = resp.data.list[i].fmapid
                            add.longitude = resp.data.list[i].longitude
                            add.latitude = resp.data.list[i].latitude
                            add.charge = resp.data.list[i].charge
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            checkJurisdiction2 () {   //返回负责人列表
                this.getRequest('/listUserByRoleNoPage',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].username
                            this.chargedata.push(add)
                        }
                        this.form4.charge = this.chargedata[0].label
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },


            btnquery () {
                this.list=[],
                    this.getRequest('/listMapMamageSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                        if (resp.success) {
                            console.log('total是:' + resp.data.total)
                            this.total = resp.data.total;
                            this.pages = resp.data.pages;
                            for (let i = 0; i < resp.data.list.length; i++) {
                                let add = {}
                                add.id = resp.data.list[i].id
                                add.indoorname = resp.data.list[i].indoorname
                                add.fmapID = resp.data.list[i].fmapid
                                add.longitude = resp.data.list[i].longitude
                                add.latitude = resp.data.list[i].latitude
                                add.charge = resp.data.list[i].charge
                                this.list.push(add)
                            }
                        } else {
                            this.$message.error(resp.data);
                        }
                    })
            },

            handlecheck(row){
                this.dialogFormVisible = true
                this.id=row.id
                this.form3.indoorname=row.indoorname
                this.form3.fmapID=row.fmapID
                this.form3.longitude=row.longitude
                this.form3.latitude=row.latitude
                this.form3.charge=row.charge
            },
            handleUpdate(row){
                this.putRequest('/updateMapMamage',{id:this.id,indoorname:this.form3.indoorname,fmapID:this.form3.fmapID, longitude:this.form3.longitude, latitude:this.form3.latitude, charge:this.form3.charge}).then(resp => {
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
                this.deleteRequest('/deleteMapMamage',{id:row.id}).then(resp => {
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
            btn3(){
                this.dialogFormVisible2 = true
            },
            add(){
                this.postKeyValueRequest('/addMapMamage',{indoorname:this.form4.indoorname,fmapID:this.form4.fmapID, longitude:this.form4.longitude, latitude:this.form4.latitude, charge:this.form4.charge}).then(resp => {
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