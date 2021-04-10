let proxyObj = {};
proxyObj['/za102'] = {
    ws:true,
    target: 'http://liaoguanchang.top:8081',
    changeOrigin: true,
    pathRewrite:{  //不修改拦截地址
        '^/za102':''
    }
}
module.exports = {
    devServer:{
        host:'localhost',
        port: 8080,
        proxy: proxyObj
    },
    configureWebpack: {
        externals: {
            "BMap": "BMap"
        }
    }
}