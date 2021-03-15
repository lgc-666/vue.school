<template>
    <div>
        <div style="width: 100%;height: 50px">
            <div style="float: left;font-size: 20px;margin-top: 15px;margin-right: 10px;margin-left: 25px">室内地址:</div>
            <div style="margin-top: 5px;float: left;">
                <el-select v-model="shopMap" style="width: 100px" @change="changeaddress">
                    <el-option v-for="(item, index) in indoordata"
                               :key="index"
                               :value="item.label"
                               :label="item.label">
                    </el-option>
                </el-select>
            </div>
            <el-button-group style="margin-top: 5px;margin-left: 315px">
                <el-button icon="el-icon-search" @click="goto1">坐标图</el-button>
                <el-button icon="el-icon-search" @click="goto2">热力图</el-button>
                <el-button type="info" icon="el-icon-search" @click="goto3">轨迹图</el-button>
            </el-button-group>
            <el-button type="primary" round @click="btnquery" style="margin-top: 5px;float: right;margin-left: 10px;margin-right: 80px">查询信息</el-button>
            <el-input v-model="staffdata" style="width: 220px;float: right;margin-right:10px;margin-top: 5px;" :placeholder=placeholder @focus="blurSearchFor()" @blur="blurSear" v-if="showinput"></el-input>
        </div>
        <div id="fmap"></div>
    </div>
</template>

