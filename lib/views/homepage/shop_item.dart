part of "../pages.dart";

class ShopItem extends StatefulWidget {

  final index;
  final String unique;

  ShopItem({
    required this.index,
    required this.unique
  });

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {

    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

    return Consumer(
      builder: (context, watch, _){

        final authModel = watch(authModelProvider);
        final shopItem = watch(shopItemProvider);
        final shopInfo = watch(shopInfoProvider);
        final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

        return shopItem.when(
          data: (item){
            return Scaffold(
              floatingActionButton: mainUserProvider.when(
                data: (value){
                  return value.role == "Admin"
                  ? FloatingActionButton(
                      elevation: 2,
                      mini: false,
                      backgroundColor: Palette.blueAccent,
                      child: Icon(Icons.edit_rounded, size: 24),
                      onPressed: (){
                        Get.to(() => ShopControl(
                          uid: item[widget.index].uid,
                          title: item[widget.index].title,
                          description: item[widget.index].description,
                          imageURL: item[widget.index].imageURL,
                          price: item[widget.index].price,
                        ), transition: Transition.cupertino);
                      },
                    )
                  : shopInfo.when(
                      data: (value){
                        return Stack(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Palette.blueAccent.withOpacity(0.2),
                                            blurRadius: 40,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        mini: false,
                                        backgroundColor: Palette.white,
                                        child: Icon(Icons.chat_bubble_outline, size: 24, color: Palette.blueAccent),
                                        onPressed: () async {
                                          await launch("https://wa.me/${value[0]}?text=${value[2] + item[widget.index].title}");
                                        }
                                      ),
                                    ),
                                  )    
                                ),
                                SizedBox(width: MQuery.width(0.02, context)),
                                Padding(
                                  padding: EdgeInsets.only(left:10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Palette.blueAccent.withOpacity(0.2),
                                            blurRadius: 40,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        mini: false,
                                        backgroundColor: Palette.blueAccent,
                                        child: Icon(Icons.shopping_cart_rounded, size: 24, color: Palette.white),
                                        onPressed: () async {
                                        Get.to(() => TransactionControl(
                                            productTitle: item[widget.index].title,
                                            imageURL: item[widget.index].imageURL
                                          ),
                                          transition: Transition.cupertino
                                        );
                                      }
                                      ),
                                    ),
                                  )    
                                ),
                              ],
                            )                     
                          ],
                        );
                      },
                      loading: (){
                        FloatingActionButton(
                          elevation: 2,
                          mini: false,
                          backgroundColor: Palette.blueAccent,
                          child: Icon(Icons.shopping_cart_rounded, size: 24),
                          onPressed: () async {
                            // await launch("https://wa.me/${value[0]}?text=Hello");
                          },
                        );
                      },
                      error: (_,__){
                        FloatingActionButton(
                          elevation: 2,
                          mini: false,
                          backgroundColor: Palette.blueAccent,
                          child: Icon(Icons.shopping_cart_rounded, size: 24),
                          onPressed: () async {
                            // await launch("https://wa.me/${value[0]}?text=Hello");
                          },
                        );
                      }
                    );
                },
                loading: (){return SizedBox();},
                error: (_,__){return SizedBox();}
              ),
              appBar: AppBar(
                toolbarHeight:  MQuery.height(0.1, context),
                elevation: 0,
                backgroundColor: Palette.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color:  Palette.black),
                  onPressed: (){
                    Get.back();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.share, color: Palette.black),
                    onPressed: (){
                      Share.share(
                        "Hai Satria SMANSA! Yuk kepon merchandise official hasil karya satria SMANSA: ${item[widget.index].title}, hanya di aplikasi Hellotori!"
                      );
                    },
                  ) 
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      MQuery.height(0.02, context),
                      0,
                      MQuery.height(0.02, context),
                      MQuery.height(0.02, context)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.index,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              foregroundDecoration: BoxDecoration(
                                color: item[widget.index].isSold == true
                                  ? Colors.grey 
                                  : Colors.transparent,
                                backgroundBlendMode: BlendMode.saturation
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Image(
                                image: NetworkImage(item[widget.index].imageURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MQuery.height(0.02, context)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            MQuery.height(0.02, context),
                            0,
                            MQuery.height(0.02, context),
                            MQuery.height(0.02, context)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MQuery.height(0.005, context)),
                              Font.out(
                                title: item[widget.index].title,
                                fontSize: 22,
                                family: "EinaSemiBold"
                              ),
                              SizedBox(height: MQuery.height(0.005, context)),
                              Font.out(
                                title: "${formatCurrency.format(item[widget.index].price).substring(0, formatCurrency.format(item[widget.index].price).length - 3)}",
                                fontSize: 20,
                                family: "EinaRegular",
                                color: Palette.blueAccent
                              ),
                              SizedBox(height: MQuery.height(0.02, context)),
                              Text(
                                item[widget.index].description,
                                style: TextStyle(
                                  fontFamily: "EinaRegular",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Palette.black
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                )
              ),
            );
          },
          loading: () {
            return Center(child: SpinKitCubeGrid(color: Palette.blueAccent));
          },
          error: (_, __) => Center(child: SpinKitCubeGrid(color: Colors.red,))
        );
      }
    );
  }
}
