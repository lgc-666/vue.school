<template>
    <div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="账号" align="center">
                <template slot-scope="scope">{{scope.row.username}}</template>
            </el-table-column>
            <el-table-column label="联系人" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="100"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
            <el-table-column label="教师" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="100"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
            <el-table-column label="管理员" align="center">
                <template slot-scope="scope">
                    <el-switch
                            v-model="scope.row.status"
                            active-color="#13ce66"
                            inactive-color="#ff4949"
                            active-value="100"
                            inactive-value="0"
                            @change="changeSwitch(scope.row)">
                    </el-switch>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    import { MessageBox } from 'element-ui'
    export default {
        name: 'Account',
        data () {
            return {
                listLoading: false,
                list: []
            }
        },
        mounted () {
            this.init()
        },
        methods: {
            init () {
                this.$axios.get('http://47.112.255.207:8081/searchRegister_ApprovalByBossname', {
                    Headers: {
                        'Authorization': ' '
                    },
                    params: {
                        bossname: this.$store.state.bossname
                    },
                    crossDomain: true
                }).then(res => {
                    if (res.data.code === 200) {
                        this.list = res.data.data
                    }
                    if (res.data.code === 401) {
                        console.log('服务器错误')
                    }
                }).catch(err => {
                    console.log(err)
                })
            },
            handlecheck (index) {
                let checkdata = {}
                checkdata.username = this.list[index].username
                checkdata.bossname = this.$store.state.bossname
                checkdata = this.$qs.stringify(checkdata)
                var mes = '确定通过' + this.list[index].username + '的注册吗？'
                MessageBox.confirm(mes, '提示', {
                    showCancelButton: true,
                    confirmButtonText: '确定',
                    cancelButtonClass: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios({
                        method: 'post',
                        url: 'http://47.112.255.207:8081/agreeRegister_Approval',
                        data: checkdata,
                        Headers: {
                            'Authorization': ' '
                        },
                        crossDomain: true
                    }).then(res => {
                        if (res.data.code === 200) {
                            this.init()
                            console.log('成功')
                        }
                        if (res.data.code === 402) {
                            console.log('失败')
                        }
                        if (res.data.code === 401) {
                            alert('该用户名已被注册')
                        }
                    }).catch(err => {
                        console.log(err)
                    })
                }).catch(() => {
                })
            },
            handleDelete (index) {
                let checkdata = {}
                checkdata.username = this.list[index].username
                checkdata.bossname = this.$store.state.bossname
                checkdata = this.$qs.stringify(checkdata)
                var mes = '确定拒绝' + this.list[index].username + '的注册吗？'
                MessageBox.confirm(mes, '提示', {
                    showCancelButton: true,
                    confirmButtonText: '确定',
                    cancelButtonClass: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios({
                        method: 'post',
                        url: 'http://47.112.255.207:8081/refuseRegister_Approval',
                        data: checkdata,
                        Headers: {
                            'Authorization': ' '
                        },
                        crossDomain: true
                    }).then(res => {
                        if (res.data.code === 200) {
                            this.init()
                            console.log('成功')
                        }
                        if (res.data.code === 401) {
                            alert('该用户名已被注册')
                        }
                    }).catch(err => {
                        console.log(err)
                    })
                }).catch(() => {
                })
            }
        }
    }
</script>

<style scoped>

</style>


<style scoped>

</style>