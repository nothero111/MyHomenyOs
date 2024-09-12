import common from '@ohos.app.ability.common';
import { preferences } from '@kit.ArkData';


class preference{
  prefMap: Map<string, preferences.Preferences> = new Map()
//   loadPreference(context:common.UIAbilityContext,name:string){
//     //context是上下文的参数，name是要引用的实例名字
//     preferences.getPreferences(context,name)//根据上下文，名字获取preference
//     //返回的是promise类型
//       .then(pref =>{
//         this.prefMap.set(name, pref)//得到pref（这个pref是已有的）
//         // 从磁盘中得到并存入prefMap当中
//         console.log('testTag',`加载Preference${name}成功`)
//       }).catch((reason:BusinessError)=>{
//         console.log('testTag',`加载Preference${name}失败`,JSON.stringify(reason))
//     })
// }异步加载方式
 async loadPreference(context:common.UIAbilityContext,name:string){
   try {
     let pref = await preferences.getPreferences(context, name)//直接获得pref
     //而不用再用catch那种繁琐的方式来写了
     console.log('testTag',`加载Preference${name}成功`)
     //打印成功消息
     this.prefMap.set(name, pref)//把加载得到的pref存入prefMap当中
   } catch (e) {
     console.log('testTag',`加载Preference${name}失败`,JSON.stringify(e))
      //输出错误日志
   }
  }//异步变为同步加载方式


  //新增数据，向磁盘里存
 async putPreferenceValue(name:string,key:string ,value:preferences.ValueType){
      if(!this.prefMap.has(name)){//判断map里是否有name这个preference
        //在map里面是preference。preference里面是要存的键值对
        console.log('testTag',`Preference${name}尚未初始化`)
        return //如果拿不到就结束
      }
   try {
     let pre = this.prefMap.get(name)
     await pre?.put(key, value) //存入键值对
     await pre?.flush() //把数据写入磁盘
     console.log('testTag', `保存Preference[${name},${key} = ${value}]成功`)
   } catch (e) {
     console.log('testTag', `保存Preference[${name},${key} = ${value}]失败`,JSON.stringify(e))
   }
 }
    //读取数据

async getPreference(name:string,key:string ,defaultValue:preferences.ValueType){
  if(!this.prefMap.has(name)){//判断map里是否有name这个preference
    //在map里面是preference。preference里面是要存的键值对
    console.log('testTag',`Preference${name}尚未初始化`)
    return //如果拿不到就结束
  }
  try{
  let pre = this.prefMap.get(name)
    let value = await pre?.get(key, defaultValue) //根据name和key的值获取到value
  console.log('testTag', `读取Preference[${name},${key} = ${value}]成功`)
    return value
} catch (e) {
  console.log('testTag', `读取Preference[${name},${key} =]失败`,JSON.stringify(e))
    return //没有拿出value，返回一个空的值
}
}


//删除保存的键值对
async deletPreference(name:string,key:string){
  if(!this.prefMap.has(name)){
    console.log('testTag',`Preference${name}尚未初始化`)
    return //如果拿不到就结束
  }
  try {
    this.prefMap.get(name)?.delete(key)
  } catch (e) {
    console.log('testTag', `删除Preference[${name},${key} =]失败`,JSON.stringify(e))
  }
}

}

const preferencesUtil = new preference()
export default preferencesUtil as preference