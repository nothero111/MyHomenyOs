import router from '@ohos.router'
import panel from '../until/panel'
import HomePreference from '../until/homePreference'
class RouterItem{
  name:string
  RouterURL:string

  constructor(name:string,RouterURL:string) {
    this.name = name
    this.RouterURL = RouterURL
  }
}


@Entry
@Component
struct Index {
  async aboutToAppear() {
    this.panelSize = await HomePreference.getPreference('homepref','PanelSize',14) as number
  }
 @State isShow: boolean = false
  @Provide panelSize: number = 14
@State  RouterItems: RouterItem[] = [
  new RouterItem('数据持久化案例', 'pages/dataLongPage'),
  new RouterItem('商店使用案例', 'pages/shopPlace'),
  new RouterItem('任务管理案例', 'pages/TaskManagePage')
]
  build() {
    Column(){
      Row(){
        Text('登录首页')
          .fontSize(60).margin({left:50})
        Image($r('app.media.set'))
          .width(30).margin({left:27})
          .onClick(()=>{
            this.isShow = !this.isShow
          })
      }.width('100%')
      if(this.isShow){
        panel()
      }

      List({space:10}){
        ForEach(this.RouterItems,(item:RouterItem,idex) =>{
          ListItem(){
            Button((idex+1)+ '.' + item.name)
              .fontSize(this.panelSize)
              .onClick(()=>{
                router.pushUrl({
                  url:item.RouterURL
                })
              })

          }.width('100%')
        })
      }

    }.width('100%')
    .height('100%')
  }
}