//import { router } from '@kit.ArkUI'

@Entry
@Component
struct MemorandumPage {
  build() {
    Column(){
      Row() {
      Image($r('app.media.return')).width(20).margin({left:6,right:120})

        Text('编辑页面').height(20)
      }.width('100%').margin({top:12})
      TextInput({placeholder:'请输入标题'}).height(50).margin(12)
      TextArea({placeholder:'在此输入正文'})
    }.height('100%').width('100%')
  }
}