part of "../pages.dart";

class SchoolPage extends StatefulWidget {
  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {

  List<Map<String, String>> cardData = [
    {
      "title": "Seputar SMANSA!",
      "image": "assets/smansa_photo.png"
    },
    {
      "title": "Tentang OSIS!",
      "image": "assets/osis_photo.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return HeaderPage(
      isDetailedPage: false,
      appBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Font.out(
            textAlign: TextAlign.start,
            title: "SMANSA dan OSIS",
            fontSize: 24,
            color: Palette.white,
            family: "EinaBold"
          ),            
        ],
      ),
      child: Scaffold(
        body: Consumer(
          builder: (context, watch, _){
            final schoolProvider = watch(schoolStreamProvider);
            return schoolProvider.when(
              data: (data){
                return FadeInUp(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MQuery.height(0.025, context),
                      vertical: MQuery.height(0.02, context)
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: cardData.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => index == 0 ? SchoolPageContent() : OSISPage(),
                            transition: Transition.fadeIn);
                          },
                          child: Hero(
                            tag: index == 0 ? "School" : "OSIS",
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(                      
                                image: DecorationImage(
                                  image: AssetImage(cardData[index]["image"] ?? ""),
                                  fit: BoxFit.fill
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(35))
                              ),
                              margin: EdgeInsets.only(
                                top: index.isEven ? MQuery.height(0.01, context) : MQuery.height(0.035, context)
                              ),                       
                              height: MQuery.height(0.35, context),
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Container(
                                    height: MQuery.height(0.275, context),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          HexColor("1D59A7"),
                                          HexColor("48A2D6").withOpacity(0)
                                        ]
                                      )
                                    )
                                  ),    
                                  Positioned(
                                    top: MQuery.height(0.03, context),
                                    right: 0,
                                    left: 0,
                                    bottom: MQuery.height(0.03, context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MQuery.height(0.03, context),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Font.out(
                                                title: "",
                                                fontSize: 18,
                                                color: Palette.white,
                                                family: "EinaSemiBold"
                                              ),
                                            ],
                                          ),           
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Font.out( 
                                                textAlign: TextAlign.start,                            
                                                title: cardData[index]["title"],
                                                fontSize: 24,
                                                color: Palette.white,
                                                family: "EinaSemiBold"                                   
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),                            
                                ],
                              ),
                            )   
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => Center(
                child: SpinKitCubeGrid(
                  color: Palette.blueAccent,
                ),
              ),
              error: (_,__){
                return Text("a");
              }
            );
          },
        ),
      )
    );
  }
}

class SchoolPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){

        final schoolProvider = watch(schoolStreamProvider);
        final authModel = watch(authModelProvider);
        final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

        return mainUserProvider.when(
          data: (value){
            return schoolProvider.when(
              data: (data){
                return SafeArea(
                  child: HeaderPage(
                    isDetailedPage: true,
                    appBar: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Font.out(
                          textAlign: TextAlign.start,
                          title: data.headline == "" ? "Tentang SMANSA" : data.headline,
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
                              print(mainUserProvider.data!.value.role);
                            },
                          )
                        : SizedBox(),
                      body: FadeInUp(
                        child: Hero(
                          tag: "School",
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: MQuery.height(0.025, context),
                              vertical: MQuery.height(0.035, context)
                            ),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                data.photoURL[0] != ""
                                  ? Container(
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
                                    ) 
                                  : Image(image: AssetImage("assets/smansa_photo.png")),
                                SizedBox(height: MQuery.height(0.03, context)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MQuery.height(0.02, context)
                                  ),
                                  child: Linkify(
                                    text: data.article != "" ? data.article : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis velit urna, cursus vitae sollicitudin sit amet, scelerisque nec lorem. Cras ultricies ante quis magna consequat cursus. Integer pretium turpis nec dictum molestie. Ut maximus luctus metus, eu elementum turpis luctus et. Curabitur id justo ultrices magna porttitor vehicula eu et ante. Pellentesque velit est, maximus eget ornare a, faucibus eget metus. Phasellus eleifend tincidunt leo, a rutrum libero ullamcorper et. Sed interdum enim felis. In placerat elit purus, sed euismod tortor suscipit eu. Duis tempus imperdiet metus, eu tincidunt nunc volutpat nec. Proin eget libero id lacus pharetra vestibulum. Proin vehicula orci ex, vitae tincidunt ligula viverra quis. Vestibulum elit purus, vulputate ut lectus id, ornare tincidunt purus.Praesent mollis imperdiet libero et dictum. Ut egestas, ipsum nec sodales vehicula, magna quam pellentesque turpis, efficitur commodo turpis lacus cursus purus. Vivamus porttitor bibendum enim ac cursus. Aenean velit sem, vestibulum ac luctus ut, rhoncus sit amet dolor. Pellentesque ullamcorper tincidunt eros, vel gravida neque rhoncus in. In laoreet condimentum pellentesque. Vestibulum auctor neque congue lorem porttitor, in bibendum orci condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sagittis gravida felis, eu auctor nisi elementum ut. Vestibulum et augue eget elit rhoncus lacinia id eget libero. Proin sodales molestie pellentesque. Maecenas eget viverra erat. Ut quis velit at sem vulputate blandit. Fusce blandit lectus dolor, ut bibendum sapien accumsan vel. Nulla fringilla lorem gravida ligula pellentesque, sit amet ullamcorper libero dapibus. Nulla congue ultricies nisi consectetur tincidunt.",
                                    style: Font.style(fontSize: 18)
                                  ),
                                )
                              ]
                            )        
                          ),
                        ),
                      )
                    ),
                  ),
                );
              },
              loading: () => Center(
                child: SpinKitCubeGrid(
                  color: Palette.blueAccent,
                ),
              ),
              error: (_,__){
                return Text("a");
              }
            );
          },
          loading: (){return Center(child: SpinKitChasingDots());},
          error: (_,__){return Text("a");}
        );
      },
    );
  }
}