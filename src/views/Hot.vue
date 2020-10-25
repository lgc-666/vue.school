<template>
    <div>
        <div style="width: 100%;height: 50px">
            <el-button type="primary" round @click="btn2" icon="el-icon-refresh-right" style="float: left;margin-top: 5px;margin-left: 30px">坐标显示/刷新</el-button>
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
    import img from "../assets/blueImageMarker.png";
    import {transform} from "../utils/transform";
    import {Message} from "element-ui";

    export default {
        name: "Hot",
        data () {
            this.map = null
            return {}
        },
        mounted () {
            this.openMap()
        },
        methods: {
            openMap () {
                let fmapID = '1315702510946439169'
                let mapOptions = {
                    container: document.getElementById('fmap'),
                    // 必要，地图应用名称，通过蜂鸟云后台创建
                    appName: 'za102',
                    // 必要，地图应用密钥，通过蜂鸟云后台获取
                    key: 'cc13bc8c80c3cbdc44813dfc015321af',
                    defaultViewMode: fengmap.FMViewMode.MODE_2D,
                    defaultMapScale: 250
                }
                this.map = new fengmap.FMMap(mapOptions)
                this.map.openMapById(fmapID, (error) => {
                    console.log(error)
                })


                this.map.on('loadComplete', () => {
                    console.log('地图加载完成！')
                    this.loadScrollFloorCtrl()
                    //设置地图的旋转角为0度,摆正地图
                    this.map.rotateAngle=0
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
                this.locationMarker2()
                console.log('坐标已显示');
            },

            locationMarker2(){
                this.getRequest('/getDBlocationNotRepeat').then(resp => {
                    console.log('值2是:' + resp.data[0].x)
                    let data=[]
                    //原始坐标
                    let origonParas = [];
                    origonParas[0] = {'x':0, 'y':0};
                    origonParas[1] = {'x':60, 'y':0};
                    origonParas[2] = {'x':0, 'y':30};

                    //目标坐标系
                    let targetParas = [];
                    targetParas[0] = {'x':12639230.54497627,'y':2556606.714786814};
                    targetParas[1] = {'x':12639290.783923365,'y':2556606.7894323496};
                    targetParas[2] = {'x':12639230.992849482,'y':2556636.8715831297};

                    //热力图对象
                    let heatmapInstance = fengmap.FMHeatMap.create(this.map, {
                        //热点半径
                        radius: 20,
                        //热力图透明度
                        opacity: .5,
                        //热力点value的最大值
                        max: 100
                    });
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            //坐标转换结果
                            console.log('转换后:' + transform(origonParas,targetParas,resp.data[i].x,resp.data[i].y))
                            let toTran =transform(origonParas,targetParas,resp.data[i].x,resp.data[i].y);

                            // 实例化定位标注对象
                            let locationMarker = new fengmap.FMLocationMarker({
                                //url: img,
                                //size:28,  //设置图片显示尺寸
                                height:0,  //marker标注高度
                            });
                            //this.map.addLocationMarker(locationMarker);

                            //实际图上的x、y需要经过坐标转换才能变成屏幕上的大坐标（转换方法看桌面的图）
                            locationMarker.setPosition({
                                x: toTran.x,
                                y: toTran.y,
                                groupID:this.map.focusGroupID  //设置定位点所在楼层
                            });
                            locationMarker.alwaysShow();
                            //增加热点(点越多颜色越深，最深为红色)
                            data[i]={
                                x: toTran.x,
                                y: toTran.y,
                                value: 50
                            }
                        }
                        heatmapInstance.addPoints(data);
                        //热力图应用到对应楼层
                        let groupLayer = this.map.getFMGroup(this.map.focusGroupID);
                        groupLayer.applyHeatMap(heatmapInstance);
                    } else {
                        this.$message.error(JSON.stringify(resp.data));
                    }
                })
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