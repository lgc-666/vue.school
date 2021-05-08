<template>
    <div>
    <div style="width: 100%;height: 50px">
        <el-button type="success" round @click="btn1" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
        <el-button type="primary" round @click="openHeatmap" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;">显示热力图</el-button>
        <el-button type="info" round @click="closeHeatmap" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;">关闭热力图</el-button>
        <el-button type="primary" round style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 10px">查询信息</el-button>
        <el-input v-model="staffdata" style="width: 250px;float: right;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
    </div>
    <div style="width: 100%;height: 780px">
    <baidu-map
            id="allmap"
            :scroll-wheel-zoom="true"
            @ready="mapReady">
    </baidu-map>
    </div>
    </div>
</template>

<script>
    import "heatmap.js";
    export default {
        name: 'Administrators',
        data(){
            return{
                table: false,
                gridData: [],
                user:JSON.parse(window.sessionStorage.getItem("user")),
                showinput: true,
                placeholder: '根据mac地址查询路径',
                staffdata:'',
                points: [],
                heatmapOverlay: {},// 热力图覆盖物,
                map: '',// 保存地图实例
                indoornameMap:[]
            }
        },

        mounted () {  //提前加载数据进行初始化
                this.sum()
        },
        methods:{
            //地图设置
            mapReady({ BMap, map }) {
                setTimeout(() => {
                this.getRequest('/listMapMamageNoPage2',{}).then(resp => {
                    if (resp.success) {
                        this.map = map
                        for (let i = 0; i < resp.data.length; i++){
                            let address = resp.data[i].indoorname
                            let longitude = resp.data[i].longitude
                            let latitude = resp.data[i].latitude
                            let charge = resp.data[i].charge
                            let fmapid = resp.data[i].fmapid

                            let d = this.indoornameMap[address]
                            console.log('map值2是:' + d)
                            let add = {}
                            add.lng = longitude
                            add.lat = latitude
                            add.count = d
                            this.points.push(add)

                            // 选择一个经纬度作为中心点
                            let point = new BMap.Point(longitude,latitude);
                            map.centerAndZoom(point, 30); //地图级别为30
                            let myMarker = new BMap.Marker(point)
                            myMarker.setAnimation("BMAP_ANIMATION_DROP")
                            let gc = new BMap.Geocoder()
                            gc.getLocation(point, res => {  //将位置坐标与事件进行绑定
                                map.addOverlay(myMarker)   //给地图添加坐标
                                this.addMouseover(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                                this.addMouseout(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                                this.addMouseclick(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                            })
                        }
                        //console.log('map值3是:' + this.points)
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            }, 200);
            },

            sum() {
                this.getRequest('/getSumData',{}).then(resp => {
                    if (resp.success) {
                        if (resp.data!=null){
                            console.log('map值是:' + resp.data)
                            this.indoornameMap=resp.data
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })

            },

            //鼠标悬浮
            addMouseover (myMarker, address, name, longitude,latitude,fmapid,point,d, map) {
                let opts = {
                    width: 260,
                    height: 120,
                    title: '==> 室内区域详情'
                }

                myMarker.addEventListener('mouseover', e => {
                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 经度：'+longitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 纬度：'+latitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内地图ID：' + fmapid + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内总人数：'+d+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.openInfoWindow(infoWindow, point)
                })
            },

            //鼠标离开
            addMouseout (myMarker, address, name, longitude,latitude,fmapid,point,d, map) {
                let opts = {
                    width: 260,
                    height: 120,
                    title: '==> 室内区域详情'
                }
                myMarker.addEventListener('mouseout', e => {
                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 经度：'+longitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 纬度：'+latitude+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内地图ID：' + fmapid + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 室内总人数：'+d+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.closeInfoWindow(infoWindow, point)
                })
            },

            //鼠标点击(实现地图坐标与室内地图的关联)
            addMouseclick (myMarker, address, name, longitude,latitude,fmapid, point,d, map) {
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

            blurSearchFor () {
                if (this.placeholder === '根据mac地址查询路径') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '根据mac地址查询路径'
            },
            openHeatmap (){
                this.initHeatMap()
            },
            closeHeatmap (){
           //隐藏热力图
            this.heatmapOverlay.hide();
            },
            // 方法 - 添加热力图覆盖物
            initHeatMap () {
                this.heatmapOverlay = new BMapLib.HeatmapOverlay({
                    // 热力图的每个点的半径大小
                    'radius': BMAP_POINT_SIZE_SMALL * 13,
                    // 热力的透明度0~1
                    'opacity': 0.7,
                    // 其中 key 表示插值的位置0~1，value 为颜色值,渐变区间,起始颜色,中间颜色,结束颜色
                    'gradient': {
                        0:'rgb(213,219,200)',
                        0.3:'rgb(255,0,0)',
                        1:'rgba(198,16,80,0.9)'
                    }
                })
                // 清除图层(每次重新调用需要清除上一个覆盖物图层)
                //this.map.clearOverlays();
                // 添加热力覆盖物
                this.map.addOverlay(this.heatmapOverlay);
                this.heatmapOverlay.setDataSet({data: this.points, max: 8});
                // 显示热力图
                this.heatmapOverlay.show();
            },
            btn1 () {
                location. reload()
            },

        }
    }
</script>

<style>
    /* 设定地图的大小 */
    #allmap{
        height: 100%;
        width: 100%;
        margin: auto;
    }
</style>


