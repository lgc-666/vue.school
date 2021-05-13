import router from './router'
import store from './store'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import {Message} from "element-ui";
import {initMenu} from "./utils/menus";

router.beforeEach((to, from, next) => {
    if (to.path ==="/"|| to.path ==='/register'){
        next();
    }
    else{
        if(sessionStorage.getItem('user'))
        {
            initMenu(router,store);
            next();
        }else {
            next('/');
            Message.error({message:'尚未登录或登录已过期'});
        }
    }
});

router.afterEach((to, from) => {
    if(to.path ==="/"|| to.path ==='/register'){
        console.log("进来登录注册页面了哦");
    }
    else{
        console.log("进来页面了哦");
    }
});
