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
            <el-time-picker style="margin-left: 20px;margin-top: 10px;" @change="changeaddress"
                    is-range
                    v-model="value3"
                    range-separator="至"
                    start-placeholder="当天开始时间"
                    end-placeholder="当天结束时间"
                    placeholder="选择时间范围">
            </el-time-picker>
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
                value3: [new Date(),new Date()],
                placeholder: '请输入即将要查询的mac地址',
                showinput: true,
                staffdata:'',
                flag:'',
                indoordata:[],
                shopMap:'',
                user:JSON.parse(window.sessionStorage.getItem("user"))
            }
        },
        mounted () {
            this.checkJurisdiction2()
            this.openMap()
        },
        methods: {
            changeaddress () {   //通过选择按钮改变所选区域
                window.sessionStorage.setItem("indoor", JSON.stringify(this.shopMap))
                window.sessionStorage.setItem("start3", this.value3[0])
                window.sessionStorage.setItem("end3", this.value3[1])
                this.btn1()
            },
            checkJurisdiction2 () {
                this.getRequest('/listMapMamageNoPage',{roledesc:this.user.roledesc,username:this.user.username}).then(resp => {
                    if (resp.success) {
                        for (let i = 0; i < resp.data.length; i++) {
                            let add = {}
                            add.value = i
                            add.label = resp.data[i].indoorname
                            this.indoordata.push(add)
                        }

                        if(window.sessionStorage.getItem("indoor")!=null&&window.sessionStorage.getItem("indoor")!=''){
                            this.shopMap=JSON.parse(window.sessionStorage.getItem("indoor"))
                        }
                        else {
                            if(this.indoordata.length!=0){
                                this.shopMap = this.indoordata[0].label
                                window.sessionStorage.setItem("indoor", JSON.stringify(this.indoordata[0].label));
                            }
                        }

                        if(window.sessionStorage.getItem("start3")===null||window.sessionStorage.getItem("end3")===null||window.sessionStorage.getItem("start3")===''||window.sessionStorage.getItem("end3")===''){
                            window.sessionStorage.setItem("start3", this.value3[0]);
                            window.sessionStorage.setItem("end3", this.value3[1]);

                        }
                        else {
                            this.value3=[window.sessionStorage.getItem("start3"),window.sessionStorage.getItem("end3")]
                        }
                    } else {
                    }
                })
            },

            goto1(){
                this.$router.replace("/map");
            },
            goto2(){
                this.$router.replace("/hot");
            },
            goto3(){
                this.$router.replace("/trave");
            },


            openMap () {
                this.flag=0
                this.getRequest('/listMapMamageSearchByIndoorname',{staffdata:JSON.parse(window.sessionStorage.getItem("indoor"))}).then(resp => {
                    if (resp.success) {
                        let fmapID = resp.data.fmapid
                        let mapOptions = {
                            container: document.getElementById('fmap'),
                            appName: 'za102',
                            key: 'cc13bc8c80c3cbdc44813dfc015321af',
                            defaultMapScale: 250
                        }
                        this.map = new fengmap.FMMap(mapOptions)
                        this.map.openMapById(fmapID, (error) => {
                        })

                        this.map.on('loadComplete', () => {
                            this.loadScrollFloorCtrl()
                            this.map.rotateAngle=10
                        })
                        clearTimeout(this.timer);

                        this.timer = setTimeout(()=>{
                            this.btn2()
                        },800);

                    } else {
                        this.$message.error(resp.data);
                    }
                })
            },


            loadScrollFloorCtrl () {
                let scrollFloorCtlOpt = {
                    position: fengmap.FMControlPosition.RIGHT_TOP,
                    showBtnCount: 1,
                    allLayer:false,
                    needAllLayerBtn: false,
                    offset: {
                        x: -20,
                        y: 90
                    },
                    imgURL: '../assets/images/'
                }

                let scrollFloorControl = new fengmap.FMScrollGroupsControl(
                    this.map,
                    scrollFloorCtlOpt
                )

                scrollFloorControl.onChange((groups, allLayer) => {
                })
                this.map.on('mapClickNode', function(event) {
                });
            },

            btn2 () {
            },

            btn1 () {
                this.$router.replace("/administrators");
                setTimeout(() => {
                    this.$router.replace("/trave");
                },100)
            },

            blurSearchFor () {
                if (this.placeholder === '请输入即将要查询的mac地址') {
                    this.placeholder = ''
                }
            },
            blurSear () {
                this.placeholder = '请输入即将要查询的mac地址'
            },

            locationMarkerstartend(str,x2,y2){
                let groupLayer = this.map.getFMGroup(this.map.focusGroupID);
                let layer = new fengmap.FMTextMarkerLayer();
                groupLayer.addLayer(layer);

                let tm = new fengmap.FMTextMarker({
                    name: str,
                    x: x2,
                    y: y2,
                    height:1.5,
                    fillcolor: "0,0,0",
                    fontsize:15, //字体大小
                    strokecolor: "255,255,0",
                    alpha: 0.5 ,
                });
                layer.addMarker(tm);
                tm.alwaysShow();
            },
            btnquery () {
                if (this.staffdata === '') {
                } else {
                        window.sessionStorage.setItem('staffdata', this.staffdata)
                   // setTimeout(() => {
                        this.getRequest('/listByMac', {mac: window.sessionStorage.getItem("staffdata"),indoorname:JSON.parse(window.sessionStorage.getItem("indoor")),start:this.formateDate(window.sessionStorage.getItem("start3")),end:this.formateDate(window.sessionStorage.getItem("end3"))}).then(resp => {
                            let data = []
                            let toTran = {}
                            let origonParas = [];
                            origonParas[0] = {'x': 0, 'y': 0};
                            origonParas[1] = {'x': 60, 'y': 0};
                            origonParas[2] = {'x': 0, 'y': 30};

                            let targetParas = [];
                            targetParas[0] = {'x': 12639230.54497627, 'y': 2556606.714786814};
                            targetParas[1] = {'x': 12639290.783923365, 'y': 2556606.7894323496};
                            targetParas[2] = {'x': 12639230.992849482, 'y': 2556636.8715831297};

                            let origonParas2 = [];
                            origonParas2[0] = {'x': 0, 'y': 0};
                            origonParas2[1] = {'x': 30, 'y': 0};
                            origonParas2[2] = {'x': 0, 'y': 15};

                            let targetParas2 = [];
                            targetParas2[0] = {'x': 12639239.795915337, 'y': 2556610.782968951};
                            targetParas2[1] = {'x': 12639269.71384503, 'y': 2556610.7531089145};
                            targetParas2[2] = {'x': 12639240.004923064, 'y': 2556625.6225004843};

                            let origonParas3 = [];
                            origonParas3[0] = {'x': 0, 'y': 0};
                            origonParas3[1] = {'x': 50, 'y': 0};
                            origonParas3[2] = {'x': 0, 'y': 30};

                            let targetParas3 = [];
                            targetParas3[0] = {'x': 12639791.874296326, 'y': 2555860.7446266245};
                            targetParas3[1] = {'x': 12639842.573544905, 'y': 2555862.2972528506};
                            targetParas3[2] = {'x': 12639792.59089392, 'y': 2555890.8417085623};

                            if (resp.success) {
                                for (let i = 0; i < resp.data.length; i++) {
                                    if(resp.data[i].indoorname==='za102'){
                                        toTran = transform(origonParas, targetParas, resp.data[i].x, resp.data[i].y);
                                    }
                                    else if(resp.data[i].indoorname==='za101'){
                                        toTran = transform(origonParas2, targetParas2, resp.data[i].x, resp.data[i].y);
                                    }
                                     else if(resp.data[i].indoorname==='mb404'){
                                        toTran = transform(origonParas3, targetParas3, resp.data[i].x, resp.data[i].y);
                                    }


                                    data[i] = {
                                        x: toTran.x,
                                        y: toTran.y,
                                        value: 50
                                    }
                                }

                                let locationMarker = new fengmap.FMLocationMarker({
                                    url: img1,
                                    size: 30,
                                    height: 1,
                                });
                                this.map.addLocationMarker(locationMarker);
                                locationMarker.setPosition({
                                    x: data[0].x,
                                    y: data[0].y,
                                    groupID: this.map.focusGroupID
                                });

                                locationMarker.alwaysShow();

                                this.locationMarkerstartend(''+resp.data[0].mac+'的起点', data[0].x, data[0].y)

                                let locationMarker2 = new fengmap.FMLocationMarker({
                                    url: img2,
                                    size: 30,
                                    height: 1,
                                });
                                this.map.addLocationMarker(locationMarker2);
                                locationMarker2.setPosition({
                                    x: data[data.length - 1].x,
                                    y: data[data.length - 1].y,
                                    groupID: this.map.focusGroupID
                                });
                                this.locationMarkerstartend('终点', data[data.length - 1].x, data[data.length - 1].y)

                                let line = new fengmap.FMLineMarker();

                                let gid = this.map.focusGroupID;

                                let points = data;

                                let points3d = [];
                                points.forEach(function (point) {
                                    points3d.push({
                                        'x': point.x,
                                        'y': point.y,
                                        'z': 1
                                    });
                                });
                                let seg = new fengmap.FMSegment();
                                seg.groupId = gid;
                                seg.points = points3d;
                                line.addSegment(seg);
                                let lineStyle = {
                                    lineWidth: 6,
                                    alpha: 0.8,
                                    lineType: fengmap.FMLineType.FMARROW,
                                    noAnimate: false
                                };
                                this.map.drawLineMark(line, lineStyle);
                            } else {
                                this.$message.error(JSON.stringify(resp.data));
                            }
                        })
              }
            },
            formateDate(datetime) {
                function addDateZero(num) {
                    return (num < 10 ? "0" + num : num);
                }
                let c = new Date()
                let d = new Date(datetime);
                let formatdatetime = c.getFullYear() + '-' + addDateZero(c.getMonth() + 1) + '-' + addDateZero(c.getDate()) + ' ' + addDateZero(d.getHours()) + ':' + addDateZero(d.getMinutes()) + ':' + addDateZero(d.getSeconds());
                return formatdatetime;
            }
        }
    }
</script>

<style scoped>
    #fmap{
        width: 100%;
        height: 600px;
    }
</style>