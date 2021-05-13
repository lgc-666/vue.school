<template>
    <div>
    <div style="width: 100%;height: 50px">
        <el-button type="success" round @click="btn1" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 30px">刷新</el-button>
        <el-button type="primary" round @click="openHeatmap" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;">显示热力图</el-button>
        <el-button type="info" round @click="closeHeatmap" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;">关闭热力图</el-button>
        <el-time-picker style="margin-left: 220px;margin-top: 5px;" @change="changeaddress"
                        is-range
                        v-model="value6"
                        range-separator="至"
                        start-placeholder="当天开始时间"
                        end-placeholder="当天结束时间"
                        placeholder="选择时间范围">
        </el-time-picker>
        <el-button type="primary" round @click="location" style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 10px">查询信息</el-button>
        <el-input v-model="staffdata2" style="width: 250px;float: right;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
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
                staffdata2:'',
                points: [],
                heatmapOverlay: {},// 热力图覆盖物,
                map: '',// 保存地图实例
                indoornameMap:[],
                trackPoint:[],
                value6: [new Date(),new Date()],
            }
        },

        mounted () {
                this.sum()
        },
        methods:{
            changeaddress () {
                window.sessionStorage.setItem("start4", this.value6[0])
                window.sessionStorage.setItem("end4", this.value6[1])
            },
            btn3 () {
                this.$router.replace("/machine");
                setTimeout(() => {
                    this.$router.replace("/administrators");
                },100)
            },

            formateDate(datetime) {
                function addDateZero(num) {
                    return (num < 10 ? "0" + num : num);
                }
                let c = new Date()
                let d = new Date(datetime);
                let formatdatetime = c.getFullYear() + '-' + addDateZero(c.getMonth() + 1) + '-' + addDateZero(c.getDate()) + ' ' + addDateZero(d.getHours()) + ':' + addDateZero(d.getMinutes()) + ':' + addDateZero(d.getSeconds());
                return formatdatetime;
            },
            location(){
                    //this.injude()
                this.sum()
                this.map.clearOverlays();
                setTimeout(() => {
                    this.getRequest('/listMapMamageNoPage2',{}).then(resp => {
                        if (resp.success) {
                            for (let i = 0; i < resp.data.length; i++){
                                let address = resp.data[i].indoorname
                                let longitude = resp.data[i].longitude
                                let latitude = resp.data[i].latitude
                                let charge = resp.data[i].charge
                                let fmapid = resp.data[i].fmapid

                                let d = this.indoornameMap[address]
                                let add = {}
                                add.lng = longitude
                                add.lat = latitude
                                add.count = d
                                this.points.push(add)

                                let point = new BMap.Point(longitude,latitude);
                                this.map.centerAndZoom(point, 30);
                                let myMarker = new BMap.Marker(point)
                                myMarker.setAnimation("BMAP_ANIMATION_DROP")
                                myMarker.setTop('true');
                                let gc = new BMap.Geocoder()
                                gc.getLocation(point, res => {
                                    this.map.addOverlay(myMarker)
                                    this.addMouseover(myMarker, address, charge,longitude,latitude,fmapid, point,d, this.map)
                                    this.addMouseout(myMarker, address, charge,longitude,latitude,fmapid, point,d, this.map)
                                    this.addMouseclick(myMarker, address, charge,longitude,latitude,fmapid, point,d, this.map)
                                })
                            }
                        } else {
                            this.$message.error(resp.data);
                        }
                    })
                }, 200);
                if (this.staffdata2 === '') {
                } else {
                    window.sessionStorage.setItem('staffdata2', this.staffdata2)
                    setTimeout(() => {
                        this.points=[]
                        this.trackPoint=[]
                        this.getRequest('/mapByMac', {
                            mac: window.sessionStorage.getItem("staffdata2"),
                            start: this.formateDate(window.sessionStorage.getItem("start4")),
                            end: this.formateDate(window.sessionStorage.getItem("end4"))
                        }).then(resp => {
                            if (resp.success) {
                                for (let i = 0; i < resp.data.length; i++) {
                                    let address = resp.data[i].indoorname
                                    let longitude = resp.data[i].longitude
                                    let latitude = resp.data[i].latitude
                                    let charge = resp.data[i].charge
                                    let fmapid = resp.data[i].fmapid

                                    let d = this.indoornameMap[address]

                                    let add = {}
                                    add.lng = longitude
                                    add.lat = latitude
                                    add.count = d
                                    this.points.push(add)

                                    let point = new BMap.Point(longitude, latitude);
                                    this.trackPoint.push(point);
                                    this.map.centerAndZoom(point, 30);
                                    let myMarker = new BMap.Marker(point)
                                    myMarker.setAnimation("BMAP_ANIMATION_DROP")
                                    myMarker.setTop('true');
                                    let gc = new BMap.Geocoder()
                                    if(i===(resp.data.length-1)||resp.data.length===1){
                                        gc.getLocation(point, res => {
                                            this.map.addOverlay(myMarker)
                                            this.addMouseover2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'终点')
                                            this.addMouseout2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'终点')
                                            this.addMouseclick(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map)
                                        })
                                    }
                                    else if(i===0){
                                        gc.getLocation(point, res => {
                                            this.map.addOverlay(myMarker)
                                            this.addMouseover2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'起点')
                                            this.addMouseout2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'起点')
                                            this.addMouseclick(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map)
                                        })
                                    }
                                    else{
                                        gc.getLocation(point, res => {
                                            this.map.addOverlay(myMarker)
                                            this.addMouseover2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'途径点')
                                            this.addMouseout2(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map,'途径点')
                                            this.addMouseclick(myMarker, address, charge, longitude, latitude, fmapid, point, d, this.map)
                                        })
                                    }
                                }

                                var polyline = new BMap.Polyline(this.trackPoint, {
                                    strokeColor: "#1869AD",
                                    strokeWeight: 3,
                                    strokeOpacity: 1
                                });
                                this.map.addOverlay(polyline);
                                this.trackPoint = []
                            } else {
                                this.$message.error(resp.data);
                            }
                        })
                    }, 400);
                }
            },

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
                            let add = {}
                            add.lng = longitude
                            add.lat = latitude
                            add.count = d
                            this.points.push(add)

                            let point = new BMap.Point(longitude,latitude);
                            map.centerAndZoom(point, 30);
                            let myMarker = new BMap.Marker(point)
                            myMarker.setAnimation("BMAP_ANIMATION_DROP")
                            let gc = new BMap.Geocoder()
                            gc.getLocation(point, res => {
                                map.addOverlay(myMarker)
                                this.addMouseover(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                                this.addMouseout(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                                this.addMouseclick(myMarker, address, charge,longitude,latitude,fmapid, point,d, map)
                            })
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })
            }, 200);
            },

            injude(){
                if(window.sessionStorage.getItem("start4")===null||window.sessionStorage.getItem("end4")===null||window.sessionStorage.getItem("start4")===''||window.sessionStorage.getItem("end4")===''){
                    window.sessionStorage.setItem("start4", this.value6[0]);
                    window.sessionStorage.setItem("end4", this.value6[1]);

                }
                else {
                    this.value6=[window.sessionStorage.getItem("start4"),window.sessionStorage.getItem("end4")]
                }
            },

            sum() {
                this.injude()
                this.getRequest('/getSumData',{}).then(resp => {
                    if (resp.success) {
                        if (resp.data!=null){
                            this.indoornameMap=resp.data
                        }
                    } else {
                        this.$message.error(resp.data);
                    }
                })

            },


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

            addMouseclick (myMarker, address, name, longitude,latitude,fmapid, point,d, map) {
                myMarker.addEventListener('click', e => {
                    this.$router.replace("/map");
                    window.sessionStorage.setItem("indoor", JSON.stringify(address))
                })
            },

            //鼠标悬浮
            addMouseover2 (myMarker, address, name, longitude,latitude,fmapid,point,d, map,title) {
                let opts = {
                    width: 260,
                    height: 120,
                    title: '==> '+title
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


            addMouseout2 (myMarker, address, name, longitude,latitude,fmapid,point,d, map,title) {
                let opts = {
                    width: 260,
                    height: 120,
                    title: '==> '+title
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

            this.heatmapOverlay.hide();
            },

            initHeatMap () {
                this.heatmapOverlay = new BMapLib.HeatmapOverlay({
                    'radius': BMAP_POINT_SIZE_SMALL * 13,
                    'opacity': 0.7,
                    'gradient': {
                        0:'rgb(213,219,200)',
                        0.3:'rgb(255,0,0)',
                        1:'rgba(198,16,80,0.9)'
                    }
                })
                this.map.addOverlay(this.heatmapOverlay);
                this.heatmapOverlay.setDataSet({data: this.points, max: 8});
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


