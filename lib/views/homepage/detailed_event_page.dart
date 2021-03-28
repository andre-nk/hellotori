part of "../pages.dart";
class DetailedEventPage extends ConsumerWidget {

  final Event? event;
  final int? index;
  DetailedEventPage({this.event, this.index});

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final authModel = watch(authModelProvider);
    final eventListProvider = watch(eventStreamProvider);
    final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

    return mainUserProvider.when(
      data: (value){
        return SafeArea(
          child: HeaderPage(
            isDetailedPage: true,
            appBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Palette.white),
                  onPressed: (){
                    Get.back();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Palette.white),
                  onPressed: (){
                    Share.share(
                      event!.share
                    );
                  },
                )       
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
                      Get.to(() => EventControl(
                        uid: event!.uid,
                        title: event!.title,
                        description: event!.description,
                        link: event!.videoLink,
                        share: event!.share,
                        imageURL: event!.photo,
                        schedule: event!.schedule,
                        switchValue: event!.isChatEnabled,
                        currentLike: event!.likes,
                      ));
                    },
                  )
                : SizedBox(),
              body: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MQuery.height(0.025, context),
                  vertical: MQuery.height(0.02, context)
                ),
                child: eventListProvider.data!.when(
                  data: (event){
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.to(ImagePreviewer(imagePath: event[index!].photo, title: event[index!].title));
                              },
                              child: Hero(
                                tag: "hero" + index.toString(),
                                child: EventCard(
                                  index: index ?? 0,
                                  event: event[index!],
                                ),
                              ),
                            ),
                            SizedBox(height: MQuery.height(0.03, context)),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: MQuery.height(0.4, context)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MQuery.width(0.025, context)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Linkify(
                                      onOpen: (link) async {
                                        await launch(link.url);
                                      },
                                      text: event[index!].description,
                                      style: Font.style(fontSize: 18)
                                    ),  
                                    SizedBox(height: MQuery.height(0.15, context)),
                                    event[index!].type != "Static" || event[index!].type == "Passed"
                                      ? Container(
                                        height: MQuery.height(0.1, context),
                                        width: MQuery.width(0.5, context),
                                        decoration: BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Palette.blueAccent.withOpacity(0.15),
                                              blurRadius: 60,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: OnboardingButton(
                                            color: Colors.white,
                                            method: (){
                                              Get.to(() => LiveEventPage(
                                                index: index,
                                              ), transition: Transition.fadeIn);
                                            },
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Font.out(
                                                  title: "GABUNG KESERUANNYA!",
                                                  family: "EinaSemibold",
                                                  fontSize: 20,
                                                  color: Palette.blueAccent),
                                              ],
                                            ),
                                          ),
                                      )
                                      : SizedBox(),
                                    SizedBox(height: MQuery.height(0.03, context)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },   
                  error: (_,__) => Text("a"),
                  loading: (){}
                )   
              )
            )
          ),
        );
      },
      loading: () => Center(child: SpinKitCubeGrid(color: Palette.blueAccent)),
      error: (_,__) => Text("a")
    );
  }
}

