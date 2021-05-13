<template>
    <div style="height: 100%;padding: 0px;margin: 0px;">
        <el-container>
            <el-header class="homeHeader">
                <div class="title">室内定位系统</div>
                <el-dropdown @command="commandHandler" class="userInfo">
                    <span class="el-dropdown-link">
                        {{user.username}}<i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="userinfo" divided>个人信息</el-dropdown-item>
                        <el-dropdown-item command="setting" divided>密码修改</el-dropdown-item>
                        <el-dropdown-item command="logout" divided>注销登录</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </el-header>
            <el-container>
                <el-aside style="width:200px;height: 100vh;background-color:#545c64">
                    <el-menu
                            default-active="2"
                            class="el-menu-vertical-demo"
                            background-color="#545c64"
                            text-color="#fff"
                            active-text-color="#ffd04b"
                            @select="memuClick"
                            unique-opened>
                        <el-submenu :index="index+''" v-for="(item, index) in routes" v-if="!item.hidden" :key="index">
                            <template slot="title">
                                <i style="color: cornsilk;margin-right: 6px;" :class="item.iconCls"></i>
                                <span>{{item.name}}</span>
                            </template>
                            <el-menu-item :index="child.path" v-for="(child,indexj) in item.children" :key="indexj">{{child.name}}</el-menu-item>
                        </el-submenu>
                    </el-menu>
                </el-aside>
                <el-container>
                    <el-main>
                        <router-view/>
                    </el-main>
                    <el-dialog
                            title="个人信息：下面的插槽title会替换title显示的内容"
                            :visible.sync="centerDialogVisible"
                            width="30%"
                            center>
                        <div slot="title" class="header-title">
                            <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
                        </div>
                        <el-table
                                :data="list"
                                style="width: 100%">
                            <el-table-column
                                    prop="personName"
                                    label="姓名"
                                    width="60">
                            </el-table-column>
                            <el-table-column
                                    prop="personRole"
                                    label="角色"
                                    width="100">
                            </el-table-column>
                            <el-table-column
                                    prop="personMac"
                                    label="mac"
                                    width="140">
                            </el-table-column>
                            <el-table-column
                                    prop="personSalt"
                                    label="salt">
                            </el-table-column>
                        </el-table>
                        <span slot="footer" class="dialog-footer">
                          <el-button type="primary" @click="centerDialogVisible = false">关 闭</el-button>
                        </span>
                    </el-dialog>
                    <el-dialog :title="'当前操作账号：'+user.username" :visible.sync="dialogFormVisible2" width="400px">
                        <el-form :model="form">
                            <el-form-item label="请输入新密码">
                                <el-input v-model="form.newpassword"></el-input>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="dialogFormVisible2 = false">取 消</el-button>
                            <el-button type="primary" @click="updatePassword">确 定</el-button>
                        </div>
                    </el-dialog>
                </el-container>
            </el-container>
        </el-container>
    </div>

</template>

<script>
    import {Message} from "element-ui";

    export default {
        name: "Home",
        data(){
            return{
                dialogFormVisible2: false,
                form: {
                    newpassword: '',
                },
                list: [{
                    personName: '',
                    personMac: '',
                    personSalt: '',
                    personRole: ''
                }],
                personUid:'',
                size: 8,
                start: 0,
                centerDialogVisible: false,
                user:JSON.parse(window.sessionStorage.getItem("user")),
            }
        },
        mounted() { //页面初始化（设置一个所有角色都能访问的页面）
                this.$router.push('/administrators');
        },
        computed:{
             routes(){
                 return this.$store.state.routes;   //获取共享区域store的变量routes
             }
        },
        methods:{
            commandHandler(cmd){
                if(cmd=='logout'){
                    this.$confirm('此操作将注销登录, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.getRequest('/doLogout');   //请求接口
                        window.sessionStorage.removeItem("user")  //清除键值对缓存
                        this.$store.commit('initRoutes', [])//清空store中的共享数据，避免下一个人看的是上一个人的菜单：把菜单赋值为空数组
                        this.$router.replace("/");  //页面跳转
                        Message.success('注销成功！');
                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消注销'
                        });
                    });
                }
                else if (cmd=='userinfo'){
                        this.list=[],
                        this.getRequest('/listUserSearch',{staffdata:this.user.username,start:this.start,size:this.size}).then(resp => {
                            if (resp.success) {
                                    let add = {}
                                    add.personName = resp.data.list[0].username;
                                    add.personMac = resp.data.list[0].mac;
                                    add.personSalt = resp.data.list[0].salt;
                                    add.personRole = this.user.roledesc;
                                    this.list.push(add)
                            } else {
                                this.$message.error(JSON.stringify(resp.data));
                            }
                        })
                        this.dialogFormVisible2 = false
                        this.centerDialogVisible = true
                }
                else if (cmd=='setting'){
                    this.list=[],
                        this.getRequest('/listUserSearch',{staffdata:this.user.username,start:this.start,size:this.size}).then(resp => {
                            if (resp.success) {
                                this.personUid = resp.data.list[0].uid;
                            } else {
                                this.$message.error(JSON.stringify(resp.data));
                            }
                        })
                    this.centerDialogVisible = false
                    this.dialogFormVisible2 = true
                }
            },
            memuClick(index){
                this.$router.push(index);
            },


            updatePassword(){
                this.putRequest('/updatePassword',{newpassword:this.form.newpassword,uid:this.personUid}).then(resp => {
                    if (resp.success) {
                        this.$message.success(resp.data)
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
                this.dialogFormVisible2 = false
            },
        }
    }
</script>

<style>
    .homeHeader{
              background-color: #07090a;
              display: flex;
              align-items: center;
              justify-content: space-between;
              padding: 0px 15px;
              box-sizing: border-box;
          }
    .homeHeader .title{
        font-size: 30px;
        font-family: 华文行楷;
        color: #fdfafa;
    }
    .homeHeader .userInfo{
        cursor:pointer;
    }
    .el-dropdown-link {
        cursor: pointer;
        color: #fbfbfc;
        font-size: 15px;
    }

</style>