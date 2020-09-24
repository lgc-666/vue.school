<template>
    <div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="注册账号" align="center">
                <template slot-scope="scope">{{scope.row.name}}</template>
            </el-table-column>
            <el-table-column label="申请身份" align="center">
                <template slot-scope="scope">{{scope.row.rolename}}</template>
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
                                add.rolename='联系人'
                            }
                            else{
                                add.rolename='教师'
                            }
                            add.name = resp.data[i].username
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },
            handlecheck(row){
                this.$store.state.rid = row.rid
                console.log('值是:' + row.rid)
                console.log('值是:' + this.$store.state.rid)
            },
            handleDelete(row){
                this.$store.state.rid = row.rid
                console.log('值是:' + row.rid)
                console.log('值是:' + this.$store.state.rid)
            }
        }
    }
</script>

<style scoped>

</style>