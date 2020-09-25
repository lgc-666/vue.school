<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" round @click="btn2" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
        </div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="注册账号" align="center">
                <template slot-scope="scope">{{scope.row.name}}</template>
            </el-table-column>
            <el-table-column label="申请身份" align="center">
                <template slot-scope="scope">{{scope.row.rolename}}</template>
            </el-table-column>
            <el-table-column label="mac地址" align="center">
                <template slot-scope="scope">{{scope.row.mac}}</template>
            </el-table-column>
            <el-table-column label="操作" align="center">
                <template slot-scope="scope">
                    <el-button type="success" @click="handlecheck(scope.row)">同意</el-button>
                    <el-button type="danger" @click="handleDelete(scope.row)">拒绝</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    export default {
        name: "RegisterApproval",
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
                this.getRequest('/listregisterApproval').then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            if(resp.data[i].rid=='1'){
                                add.rolename='访客'
                            }
                            else{
                                add.rolename='工作人员'
                            }
                            add.name = resp.data[i].username
                            add.mac = resp.data[i].mac
                            add.id = resp.data[i].id
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },
            handlecheck(row){
                this.postKeyValueRequest('/agreeregisterApproval',{agreeid:row.id}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                        this.btn2()
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },
            handleDelete(row){
                this.deleteRequest('/deleteregisterApproval',{unagreeid:row.id}).then(resp => {
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
            }
        }
    }
</script>

<style scoped>

</style>