<template>
    <baidu-map
            id="allmap"
            :scroll-wheel-zoom="true"
            @ready="mapReady">
    </baidu-map>

</template>

<script>
    export default {
        name: 'Administrators',
        data(){
            return{
                table: false,
                gridData: [],
                user:JSON.parse(window.sessionStorage.getItem("user"))
            }
        },

        mounted () {  //提前加载数据进行初始化

        },
        methods:{
            //地图设置
            mapReady({ BMap, map }) {
                this.getRequest('/listMapMamageNoPage2',{}).then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++){
                            let address = resp.data[i].indoorname
                            let longitude = resp.data[i].longitude
                            let latitude = resp.data[i].latitude
                            let charge = resp.data[i].charge
                            let fmapid = resp.data[i].fmapid

                            // 选择一个经纬度作为中心点
                            let point = new BMap.Point(longitude,latitude);
                            map.centerAndZoom(point, 30); //地图级别为30
                            let myMarker = new BMap.Marker(point)
                            myMarker.setAnimation("BMAP_ANIMATION_DROP")
                            let gc = new BMap.Geocoder()
                            gc.getLocation(point, res => {  //将位置坐标与事件进行绑定
                                map.addOverlay(myMarker)   //给地图添加坐标
                                this.addMouseover(myMarker, address, charge,longitude,latitude,fmapid, point, map)
                                this.addMouseout(myMarker, address, charge,longitude,latitude,fmapid, point, map)
                                this.addMouseclick(myMarker, address, charge,longitude,latitude,fmapid, point, map)
                            })
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },

            //鼠标悬浮
            addMouseover (myMarker, address, name, longitude,latitude,fmapid,point, map) {
                let opts = {
                    width: 260,
                    height: 100,
                    title: '==> 室内区域详情'
                }

                myMarker.addEventListener('mouseover', e => {
                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 经度：'+longitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 纬度：'+latitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内地图ID：' + fmapid + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.openInfoWindow(infoWindow, point)
                })
            },

            //鼠标离开
            addMouseout (myMarker, address, name, longitude,latitude,fmapid,point, map) {
                let opts = {
                    width: 260,
                    height: 100,
                    title: '==> 室内区域详情'
                }
                myMarker.addEventListener('mouseout', e => {
                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 经度：'+longitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 纬度：'+latitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内地图ID：' + fmapid + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.closeInfoWindow(infoWindow, point)
                })
            },

            //鼠标点击(实现地图坐标与室内地图的关联)
            addMouseclick (myMarker, address, name, longitude,latitude,fmapid, point, map) {
                myMarker.addEventListener('click', e => {
                    this.$router.replace("/map");  //页面跳转
                    window.sessionStorage.setItem("indoor", JSON.stringify(address))
                })
            },

            goto1(){
                this.$router.replace("/data");  //页面跳转
            },
            goto2(){
                this.$router.replace("/map");  //页面跳转
            },
        }
    }
</script>

<style>
    /* 设定地图的大小 */
    #allmap{
        height: 100%;
        width: 100%;
        margin: 0 auto;
    }
</style>


