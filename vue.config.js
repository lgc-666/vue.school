let proxyObj = {};
proxyObj['/'] = {
    ws:true,
    target: 'http://localhost:8081',
    changeOrigin: true,
    pathRewrite:{  //不修改拦截地址
        '^/':''
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
            "BMap": "BMap",
            "BMapLib": "BMapLib"
        }
    }
}