import shopInfo from '../class/ShopItem'
@Component
struct itemCard {
  card: shopInfo =  new shopInfo()
  build() {
    Column(){
      Text(`${this.card.name}`)
        .fontSize(20)
        .padding({top:10})
        .fontWeight(FontWeight.Bold)
        .width('100%')
      Text(''+this.card.address)
        .fontColor('#ccccce')
        .width('100%')
      Row(){
        Rating({rating:this.card.score/10 , indicator: true}).stars(5)
        Text(`  ${this.card.score/10}  `).fontSize(13).fontColor(Color.Orange)
        Text(''+this.card.comments).fontSize(13)
        Blank()
        Text('￥'+this.card.avgPress).fontSize(13).padding({right:20})
      }.width('100%').height(20)
      Row({space:20}){
        Image(this.card.images[0])
          .width(150)
          .height(150)
          .borderRadius(5)
        Image(this.card.images[1])
          .width(150)
          .height(150)
          .borderRadius(5)
      }


    }.width('100%').padding({left:5,right:5})
    .margin({top:5,bottom:5}).backgroundColor(Color.White)
    .height(260).justifyContent(FlexAlign.Start)
    .borderRadius(15)
  }
}



export default itemCard