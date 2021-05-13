<template>
    <div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="身份" align="center">
                <template slot-scope="scope">{{scope.row.name}}</template>
            </el-table-column>
            <el-table-column label="中文描述" align="center">
                <template slot-scope="scope">{{scope.row.desc}}</template>
            </el-table-column>
            <el-table-column label="操作" align="center">
                <template slot-scope="scope">
                    <el-button type="success" @click="givePermission(scope.row)">访问授权</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    export default {
        name: "Role",
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
                this.getRequest('/listRole').then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.rid=resp.data[i].rid
                            add.name = resp.data[i].name
                            add.desc=resp.data[i].desc
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },
            givePermission(row){
                this.$router.replace("/permission");  //页面跳转
                this.$store.state.rid = row.rid
            }
        }
    }
</script>

<style scoped>

</style>