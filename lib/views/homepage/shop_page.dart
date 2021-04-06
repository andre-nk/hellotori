part of "../pages.dart";

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final authModel = watch(authModelProvider);
      final shopItem = watch(shopItemProvider);
      final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

      return shopItem.when(
          data: (item) {
            return HeaderPage(
              isDetailedPage: false,
              appBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Font.out(
                    textAlign: TextAlign.start,
                    title: "Merchs",
                    fontSize: 24,
                    color: Palette.white,
                    family: "EinaBold"
                  )        
                ],
              ),
              child: Scaffold(
                floatingActionButton: mainUserProvider.when(
                  data: (value){
                    return value.role == "Admin"
                    ? FloatingActionButton(
                        elevation: 2,
                        mini: false,
                        backgroundColor: Palette.blueAccent,
                        child: Icon(Icons.add_rounded, size: 28),
                        onPressed: (){
                          Get.to(() => ShopControl(), transition: Transition.cupertino);
                        },
                      )
                    : SizedBox();
                  },
                  loading: (){return SizedBox();},
                  error: (_,__){return SizedBox();}
                ),
                body: FadeInUp(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MQuery.height(0.01, context),
                      vertical: MQuery.height(0.02, context)
                    ),
                    child: GridView.builder(
                      itemCount: item.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1 / 1.5
                      ),
                      itemBuilder: (context, index){
                        return FadeInUp(
                          child: ShopCard(
                            index: index,
                            title: item[index].title,
                            description: item[index].description,
                            price: item[index].price,
                            imageURL: item[index].imageURL,
                            isRightSide: index.isOdd,
                            isSold: item[index].isSold
                          )
                        );
                      }
                    ),
                  )
                )
              )
            );
          },
          loading: () {
            return Center(child: SpinKitCubeGrid(color: Palette.blueAccent));
          },
          error: (_, __) => Center(child: SpinKitCubeGrid(color: Colors.red,)));
    });
  }
}

// CustomScrollView(
//               physics: BouncingScrollPhysics(),
//               slivers: <Widget>[
//                 SliverAppBar(
//                   expandedHeight: 260,
//                   floating: true,
//                   snap: true,
//                   flexibleSpace: shopInfo.when(
//                     data: (info){
//                       return Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                             child: Image(
//                               image: NetworkImage(info[1] ?? ""),
//                               fit: BoxFit.cover,             
//                             )
//                           )
//                         ],
//                       );
//                     },
//                     loading: (){return SizedBox();},
//                     error: (_,__){return SizedBox();}
//                   )
//                 ),
//                 SliverGrid(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, childAspectRatio: 1 / 1.5),
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       return FadeInUp(
//                         child: ShopCard(
//                           index: index,
//                           title: item[index].title,
//                           description: item[index].description,
//                           price: item[index].price,
//                           imageURL: item[index].imageURL,
//                           isRightSide: index.isOdd,
//                           isSold: item[index].isSold
//                         ),
//                       );
//                     },
//                     childCount: item.length,
//                   ),
//                 )
//               ],
//             );
