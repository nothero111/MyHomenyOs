import shopInfo from '../class/ShopItem';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'
import { JSON } from '@kit.ArkTS';


class shopsRequest{
  baseURL:string = 'http://localhost:3000'
  pageNo:number = 1
  getshops():Promise<shopInfo[]>{
    return new Promise((resolve,reject)=>{

      axios.get(
        `${this.baseURL}/shops`,
        {
          params:{pageNo:this.pageNo,pageSize:3}
        }
      ).then((resp:AxiosResponse)=>{
        if(resp.status===200){
          console.log('查询成功')
          resolve(resp.data)
        }else{
          console.log('查询失败',JSON.stringify(resp))
        }
      }).catch((err:AxiosError)=>{
        console.log('查询失败',err.message)
        reject('查询失败')
      })
    })
  }

  // postShops(){
  //   axios.post<shopInfo,AxiosResponse<shopInfo>>(
  //     `${this.baseURL}/shops`,
  //     {
  //       id: 0,
  //       name:'',
  //       images: [],
  //       area: '',
  //       address:  '',
  //       avgPress: 0,
  //       comments:  0,
  //       score :  0,
  //       openHourse: ''
  //     }
  //   ).then((resp:AxiosResponse<shopInfo>)=>{
  //       console.info(JSON.stringify(resp.data))
  //   }).catch((error:AxiosError)=>{
  //       console.info(error.message)
  //   })
  //
  //
  // }
}
const shopMole = new shopsRequest()
export default shopMole



// class shopsRequest{
//   baseURL:string = 'http://localhost:3000'
//   pageNo:number = 1
//   getshops():Promise<shopInfo[]>{
//     return new Promise((resolve,reject)=>{
//       let httpRequest = http.createHttp()
//       httpRequest.request(
//         `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=3`,
//         {
//           method:http.RequestMethod.GET
//         }
//       ).then((resp)=>{
//         if(resp.responseCode===200){
//           console.log('查询成功')
//           resolve(JSON.parse(resp.result.toString()))
//         }else{
//           console.log('查询失败',JSON.stringify(resp))
//         }
//       }).catch((err:AxiosError)=>{
//         console.log('查询失败',JSON.stringify(err))
//         reject('查询失败')
//       })
//     })
//   }
// }
// const shopMole = new shopsRequest()
// export default shopMole


