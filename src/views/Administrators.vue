<template>
    <baidu-map
            id="allmap"
            :scroll-wheel-zoom="true"
            @ready="mapReady">
        <el-drawer
                :visible.sync="table"
                direction="rtl"
                size="55%">
            <div class="screen">
                {{msg}}
            </div>
            <el-carousel :interval="3000" type="card" height="300px">
                <el-carousel-item v-for="(item,index) in cardData" :key="index">
                    <img :src="item.src" alt="" width=100% height="300px">
                </el-carousel-item>
            </el-carousel>

            <el-table :data="gridData" style="margin-top:20px;">
                <el-table-column property="name" label="负责人"></el-table-column>
                <el-table-column property="address" label="室内地址"></el-table-column>
                <el-table-column property="longitude" label="经度"></el-table-column>
                <el-table-column property="latitude" label="纬度"></el-table-column>
                <el-table-column property="in" label="当天室内访问量"></el-table-column>
                <el-table-column property="new" label="当天室内总新增"></el-table-column>
            </el-table>
            <el-button type="primary" icon="el-icon-search" @click="goto1" style="margin-top: 30px;margin-left: 280px">查看室内区域数据分析</el-button>
            <el-button type="success" icon="el-icon-search" @click="goto2" style="margin-top: 30px;">查看室内地图</el-button>
        </el-drawer>
    </baidu-map>

</template>

<script>
    /* eslint-disable */
    export default {
        name: 'Administrators',
        data(){
            return{
                msg:'北理珠IT大神的神秘办公地点知行楼独家曝光，知行合一，行胜于言，2014年9月知行楼正式投入使用，由国际知名建筑设计机构设计，建筑面积10000余平米。楼内设施齐全，规划科学合理，设备崭新性能先进，整体感觉大气美观。',
                point: "",
                sum_in :"0",
                sum_new :"0",
                name : '罗回彬',
                address : 'za102实验室',
                longitude:'113.54034',
                latitude:'22.375079',
                table: false,
                gridData: [],
                cardData: [
                    {id:1,src:require('../assets/1.jpg')},
                    {id:2,src:require('../assets/2.jpg')},
                    {id:3,src:require('../assets/3.jpg')},
                    {id:4,src:require('../assets/4.jpg')},
                    {id:5,src:require('../assets/5.jpg')}
                ]
            }
        },

        // 页面加载完成之后
        created(){
            //开启一个定时器
            setInterval(()=>{
                //substr截取字符串
                let frist=this.msg.substr(0,1)
                let other=this.msg.substr(1)
                let result=other+frist
                this.msg=result
            },400)},

        mounted () {  //提前加载数据进行初始化
            this.getRequest('/getSum',{}).then(resp => {
                if (resp.success) {
                    this.sum_in = resp.data.sum_in
                    this.sum_new = resp.data.sum_new
                } else {
                    this.$message.error(resp.data);
                }
            })
        },
        methods:{
            //地图设置
            mapReady({ BMap, map }) {
                // 选择一个经纬度作为中心点
                this.point = new BMap.Point(this.longitude,this.latitude);
                map.centerAndZoom(this.point, 30); //地图级别为30
                //for (let i = 0; i < res.data.data.length; i++) {
                let myMarker = new BMap.Marker(this.point)
                myMarker.setAnimation("BMAP_ANIMATION_DROP")
                //let point = new BMap.Point(lng, lat)
                //let name = '罗回彬'//res.data.data[i].username
                //let address = 'za102实验室'//res.data.data[i].address
                let gc = new BMap.Geocoder()
                gc.getLocation(this.point, res => {  //将位置坐标与事件进行绑定
                    map.addOverlay(myMarker)
                    this.addMouseover(myMarker, this.address, this.name, this.point, map)
                    this.addMouseout(myMarker, this.address, this.name, this.point, map)
                    this.addMouseclick(myMarker, this.address, this.name, this.point, map)
                })
                //}
            },

            //鼠标悬浮
            addMouseover (myMarker, address, name, point, map) {
                let opts = {
                    width: 100,
                    height: 80,
                    title: '===> 点击可查看室内区域详情'
                }

                myMarker.addEventListener('mouseover', e => {
                    this.getRequest('/getSum',{}).then(resp => {
                        if (resp.success) {
                            this.sum_in = resp.data.sum_in
                            this.sum_new = resp.data.sum_new
                        } else {
                            this.$message.error(resp.data);
                        }
                    })

                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 当天室内访问量：' + this.sum_in + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 当天室内总新增：' + this.sum_new + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.openInfoWindow(infoWindow, point)
                })
            },

            //鼠标离开
            addMouseout (myMarker, address, name, point, map) {
                //let sum_in = 0
                //let sum_new = 0
                let opts = {
                    width: 100,
                    height: 80,
                    title: '===> 点击可查看室内区域详情'
                }
                myMarker.addEventListener('mouseout', e => {
                    let shopadd = '<table>'
                    shopadd = shopadd + '<tr><td> 室内地址：'+address+'</td></tr>'
                    shopadd = shopadd + '<tr><td> 当天室内访问量：' + this.sum_in + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 当天室内总新增：' + this.sum_new + '</td></tr>'
                    shopadd = shopadd + '<tr><td> 负责人：'+name+'</td></tr>'
                    shopadd += '</table>'
                    let infoWindow = new BMap.InfoWindow(shopadd, opts)
                    map.closeInfoWindow(infoWindow, point)
                })
            },

            //鼠标点击
            addMouseclick (myMarker, address, name, point, map) {
                //let sum_in = 0
                //let sum_new = 0
                myMarker.addEventListener('click', e => {
                    this.gridData=[]
                    let add = {}
                    add.name=this.name
                    add.address=this.address
                    add.in=this.sum_in
                    add.new=this.sum_new
                    add.longitude=this.longitude
                    add.latitude=this.latitude
                    //将列表放到数组
                    this.gridData.push(add)
                    //false变true显示
                    this.table=!this.table
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
    /*卡片化走马灯*/
    .el-carousel__item h3 {
        color: #475669;
        font-size: 14px;
        opacity: 0.75;
        line-height: 200px;
        margin: 0;
    }
    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }
    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }

    /*字幕走马灯*/
    .screen{
        width: 100%;
        padding: 10px 10px;
        margin:0px auto 20px auto;
        background-color: red;
        white-space: nowrap;
        overflow: hidden;
        color: white;
        letter-spacing: 2px;
        text-indent: 1em;
    }
</style>


