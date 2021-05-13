<template>
    <div>
        <div class="background">
            <img :src="img" width="100%" height="100%" alt="" />
        </div>
         <el-form :rules="rules" :model="loginForm" class="loginContainer" ref="loginFrom">
             <h2 class="loginTitle">室内定位系统</h2>
             <el-form-item prop="username">
                 <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="请输入用户名"></el-input>
             </el-form-item>
             <el-form-item prop="password">
                 <el-input type="password" v-model="loginForm.password" auto-complete="off" placeholder="请输入密码"></el-input>
             </el-form-item>
             <el-form-item>
                 <el-radio-group v-model="loginForm.radio" @change="changeStatus">
                     <el-radio label="1">访客</el-radio>
                     <el-radio label="2">工作人员</el-radio>
                     <el-radio label="3">管理员</el-radio>
                 </el-radio-group>
             </el-form-item>
             <label>记住我</label><el-checkbox class="loginRemenber" v-model="checked"></el-checkbox>
             <el-button type="primary" style="width: 100%" @click="submitlogin">确定</el-button>
             <el-form-item class="jumpButton">
                 <el-button @click="login">登录</el-button>
                 <el-button @click="register">注册</el-button>
             </el-form-item>
         </el-form>
    </div>
</template>

<script>
   // import {postKeyValueRequest} from "../utils/api";
   import img1 from "../assets/bg2.jpg";
   import {initMenu} from "../utils/menus";
    export default {
        name: "Login",
        data() {
            return{
                loginForm:{
                    radio: '1'
                },
                rules:{
                    username: [{required: true, message: '请输入用户名',trigger:'blur'}],
                    password: [{required: true, message: '请输入密码',trigger: 'blur'}]
                },
                checked: true,
                img:img1
            }
        },
        methods:{
            submitlogin() {
                this.$refs.loginFrom.validate((valid) => {
                    if (valid) {
                        this.postKeyValueRequest('/loginUser', this.loginForm).then(resp =>{
                            if(resp.success){
                                window.sessionStorage.setItem("user", JSON.stringify(resp.data));
                                this.$router.replace('/home');
                                this.$message.success("欢迎登录")
                            }
                            else{
                                this.$message.error(JSON.stringify(resp.data));
                            }
                        })
                    } else {
                        this.$message.error('请输入所有字段');
                        return false;
                    }
                });
            },
            login() {
                this.$router.replace('/');
            },
            register() {
                this.$router.replace('/register');
            },
            changeStatus(value){  //控制显隐性
                var that =this
            },
        }
    }
</script>

<style scoped>
      .loginContainer {
          border-radius:  15px;
          background-clip: padding-box;
          margin: auto auto auto auto;
          width: 350px;
          padding: 35px 35px 35px 35px;
          background-color: rgba(242, 239, 239,0.85);
          border: 2px solid #eaeaea;
          box-shadow: 0 0 25px #cac6c6;
          z-index:1;
          position: absolute;
          left:37%;
          top:20%;
      }
      .loginTitle{
          margin: 20px auto 20px  auto;
          text-align: center;
          color: #505458;
      }
      .loginRemenber{
          text-align: right;
          margin: 0px 0px 15px 5px;
      }
      .jumpButton{
          margin: 15px 0px 15px 0px;
      }
      .background{
          height: auto;
          z-index:-1;
          position: absolute;
      }

</style>