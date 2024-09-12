import { common } from '@kit.AbilityKit';
import { preferences, ValueType } from '@kit.ArkData';

class homePreference{
  prefMap: Map<string,preferences.Preferences> = new Map()
//加载用户首选项实例最开始的准备工作
  async loadPreference(context:common.UIAbilityContext,name:string){
    try {
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name,pref)
      console.log('testTag',`加载preference[${name}]成功`)
    } catch (e) {
    console.log('testTag',`加载失败`,JSON.stringify(e))
    }
}

  // //新增数据，向磁盘里存
  // async putPreferenceValue(name:string,key:string ,value:preferences.ValueType){
  //   if(!this.prefMap.has(name)){//判断map里是否有name这个preference
  //     //在map里面是preference。preference里面是要存的键值对
  //     console.log('testTag',`Preference${name}尚未初始化`)
  //     return //如果拿不到就结束
  //   }
  //   try {
  //     let pre = this.prefMap.get(name)
  //     await pre?.put(key, value) //存入键值对
  //     await pre?.flush() //把数据写入磁盘
  //     console.log('testTag', `保存Preference[${name},${key} = ${value}]成功`)
  //   } catch (e) {
  //     console.log('testTag', `保存Preference[${name},${key} = ${value}]失败`,JSON.stringify(e))
  //   }
  // }
//写入数据
  async putPreferenceValue(name:string,key:string,value:preferences.ValueType){
  if(!this.prefMap.has(name)){
    console.log('testTag',`preference[${name}]尚未初始化`)
    return
  }
    try {
    let pref = this.prefMap.get(name)
      console.log('testTag',`preferences[${name}]加载成功`)
       await pref?.put(key,value)
      await pref?.flush()
    } catch (e) {
      console.log('testTag',`没有${name}实例`)
    }
  }
//读取数据
  async getPreference(name:string,key:string,defaultValue:preferences.ValueType){
      if(!this.prefMap.has(name)){
        console.log(`在preferences找不到${name}`)
        return
      }
    try {
      let pref = this.prefMap.get(name)
      let value = await pref?.get(key, defaultValue)
      console.log('testTag',`读取preference${name}成功`)
      return value
    } catch (e) {
      console.log('testTag',`读取preference${name}失败`)
      return
    }

  }

}

const HomePreference = new homePreference()
export default HomePreference as homePreference



