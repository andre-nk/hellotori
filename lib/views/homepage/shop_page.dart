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
      final shopInfo = watch(shopInfoProvider);
      final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

      return Scaffold(
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
        body: shopItem.when(
          data: (item) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 260,
                  floating: true,
                  snap: true,
                  flexibleSpace: shopInfo.when(
                    data: (info){
                      return Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.network(
                            info[1] ?? "",
                            fit: BoxFit.cover,
                          ))
                        ],
                      );
                    },
                    loading: (){return SizedBox();},
                    error: (_,__){return SizedBox();}
                  )
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return FadeInUp(
                        child: ShopCard(
                          index: index,
                          title: item[index].title,
                          description: item[index].description,
                          price: item[index].price,
                          imageURL: item[index].imageURL,
                          isRightSide: index.isOdd,
                        ),
                      );
                    },
                    childCount: item.length,
                  ),
                )
              ],
            );
          },
          loading: () {
            return Center(child: SpinKitCubeGrid(color: Palette.blueAccent));
          },
          error: (_, __) => Center(child: SpinKitCubeGrid(color: Colors.red,)))
      );
    });
  }
}
