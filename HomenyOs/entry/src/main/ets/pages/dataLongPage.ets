import preference from '../until/preferenceuntil';




@Entry
@Component
struct DataLongPage {
  @State message: string = 'Hello World';
  @State Size: number =50

async  aboutToAppear(){
   this.Size = await preference.getPreference('mypre','IndexFonts',50) as number
}
  build() {
    Column(){
      Text(this.message)

        .fontSize(this.Size)
        .fontWeight(FontWeight.Bold)
        Row(){

        }.height(20)
      Slider({min:10,max:60,step:10,value:this.Size})
        .onChange(value =>{
          this.Size = value
          preference.putPreferenceValue('mypre','IndexFonts',value)
        })
    }
    .height('100%')
    .width('100%')
  }
}