import { router } from '@kit.ArkUI'
import { common, Want } from '@kit.AbilityKit'


import { BusinessError } from '@kit.BasicServicesKit'
import { TipsDialog, SelectDialog, ConfirmDialog, AlertDialog, LoadingDialog, CustomContentDialog } from '@kit.ArkUI'


//@Observed
class work{//定义一个work类模拟任务
  name:string
  finished:boolean

  constructor(name:string,finished:boolean) {
    this.name = name
    this.finished = finished
  }
}

@Extend(Text)
function Finish(){
  .fontColor('#a8a9ab')
  .decoration({type:TextDecorationType.LineThrough})
}

@Entry
@Component
struct TaskManagePage {
@State allTask:number = 0
@State finishedTask:number = 0
  @State totalTask: number = 0
@State items: work[] = []
    context = getContext(this) as common.UIAbilityContext
  //context = getContext(this) as common.UIAbilityContext//获取上下文，得到一个有各种api的对象
  build() {
   Column(){
     Row({space:5}){
       Image($r('app.media.back')).width(30)
         .padding({left:10}).onClick(()=>{
           router.back()})
       Text('任务管理').fontSize(20)
       Image($r('app.media.refresh'))
         .width(30).padding({right:10})
     }.height(60).width('100%')
     .justifyContent(FlexAlign.SpaceBetween)
     Row(){
      Text('任务进度:').padding(10).fontSize(20).fontWeight(FontWeight.Bold)
       Blank()
       Stack(){
        Text(){
          Span(this.finishedTask.toString()).fontSize(20)
            .fontColor(Color.Blue)
          Span(`/${this.totalTask}`).fontSize(20)
        }.padding(10)
          Progress({value:this.finishedTask,total:this.totalTask,type:ProgressType.Ring})
            .width(100)
       }.padding({right:30})
     }.width(330).height(140).borderRadius(20)
     .backgroundColor(Color.White)

     Button('新增任务')
       .onClick(() =>{
         this.totalTask++
         this.allTask++
         let aWork:work = new work(`任务${this.allTask}`,false)
         this.items.push(aWork)
       }).margin(20)
         List({space:10}){
           ForEach(this.items,(item:work,index)=>{

             ListItem(){

               Row(){
                 Row(){
                   Image($r('app.media.newTask'))
                     .width(30).padding({left:5})
                   if(item.finished){
                     Text(item.name).Finish()
                   }else{
                     Text(item.name)
                   }
                 }.onClick(()=>{
                   let wantInfo: Want = {
                     deviceId:'',
                     bundleName:'com.example.testapp',
                     abilityName:'editedAbility',
                   }
                   this.context.startAbility(wantInfo)
                     .then(()=>{
                       console.log('跳转成功')
                     })
                     .catch((err:BusinessError)=>{
                       console.log('跳转失败',err)
                     })
                 })
                 Blank()
                 Checkbox().shape(CheckBoxShape.ROUNDED_SQUARE)
                   .onChange((value:boolean)=>{
                      this.items[index] = new work(item.name, value)
                      this.finishedTask = this.items.filter(item => item.finished).length
                   }).padding({right:5}).select(item.finished)
               }.backgroundColor(Color.White).width(340).height(80)
               .borderRadius(20)
             }.width('100%').swipeAction({end:this.Deletion(index)})
           })
         }.layoutWeight(1)

   }.width('100%').height('100%')
  .backgroundColor('#f0f1f4')
  }
  @Builder Deletion(index:number){
    Button(){
      Image($r('app.media.trashCan'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.items.splice(index, 1)
      this.totalTask = this.items.length
      this.finishedTask = this.items.filter(item => item.finished).length
    })
  }
}

@CustomDialog struct MyDialog{
  @State
  @State taskName:string = ''
  controller?: CustomDialogController
  build() {
    Column(){
      Text('请输入你的任务名称')
      Row(){
        TextInput().onChange((value)=>{
          this.taskName = value
        })
        Row({space:20}){
          Text("确定").fontColor(Color.Blue)
            .onClick(()=>{
              this.controller?.close()
            })
          Text("取消").fontColor(Color.Red)
            .onClick(()=>{
              this.controller?.close()
            })
        }
      }
    }
}

}



