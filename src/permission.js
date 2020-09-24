import router from './router'
import store from './store'
import NProgress from 'nprogress' // Progress 进度条
import 'nprogress/nprogress.css'
import {Message} from "element-ui";
import {initMenu} from "./utils/menus";

// Progress 进度条样式
//全局钩子（全局前置导航守卫）
router.beforeEach((to, from, next) => {
    //NProgress.start(); // 开启Progress
    if (to.path ==="/"|| to.path ==='/register'){ //本来访问登录注册的可以通过，否则全部访问登录
        next();
    }
    else{
        if(sessionStorage.getItem('user'))
        {
            initMenu(router,store);
            console.log("加载菜单完毕");
            next();
        }else {
            next('/');
            Message.error({message:'尚未登录，请登录'});
        }
    }
    //NProgress.done();
});

router.afterEach((to, from) => {
    if(to.path ==="/"|| to.path ==='/register'){
        console.log("进来登录注册页面了哦");
    }
    else{
        console.log("进来页面了哦");

    }
    //NProgress.done(); // 结束Progress
});
