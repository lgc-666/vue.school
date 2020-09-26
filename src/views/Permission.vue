<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" icon="el-icon-back" circle @click="backup" style="background-color: white;color: black;border: 0;float: left;margin-top: 0px;margin-left: 0px;font-size:x-large"></el-button>
            <el-button type="primary" round @click="btn2" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
       </div>
        <el-table :data="list"
                  v-loading="listLoading" border>
            <el-table-column label="权限名" align="center">
                <template slot-scope="scope">{{scope.row.name}}</template>
            </el-table-column>
            <el-table-column label="path" align="center">
                <template slot-scope="scope">{{scope.row.path}}</template>
            </el-table-column>
            <el-table-column label="授权/撤权" align="center">
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
    import qs from 'qs'
    import {initMenu} from "../utils/menus";
    import router from "../router";
    import store from "../store";
    export default {
        name: "Permission",
        data () {
            return {
                listLoading: false,
                list: [],
                placeholder: '可以根据姓名,工号,用户名模糊查询',
                showinput: true,
                staffdata:'',
                status:'',
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
                console.log('值1是:' + this.$store.state.rid)
                let rid = this.$store.state.rid
                this.getRequest('/editRole',{rid:rid,start:this.start,size:this.size}).then(resp => {
                    console.log('值2是:' + resp.data["all_permission"].list.length)
                    if (resp.success) {
                        this.total = resp.data["all_permission"].total;
                        this.pages = resp.data["all_permission"].pages;
                        for (let i = 0; i < resp.data["all_permission"].list.length; i++) {
                            let add = {}
                            add.path=resp.data["all_permission"].list[i].path
                            add.name = resp.data["all_permission"].list[i].name
                            add.pid=resp.data["all_permission"].list[i].pid
                            for (let j = 0; j < resp.data["role_permission"].list.length; j++) {
                                  if(resp.data["all_permission"].list[i].pid==resp.data["role_permission"].list[j].pid){
                                      add.status1='1'
                                      break
                                  }
                                  else{
                                      add.status1='0'
                                  }
                            }
                            this.list.push(add)
                            console.log('值1是:' + add.status1)
                        }
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
            },
            changeSwitch (row) {
                let rid = this.$store.state.rid
                this.status=row.status1
                this.pid=row.pid
                this.putRequest('/updateRolePermission',{status:this.status,rid:rid,pid:this.pid}).then(resp => {
                    if (resp.success) {
                        this.$store.commit('initRoutes', [])
                        initMenu(router,store)
                        this.$message.success(resp.data)
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }

                })
            },
            btn2 () {
                this.list=[],
                    this.init()
            },
            backup(){
                this.$store.state.rid = ''
                this.$router.replace("/role");  //页面跳转
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