<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" icon="el-icon-refresh-right" round @click="btn2" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
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
    </div>
</template>

<script>
    export default {
        name: "RegisterApproval",
        data () {
            return {
                listLoading: false,
                list: [],
                total: 0, //数据总数
                size: 8, //每页的数据条数
                start: 0, //默认开始页面
                pages: 1
            }
        },
        mounted () {
            this.init()
        },
        methods: {
            init () {
                this.getRequest('/listregisterApproval',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            if(resp.data.list[i].rid=='1'){
                                add.rolename='访客'
                            }
                            else{
                                add.rolename='工作人员'
                            }
                            add.name = resp.data.list[i].username
                            add.mac = resp.data.list[i].mac
                            add.id = resp.data.list[i].id
                            this.list.push(add)
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },
            handlecheck(row){
                this.postKeyValueRequest('/agreeregisterApproval',{agreeid:row.id, rolename:row.rolename}).then(resp => {
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
                this.deleteRequest('/deleteAllCach',{}).then(resp => {
                })
                setTimeout(() => {
                    this.init()
                }, 100);
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