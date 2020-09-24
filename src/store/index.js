import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

export default new Vuex.Store({
      state:{
          routes:[],
          rid:null
      },
      mutations:{
          initRoutes(state, data){  //只传data即可
              state.routes = data;
          }
      },
      actions:{

      }
})