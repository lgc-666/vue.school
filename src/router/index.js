import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Home from "../views/Home";
import Register from "../views/Register";
import Account from "../views/Account";
import Permission from "../views/Permission";

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Login',
        component: Login,
        hidden:true
    },
    {
        path: '/register',
        name: 'Register',
        component: Register,
        hidden:true
    },
    {
        path: '/home',
        name: '菜单',
        component: Home,
        children:[
            {
                path: '/account',
                name: '选项1',
                component: Account
            },
            {
                path: '/permission',
                name: '选项2',
                component: Permission
            },
        ]
    },

]

const router = new VueRouter({
    routes
})

//解决路由重复的报错
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

export default router
