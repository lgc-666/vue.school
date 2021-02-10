import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Home from "../views/Home";
import Register from "../views/Register";
import Account from "../views/Account";
import Permission from "../views/Permission";
import Map from "../views/Map";
import Hot from "../views/Hot";
import Trave from "../views/Trave";

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
                path: '/permission',
                name: 'Permission',
                component: Permission
            },
            {
                path: '/map',
                name: '坐标图',
                component: Map
            },
            {
                path: '/hot',
                name: '热力图',
                component: Hot
            },
            {
                path: '/trave',
                name: '轨迹图',
                component: Trave
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
