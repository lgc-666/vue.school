<template>
    <div>
        <div class="background">
            <img :src="img" width="100%" height="100%" alt="" />
        </div>
        <el-form :rules="rules" :model="registerForm" class="registerContainer" ref="registerForm">
            <h2 class="registerTitle">用户注册</h2>
            <el-form-item label="用户名" prop="username">
                <el-input type="text" v-model="registerForm.username" auto-complete="off" placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item label="密码" prop="password">
                <el-input type="password" v-model="registerForm.password" auto-complete="off" placeholder="设置密码不少于6位"></el-input>
            </el-form-item>
            <el-form-item label="确认密码" prop="checkPass">
                <el-input type="password" v-model="registerForm.checkPass" auto-complete="off" placeholder="请再次输入密码确认"></el-input>
            </el-form-item>
            <el-form-item>
                <el-radio-group v-model="registerForm.radio" @change="changeStatus">
                    <el-radio label="1" border>联系人</el-radio>
                    <el-radio label="2" border>教师</el-radio>
                </el-radio-group>
            </el-form-item>
            <el-form-item  style="margin-top: 0px" prop="studentname">
                <el-input :disabled="btnstatus" type="text" v-model="registerForm.studentname" auto-complete="off" placeholder="绑定的学生名"></el-input>
            </el-form-item>
            <el-button type="primary" style="width: 100%;margin-bottom: 10px;margin-top: 0px" @click="submitregister">确定</el-button>
            <el-button style="width: 100%;margin-left: 0px" @click="resetForm">重置</el-button>
            <el-form-item class="jumpButton">
                <el-button @click="login">登录</el-button>
                <el-button @click="register">注册</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import img1 from "../assets/bg2.jpg";

    export default {
        name: "Register",
        data() {
            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                }
                else if(value.length<6){
                    callback(new Error('密码不可小于6位'));
                }
                else {
                    if (this.registerForm.checkPass !== '') {
                        this.$refs.registerForm.validateField('checkPass');
                    }
                    callback();
                }
            };
            var validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.registerForm.password) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            var validatePass3 = (rule, value, callback) => {
                if (this.btnstatus==false&&value === '') {
                    callback(new Error('请输入要绑定的学生名'));
                }else {
                    callback();
                }
            };
            return{
                registerForm:{
                    username:'',
                    password:'',
                    checkPass:'',
                    studentname:'',
                    radio: '1'
                },
                rules:{
                    username: [{required: true, message: '用户名为必填项',trigger:'blur'}],
                    password: [{validator: validatePass,required: true,trigger: 'blur'}],
                    checkPass: [{validator: validatePass2,required: true,trigger: 'blur'}],
                    studentname: [{validator: validatePass3,trigger:'blur'}],
                },
                checked: true,
                //radio1: '1',
                btnstatus:false,
                img:img1
            }
        },
        methods:{
            submitregister() {
                this.$refs.registerForm.validate((valid) => {   //数字校验：有输入才请求接口
                    if (valid) {
                        //alert('submit!');
                        postKeyValueRequest('/register', this.registerForm).then(resp =>{
                            if(resp){
                                this.$message.success(JSON.stringify(resp.data));
                                this.$router.replace('/'); //页面跳转
                            }
                        })
                    } else {
                        this.$message.error('请输入所有字段');
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            resetForm() { //重置
                this.$refs.registerForm.resetFields();
            },
            changeStatus(value){  //控制显隐性
                console.log('改变之后的值是:' + value)
                console.log('raido改变之后的值是:' + this.registerForm.radio)
                if (value=='1'){
                    this.btnstatus=false
                }
                else if(value=='2'){
                    this.btnstatus=true
                }
            },
            login() {
                this.$router.replace('/'); //跳转登录页面
            },
            register() {
                this.$router.replace('/register'); //跳转注册页面
            }
        },
        computed: {
            phone () {
                if (this.tel === ""){
                    return ''
                }else if(!/^[1][3,4,5,7,8][0-9]{9}$/.test(this.tel)){
                    return '手机号格式错误'
                }else {
                    return ''
                }
            }
        },
    }
</script>

<style scoped>
    .registerContainer {
        border-radius:  15px;
        background-clip: padding-box;
        margin: auto;
        width: 350px;
        padding: 35px 35px 35px 35px;
        background-color: rgba(242, 239, 239,0.85);
        border: 2px solid #eaeaea;
        box-shadow: 0 0 25px #cac6c6;
        z-index:1;
        position: absolute;
        left:37%;
        top:10%;
    }
    .registerTitle{
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