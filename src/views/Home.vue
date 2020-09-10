<template>
    <div>
        <el-container>
            <el-header class="homeHeader">
                <div class="title">幼儿园室内定位系统</div>
                <el-dropdown @command="commandHandler" class="userInfo">
                    <span class="el-dropdown-link">
                        {{user.username}}<i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="userinfo" divided>个人中心</el-dropdown-item>
                        <el-dropdown-item command="setting" divided>设置</el-dropdown-item>
                        <el-dropdown-item command="logout" divided>注销登录</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </el-header>
            <el-container>
                <el-aside width="200px">
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
                    <el-footer>Footer</el-footer>
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
                user:JSON.parse(window.sessionStorage.getItem("user")),
            }
        },
        mounted() { //页面初始化（设置一个所有角色都能访问的页面）
                this.$router.push('/test1');
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
            },
            memuClick(index){
                console.log(index);
                this.$router.push(index);
            }
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