import axios from 'axios'
import { Message } from 'element-ui';

axios.interceptors.response.use(success=>{
    console.log('状态码是:' + success.status)
    console.log('过滤器-响应值是:' + success.data.data)
    console.log('过滤器-响应值是:' + JSON.stringify(success.data))
    if(success.status && success.status == 200)
    {
        if(success.data.code == 401 || success.data.code == 403){
            Message.error({message: success.data.data})
            return;
        }
    }
    //if(success.data.message){
      //  Message.success({message:success.data.message})
    //}
    return success.data;
},error => {
    if(error.response.status == 504 || error.response.status == 404)
    {
        Message.error({message:'找不到服务器'})
    }
    else if (error.response.status == 403)
    {
        Message.error({message:'权限不足请联系管理员'})
    }
    else if (error.response.status == 401)
    {
        Message.error({message:'尚未登录或登录已过期，请重新登录'})
    }
    else {
        if(error.response.data.msg)
        {
            Message.error({message:error.response.data.msg})
        }
        else {
            Message.error({message: '未知错误！'})
        }
    }
    return;
})

let base = '';

export const postKeyValueRequest=(url,params)=>{  //只是登录用（Spring Security 中默认的登录数据格式就是 key/value 的形式）
    return axios({
        method:'post',
        url:`${base}${url}`,
        params:params,
        transformRequest:[function (data) {
             let ret = '';
             for (let i in data){
                 ret+=encodeURIComponent(i)+'='+encodeURIComponent(data[i])+'&'
             }
             return ret;
        }],
        //header:{
         //   'Content-Type':'application/x-www-form-urlencoded'
        //}
    })
}

export const putRequest=(url,parms)=>{
    console.log('是:' + parms)
    return axios({
        method: 'put',
        url: `${base}${url}`,
        params: parms,
        transformRequest:[function (data) {
            let ret = '';
            for (let i in data){
                ret+=encodeURIComponent(i)+'='+encodeURIComponent(data[i])+'&'
            }
            return ret;
        }],
    })
}

export const getRequest=(url,parms)=>{
    return axios({
        method: 'get',
        url: `${base}${url}`,
        params: parms,
        transformRequest:[function (data) {
            let ret = '';
            for (let i in data){
                ret+=encodeURIComponent(i)+'='+encodeURIComponent(data[i])+'&'
            }
            return ret;
        }],
    })
}

export const deleteRequest=(url,parms)=>{
    return axios({
        method: 'delete',
        url: `${base}${url}`,
        params: parms,
        transformRequest:[function (data) {
            let ret = '';
            for (let i in data){
                ret+=encodeURIComponent(i)+'='+encodeURIComponent(data[i])+'&'
            }
            return ret;
        }],
    })
}