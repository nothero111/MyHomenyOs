import HomePreference from '../until/homePreference'

@Component
export default struct panel{

   @Consume panelSize:number
   aPanel: Record<number,string> = {
     16:'小',
     20:'中',
     24:'大',
     28:'特大'
}
  build() {
    Column(){
     Text(`${this.aPanel[this.panelSize]}`).padding({top:5 })
      Row(){
        Slider({
          min:16,
          max:28,
          step:4,
          value:this.panelSize
        }).onChange((value:number)=>{
          this.panelSize = value
          HomePreference.putPreferenceValue('homepref','PanelSize',value)
        })
      }
    }.width("100%").height(120).backgroundColor('#f1f2f5')
    .borderRadius(5).padding({left:12,right:12}).position({bottom:0})
  }
}
