part of "../pages.dart";

class OSISPage extends StatefulWidget {
  @override
  _OSISPageState createState() => _OSISPageState();
}

class _OSISPageState extends State<OSISPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final osisProvider = watch(osisStreamProvider);
        final authModel = watch(authModelProvider);
        final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

        return mainUserProvider.when(
          data: (value){
            return osisProvider.when(
              data: (data){
                return HeaderPage(
                  isDetailedPage: true,
                  appBar: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Font.out(
                        textAlign: TextAlign.start,
                        title: data.headline == "" ? "Seputar OSIS / MPK" : data.headline,
                        fontSize: 24,
                        color: Palette.white,
                        family: "EinaBold"
                      ),       
                    ],
                  ),
                  child: Scaffold(
                    floatingActionButton: value.role == "Admin"
                      ? FloatingActionButton(
                          elevation: 2,
                          mini: false,
                          backgroundColor: Palette.blueAccent,
                          child: Icon(Icons.edit_rounded, size: 28),
                          onPressed: (){
                            Get.to(() => ArticleControl(
                              imageURLs: data.photoURL,
                              article: data.article,
                              header: data.headline ?? ""
                            ));
                          },
                        )
                      : SizedBox(),
                    body: FadeInUp(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MQuery.height(0.025, context),
                          vertical: MQuery.height(0.035, context)
                        ),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            data.photoURL[0] != ""
                              ? Hero(
                                  tag: "OSIS",
                                  child: Container(
                                    height: MQuery.height(0.325, context),
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.photoURL.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: index > 0 ? MQuery.width(0.03, context) : MQuery.width(0.0, context)
                                          ),
                                          child: Image.network(data.photoURL[index]),
                                        );
                                      }
                                    ),
                                  ),
                              ) 
                              : Image(image: AssetImage("assets/osis_photo.png")),
                            SizedBox(height: MQuery.height(0.03, context)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MQuery.height(0.02, context)
                              ),
                              child: Linkify(
                                text: data.article != "" ? data.article :"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis velit urna, cursus vitae sollicitudin sit amet, scelerisque nec lorem. Cras ultricies ante quis magna consequat cursus. Integer pretium turpis nec dictum molestie. Ut maximus luctus metus, eu elementum turpis luctus et. Curabitur id justo ultrices magna porttitor vehicula eu et ante. Pellentesque velit est, maximus eget ornare a, faucibus eget metus. Phasellus eleifend tincidunt leo, a rutrum libero ullamcorper et. Sed interdum enim felis. In placerat elit purus, sed euismod tortor suscipit eu. Duis tempus imperdiet metus, eu tincidunt nunc volutpat nec. Proin eget libero id lacus pharetra vestibulum. Proin vehicula orci ex, vitae tincidunt ligula viverra quis. Vestibulum elit purus, vulputate ut lectus id, ornare tincidunt purus.Praesent mollis imperdiet libero et dictum. Ut egestas, ipsum nec sodales vehicula, magna quam pellentesque turpis, efficitur commodo turpis lacus cursus purus. Vivamus porttitor bibendum enim ac cursus. Aenean velit sem, vestibulum ac luctus ut, rhoncus sit amet dolor. Pellentesque ullamcorper tincidunt eros, vel gravida neque rhoncus in. In laoreet condimentum pellentesque. Vestibulum auctor neque congue lorem porttitor, in bibendum orci condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sagittis gravida felis, eu auctor nisi elementum ut. Vestibulum et augue eget elit rhoncus lacinia id eget libero. Proin sodales molestie pellentesque. Maecenas eget viverra erat. Ut quis velit at sem vulputate blandit. Fusce blandit lectus dolor, ut bibendum sapien accumsan vel. Nulla fringilla lorem gravida ligula pellentesque, sit amet ullamcorper libero dapibus. Nulla congue ultricies nisi consectetur tincidunt.",
                                style: Font.style(fontSize: 18)
                              ),
                            )
                          ]
                        )        
                      ),    
                    )
                  ),
                );
              },
              loading: () => Center(child: SpinKitCubeGrid(color: Palette.blueAccent)), 
              error: (_,__) => Text("a")
            );      
          },
          loading: (){return Center(child: SpinKitChasingDots());},
          error: (_,__){return Text("a");}
        );
      }
    );
  }
}