<script>
    import "../utils/lib/fengmap.core.min"; //核心包
    import "../utils/lib/fengmap.control.min"; //控件
    import "../utils/lib/fengmap.analyzer.min"; //路径分析类
    import "../utils/lib/fengmap.navi.min"; //导航类
    import "../utils/lib/fengmap.min";
    import img1 from "../assets/start.png";
    import img2 from "../assets/end.png";
    import {transform} from "../utils/transform";
    import {Message} from "element-ui";

    export default {
        name: "Trave",
        data () {
            this.map = null
            return {
                placeholder: '请输入即将要查询的mac地址',
                showinput: true,
                staffdata:'',
                flag:'',
                indoordata:[],
                shopMap:'',
            }
        },
        mounted () {
            this.checkJurisdiction2()
            this.openMap()
        },
        methods: {
            changeaddress () {   //通过选择按钮改变所选区域
                window.sessionStorage.setItem("indoor", JSON.stringify(this.shopMap))
                this.btn1()
            },
            checkJurisdiction2 () {   //返回地图列表
                this.getRequest('/listMapMamageNoPage',{}).then(resp => {
                    if (resp.success) {
                        console.log('data的长度是:' + resp.data.length)
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].indoorname
                            this.indoordata.push(add)
                        }
                        //初始化值
                        if(window.sessionStorage.getItem("indoor")!=null&&window.sessionStorage.getItem("indoor")!=''){
                            this.shopMap=JSON.parse(window.sessionStorage.getItem("indoor"))
                        }
                        else {
                            this.shopMap = this.indoordata[0].label
                            window.sessionStorage.setItem("indoor", JSON.stringify(this.indoordata[0].label));
                        }
                    } else {
                        //this.$message.error(resp.data);
                    }
                })
            },

            goto1(){
                this.$router.replace("/map");  //页面跳转
            },
            goto2(){
                this.$router.replace("/hot");  //页面跳转
            },
            goto3(){
                this.$router.replace("/trave");  //页面跳转
            },


            openMap () {
                this.flag=0
                this.getRequest('/listMapMamageSearchByIndoorname',{staffdata:JSON.parse(window.sessionStorage.getItem("indoor"))}).then(resp => {
                    if (resp.success) {
                        console.log('data进入值是:' + JSON.stringify(resp.data))
                        // '1315702510946439169'
                        let fmapID = resp.data.fmapid
                        let mapOptions = {
                            container: document.getElementById('fmap'),
                            // 必要，地图应用名称，通过蜂鸟云后台创建
                            appName: 'za102',
                            // 必要，地图应用密钥，通过蜂鸟云后台获取
                            key: 'cc13bc8c80c3cbdc44813dfc015321af',
                            //defaultViewMode: fengmap.FMViewMode.MODE_2D,
                            defaultMapScale: 250
                        }
                        this.map = new fengmap.FMMap(mapOptions)
                        this.map.openMapById(fmapID, (error) => {
                            console.log(error)
                        })

                        this.map.on('loadComplete', () => {
                            console.log('地图加载完成！')
                            this.loadScrollFloorCtrl()
                            //设置地图的旋转角为10度,摆正地图
                            this.map.rotateAngle=10
                        })
                        clearTimeout(this.timer);  //清除延迟执行

                        this.timer = setTimeout(()=>{   //设置延迟1s执行给地图加载的时间
                            this.btn2()
                            console.log('ok');
                        },800);

                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },


            // 加载滚动型楼层切换控件
            loadScrollFloorCtrl () {
                let scrollFloorCtlOpt = {
                    position: fengmap.FMControlPosition.RIGHT_TOP,
                    showBtnCount: 1,
                    allLayer:false,   //初始是否是多层显示，默认单层显示
                    needAllLayerBtn: false, //是否显示多层/单层切换按钮
                    offset: {
                        x: -20,
                        y: 90
                    },
                    // 配置图片资源的路径地址，'./'是在static文件下
                    imgURL: '../assets/images/'
                }

                let scrollFloorControl = new fengmap.FMScrollGroupsControl(
                    this.map,
                    scrollFloorCtlOpt
                )
                // 楼层切换
                scrollFloorControl.onChange((groups, allLayer) => {
                    console.log(groups)
                })
                this.map.on('mapClickNode', function(event) {
                    // 打印出点击处的地图坐标
                    console.log(event.eventInfo.coord);
                    //  Message.info('x：'+event.eventInfo.coord.x+'，y：'+event.eventInfo.coord.y);
                });
            },

            btn2 () {
                console.log('地图已切换');
            },

            btn1 () {
                this.$router.replace("/administrators");
                setTimeout(() => {
                    this.$router.replace("/trave");
                },100)

                console.log('坐标已显示');
            },

            blurSearchFor () {
                if (this.placeholder === '请输入即将要查询的mac地址') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '请输入即将要查询的mac地址'
            },
            //文字标注
            locationMarkerstartend(str,x2,y2){
                let groupLayer = this.map.getFMGroup(this.map.focusGroupID);
                let layer = new fengmap.FMTextMarkerLayer();   //实例化TextMarkerLayer
                groupLayer.addLayer(layer);    //添加文本标注层到模型层。否则地图上不会显示
                //图标标注对象，默认位置为该楼层中心点
                let tm = new fengmap.FMTextMarker({
                    name: str,
                    x: x2,
                    y: y2,
                    height:1.5,
                    //文字标注样式设置
                    fillcolor: "0,0,0", //填充色
                    fontsize:15, //字体大小
                    strokecolor: "255,255,0", //边框色
                    alpha: 0.5   //文本标注透明度,
                });
                layer.addMarker(tm);  //文本标注层添加文本Marker
                tm.alwaysShow();    // 在marker载入完成后，设置 "一直可见"，不被其他层遮挡
            },
            btnquery () {
                if (this.staffdata === '') {
                } else {
                        window.sessionStorage.setItem('staffdata', this.staffdata)
                   // setTimeout(() => {
                        this.getRequest('/listByMac', {mac: window.sessionStorage.getItem("staffdata"),indoorname:JSON.parse(window.sessionStorage.getItem("indoor"))}).then(resp => {
                            console.log('值2是:' + resp.data[0].x)
                            let data = []
                            //原始坐标
                            let origonParas = [];
                            origonParas[0] = {'x': 0, 'y': 0};
                            origonParas[1] = {'x': 60, 'y': 0};
                            origonParas[2] = {'x': 0, 'y': 30};

                            //目标坐标系
                            let targetParas = [];
                            targetParas[0] = {'x': 12639230.54497627, 'y': 2556606.714786814};
                            targetParas[1] = {'x': 12639290.783923365, 'y': 2556606.7894323496};
                            targetParas[2] = {'x': 12639230.992849482, 'y': 2556636.8715831297};

                            if (resp.success) {
                                for (let i = 0; i < resp.data.length; i++) {
                                    //坐标转换结果
                                    let toTran = transform(origonParas, targetParas, resp.data[i].x, resp.data[i].y);
                                    console.log('转换后:' + toTran.x)
                                    //增加热点
                                    data[i] = {
                                        x: toTran.x,
                                        y: toTran.y,
                                        value: 50
                                    }
                                }

                                // 实例化定位标注对象(起点)
                                let locationMarker = new fengmap.FMLocationMarker({
                                    url: img1,
                                    size: 30,  //设置图片显示尺寸
                                    height: 1,  //marker标注高度
                                });
                                this.map.addLocationMarker(locationMarker);
                                //实际图上的x、y需要经过坐标转换才能变成屏幕上的大坐标（转换方法看桌面的图）
                                locationMarker.setPosition({
                                    x: data[0].x,
                                    y: data[0].y,
                                    groupID: this.map.focusGroupID  //设置定位点所在楼层
                                });

                                locationMarker.alwaysShow();


                                this.locationMarkerstartend(''+resp.data[0].mac+'的起点', data[0].x, data[0].y)

                                // 实例化定位标注对象(终点)
                                let locationMarker2 = new fengmap.FMLocationMarker({
                                    url: img2,
                                    size: 30,  //设置图片显示尺寸
                                    height: 1,  //marker标注高度
                                });
                                this.map.addLocationMarker(locationMarker2);
                                //实际图上的x、y需要经过坐标转换才能变成屏幕上的大坐标（转换方法看桌面的图）
                                locationMarker2.setPosition({
                                    x: data[data.length - 1].x,
                                    y: data[data.length - 1].y,
                                    groupID: this.map.focusGroupID  //设置定位点所在楼层
                                });
                                //locationMarker2.alwaysShow();
                                this.locationMarkerstartend('终点', data[data.length - 1].x, data[data.length - 1].y)


                                //初始化线图层
                                let line = new fengmap.FMLineMarker();
                                //楼层id
                                let gid = this.map.focusGroupID;
                                //路径线点集合
                                let points = data;

                                let points3d = [];
                                points.forEach(function (point) {
                                    points3d.push({
                                        //x坐标点
                                        'x': point.x,
                                        //y坐标点
                                        'y': point.y,
                                        //线标注高度
                                        'z': 1
                                    });
                                });
                                //fengmap.FMSegment点集，一个点集代表一条折线
                                let seg = new fengmap.FMSegment();
                                seg.groupId = gid;
                                seg.points = points3d;
                                line.addSegment(seg);
                                //绘制线
                                //配置线型、线宽、透明度等
                                let lineStyle = {
                                    //设置线的宽度
                                    lineWidth: 6,
                                    //设置线的透明度
                                    alpha: 0.8,
                                    //设置线的类型为导航线
                                    lineType: fengmap.FMLineType.FMARROW,
                                    //设置线动画,false为动画
                                    noAnimate: false
                                };
                                this.map.drawLineMark(line, lineStyle);
                            } else {
                                this.$message.error(JSON.stringify(resp.data));
                            }
                        })
                   // },1000)
              }
            },
        }
    }
</script>

<style scoped>
    #fmap{
        width: 100%;
        height: 600px;
    }
</style>