import {getRequest} from "./api"
import router from "../router";

export const initMenu=(router,store)=>{ //传2个参数，分别是菜单路由，而且要备份到store
    if(store.state.routes.length>0){  //routes大于0说明有store有缓存，直接返回
        return;
    }
    getRequest('/menu').then(data=>{
        if(data){
            let fmtRoutes = formatRoutes(data); //调用下面的格式化方法
            console.log(JSON.stringify(fmtRoutes));
            router.addRoutes(fmtRoutes);  //添加路由，相当于在router的index.js里配置了路由
            store.commit('initRoutes', fmtRoutes); //用commit调用store中的方法，第一个参数是方法名，第2个是参数
        }
    })
}

export const formatRoutes = (routes) =>{
    let fmRoutes = [];
    routes.forEach(router=>{  //批量给router对象定义变量赋值
        let {
            path,
            component,
            name,
            iconcls,
            child
        } =router;
        if (child && child instanceof Array){ //如果child存在且是一个数组，即它有子节点菜单，此时用递归调用
            child=formatRoutes(child);  //再遍历
        }
        let fmRouter = {  //修改component从字符串变成动态路由
                path:path,
                name:name,
                iconCls:iconcls,
                children:child,
                component(resolve){
                    require(['../views/'+component+'.vue'], resolve);
                }
        }
        fmRoutes.push(fmRouter);  //把路由加到数组里面
    })
    return fmRoutes;
}