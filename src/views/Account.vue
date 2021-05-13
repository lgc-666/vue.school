<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
            <el-button type="primary" round @click="btnquery" style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 10px">查询信息</el-button>
            <el-input v-model="staffdata" style="width: 250px;float: right;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
        </div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="账号" align="center">
                <template slot-scope="scope">{{scope.row.username}}</template>
            </el-table-column>
            <el-table-column label="密码" align="center">
                <template slot-scope="scope">
                    <el-button  @click="changePassword(scope.row)">更改</el-button>
                </template>
            </el-table-column>
            <el-table-column label="访客" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status1"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="1"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
            <el-table-column label="工作人员" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status2"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="2"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
            <el-table-column label="管理员" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status3"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="3"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
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

        <el-dialog :title="'操作账号：'+account" :visible.sync="dialogFormVisible" width="400px">
            <el-form :model="form">
                <el-form-item label="请输入新密码">
                    <el-input v-model="form.newpassword"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="updatePassword">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    import qs from 'qs'
    import { MessageBox } from 'element-ui'
    import {initMenu} from "../utils/menus";
    import router from "../router";
    import store from "../store";
    export default {
        name: 'Account',
        data () {
            return {
                listLoading: false,
                list: [],
                dialogFormVisible: false,
                formLabelWidth: '30px',
                form: {
                    newpassword: '',
                },
                account:'',
                user:null,
                placeholder: '可以根据姓名,工号,用户名模糊查询',
                showinput: true,
                staffdata:'',
                total: 0,
                size: 8,
                start: 0,
                pages: 1
            }
        },
        mounted () {
            this.init()
        },
        methods: {
            init () {
                this.getRequest('/listUser',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.status1 = '0'
                            add.status2 = '0'
                            add.status3 = '0'
                            add.username = resp.data.list[i].username
                            add.user=resp.data.list[i]
                            for (let j = 0; j < resp.data.list[i].role.length; j++){
                                if (resp.data.list[i].role[j].rid===1) {
                                    add.status1 = '1'
                                }
                                else if(resp.data.list[i].role[j].rid===2){
                                    add.status2 = '2'
                                }
                                else if(resp.data.list[i].role[j].rid===3){
                                    add.status3 = '3'
                                }
                            }
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },

            btnquery () {
                this.list=[],
                this.getRequest('/listUserSearch',{staffdata:this.staffdata,start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.status1 = '0'
                            add.status2 = '0'
                            add.status3 = '0'
                            add.username = resp.data.list[i].username
                            add.user=resp.data.list[i]
                            for (let j = 0; j < resp.data.list[i].role.length; j++){
                                if (resp.data.list[i].role[j].rid===1) {
                                    add.status1 = '1'
                                }
                                else if(resp.data.list[i].role[j].rid===2){
                                    add.status2 = '2'
                                }
                                else if(resp.data.list[i].role[j].rid===3){
                                    add.status3 = '3'
                                }
                            }
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },


            changePassword(row){
                this.dialogFormVisible = true
                this.account=row.username
                this.user=row.user.uid
            },

            updatePassword(){
                this.putRequest('/updatePassword',{newpassword:this.form.newpassword,uid:this.user}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
                this.dialogFormVisible = false
            },

            changeSwitch (row) {
                this.roleIds=[row.status1,row.status2,row.status3]+''
                this.user=row.user.uid
                this.putRequest('/updateUser',{roleIds:this.roleIds,uid:this.user}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
                this.dialogFormVisible = false
            },

            blurSearchFor () {
                if (this.placeholder === '可以根据姓名,工号,用户名模糊查询') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '可以根据姓名,工号,用户名模糊查询'
            },
            btn2 () {
                this.list=[],
                this.deleteRequest('/deleteAllCach',{}).then(resp => {
                })
                setTimeout(() => {
                    this.init()
                }, 100);
            },

            handleCurrentChange(pageNum) {
                this.start = pageNum;
                this.btn2();
            },

            handleSizeChange(pageSize) {
                this.size = pageSize;
                this.btn2();
            },
        }
    }
</script>

<style scoped>

</style>


<style scoped>

</style>