import  shopInfo from '../class/ShopItem'
//import itemCard from '../module/loadcard'
import shopMole from '../module/getshops'

@Entry
@Component
struct Index {
@State shoplist: shopInfo[] = []

 aboutToAppear(): void {
    this.loadShops()
 }
  build() {
    Column(){
       Row(){
         Text('商品列表')
           .fontSize(40)
       }.height(60)
     List({space:10}){
         ForEach(this.shoplist,(item:shopInfo) =>{
           ListItem(){
             Column(){
               Text(`${item.name}`)
                 .fontSize(20)
                 .padding({top:10})
                 .fontWeight(FontWeight.Bold)
                 .width('100%')
               Text(''+item.address)
                 .fontColor('#ccccce')
                 .width('100%')
               Row(){
                 Rating({rating:item.score/10 , indicator: true}).stars(5)
                 Text(`  ${item.score/10}  `).fontSize(13).fontColor(Color.Orange)
                 Text(''+item.comments).fontSize(13)
                 Blank()
                 Text('￥'+item.avgPress).fontSize(13).padding({right:20})
               }.width('100%').height(20)
               Row({space:20}){
                 Image(item.images[0])
                   .width(150)
                   .height(150)
                   .borderRadius(5)
                 Image(item.images[1])
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
         )}.layoutWeight(1).onReachEnd(()=>{
           this.loadShops()
           shopMole.pageNo++
          console.log(shopMole.pageNo.toString())
           console.log('触底了')
     })
     }.width('100%').height('100%')
    .backgroundColor('#e0e2e4')
    }



loadShops(){
      shopMole.getshops()
        .then((shops:shopInfo[]) =>{
          shops.forEach((s:shopInfo) =>{
            s.images.forEach((src ,i) =>{
              s.images[i] = 'http://localhost:3000' +src
             console.log(s.images[i].toString())
            })
          })
        this.shoplist = this.shoplist.concat(shops)
        })
}

}
