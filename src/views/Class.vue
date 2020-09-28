<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" round @click="btn2" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
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
                <template slot-scope="scope">{{scope.row.stopJudge}}</template>
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
                placeholder: '可以根据姓名,工号,用户名模糊查询',
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
                this.getRequest('/listClass',{start:this.start,size:this.size}).then(resp => {
                    if (resp.success) {
                        console.log('total是:' + resp.data.total)
                        this.total = resp.data.total;
                        this.pages = resp.data.pages;
                        for (let i = 0; i < resp.data.list.length; i++) {
                            let add = {}
                            add.stopJudge = resp.data.list[i].stopjudge
                            add.adress = resp.data.list[i].adress
                            add.x1 = resp.data.list[i].x1
                            add.x2 = resp.data.list[i].x2
                            add.y1 = resp.data.list[i].y1
                            add.y2 = resp.data.list[i].y2
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
            },
            blurSearchFor () {
                if (this.placeholder === '根据设备id查询设备,支持模糊查找') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '根据设备id查询设备,支持模糊查找'
            },
            btnquery () {

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