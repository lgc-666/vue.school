import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

import VCharts from 'v-charts';
//import Antd from 'ant-design-vue'
//import 'ant-design-vue/dist/antd.css'
import './assets/styles/reset.css'
import './assets/styles/border.css'
import echarts from 'echarts'
import BaiduMap from 'vue-baidu-map'
import qs from 'qs'

import {postKeyValueRequest} from "./utils/api";
import {getRequest} from "./utils/api";
import {putRequest} from "./utils/api";
import {deleteRequest} from "./utils/api";
import './permission' // 权限

import 'font-awesome/css/font-awesome.min.css'
import axios from 'axios'

Vue.prototype.postKeyValueRequest = postKeyValueRequest;
Vue.prototype.putRequest = putRequest;
Vue.prototype.getRequest = getRequest;
Vue.prototype.deleteRequest = deleteRequest;

Vue.config.productionTip = false

Vue.use(BaiduMap, {
  /* 申请的百度密钥，可以在百度地图官网申请 */
  ak: 'pBbWsUqY3GHjUuOtDuoIGpFUDFmu6fd7'
})
Vue.use(ElementUI);
Vue.use(VCharts);
//Vue.use(Antd);
Vue.prototype.$echarts = echarts;
//Vue.prototype.$qs = qs;

axios.defaults.withCredentials = true;// 允许跨域携带cookie
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

