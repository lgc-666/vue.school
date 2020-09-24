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
                status:''
            }
        },
        mounted () {
            this.init()
        },
        methods: {
            init () {
                console.log('值1是:' + this.$store.state.rid)
                let rid = this.$store.state.rid
                this.getRequest('/editRole',{rid:rid}).then(resp => {
                    console.log('值2是:' + resp.data["all_permission"].length)
                    if (resp.success) {
                        for (let i = 0; i < resp.data["all_permission"].length; i++) {
                            let add = {}
                            add.path=resp.data["all_permission"][i].path
                            add.name = resp.data["all_permission"][i].name
                            add.pid=resp.data["all_permission"][i].pid
                            for (let j = 0; j < resp.data["role_permission"].length; j++) {
                                  if(resp.data["all_permission"][i].pid==resp.data["role_permission"][j].pid){
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
            }
        }
    }
</script>

<style scoped>

</style>