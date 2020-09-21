<template>
    <div>
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
            <el-table-column label="联系人" align="center">
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
            <el-table-column label="教师" align="center">
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
    import { MessageBox } from 'element-ui'
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
                user:null
            }
        },
        mounted () {
            this.init()
        },
        methods: {
            init () {
                this.getRequest('/listUser').then(resp => {
                    console.log('值是:' + resp.success)
                    if (resp.success) {
                        console.log('值1是:' + JSON.stringify(resp.data))
                        console.log('值2是:' + resp.data)
                        console.log('值3是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.status1 = '0'
                            add.status2 = '0'
                            add.status3 = '0'
                            add.username = resp.data[i].username
                            add.user=resp.data[i]
                            for (let j = 0; j < resp.data[i].role.length; j++){
                                console.log('值4是:' + resp.data[i].role[j].rid)
                                if (resp.data[i].role[j].rid===1) {
                                    add.status1 = '1'
                                    console.log('家长默认开启状态：'+add.status1)
                                }
                                else if(resp.data[i].role[j].rid===2){
                                    add.status2 = '2'
                                    console.log('教师默认开启状态：'+add.status2)
                                }
                                else if(resp.data[i].role[j].rid===3){
                                    add.status3 = '3'
                                    console.log('管理员默认开启状态：'+add.status3)
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
                console.log('值是:' + this.user)
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
                this.rowsdata.username = this.$store.state.staffname
                this.rowsdata.pid = row.pid
                console.log(row.pid)
                console.log(this.rowsdata.username)
                let rowsdatas = this.$qs.stringify(this.rowsdata)
                if (row.status === '100') {
                    console.log(row.status)
                    this.$axios({
                        method: 'post',
                        url: 'http://47.112.255.207:8081/addPermission',
                        data: rowsdatas,
                        Headers: {
                            'Authorization': ' '
                        },
                        crossDomain: true
                    }).then(res => {
                        console.log(res.data.code)
                        if (res.data.code === 200) {
                            console.log('修改成功')
                        }
                        if (res.data.code === 402) {
                            alert('操作失败,请联系管理员')
                        }
                    }).catch(err => {
                        console.log(err)
                    })
                }
                if (row.status === '0') {
                    var param = {username: this.$store.state.staffname, pid: row.pid}
                    this.$axios.delete('http://47.112.255.207:8081/deletePermission', {params: param}).then(res => {
                        if (res.data.code === 200) {
                            console.log('撤权成功')
                        }
                        if (res.data.code === 402) {
                            alert('操作失败,请联系管理员')
                        }
                        if (res.data.code === 444) {
                            alert('未登录')
                            this.$router.push('/')
                        }
                    }).catch(error => {
                        console.log('失败')
                        console.log(error)
                    })
                }
            }
        }
    }
</script>

<style scoped>

</style>


<style scoped>

</style>