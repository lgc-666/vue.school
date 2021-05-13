import {getRequest} from "./api"
import router from "../router";

export const initMenu=(router,store)=>{
    if(store.state.routes.length>0){
        return;
    }
    getRequest('/menu').then(data=>{
        if(data){
            let fmtRoutes = formatRoutes(data);
            console.log(JSON.stringify(fmtRoutes));
            router.addRoutes(fmtRoutes);
            store.commit('initRoutes', fmtRoutes);
        }
    })
}

export const formatRoutes = (routes) =>{
    let fmRoutes = [];
    routes.forEach(router=>{
        let {
            path,
            component,
            name,
            iconcls,
            child
        } =router;
        if (child && child instanceof Array){
            child=formatRoutes(child);
        }
        let fmRouter = {
                path:path,
                name:name,
                iconCls:iconcls,
                children:child,
                component(resolve){
                    require(['../views/'+component+'.vue'], resolve);
                }
        }
        fmRoutes.push(fmRouter);
    })
    return fmRoutes;
}