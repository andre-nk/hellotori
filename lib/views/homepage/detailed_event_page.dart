part of "../pages.dart";
class DetailedEventPage extends ConsumerWidget {

  final int? index;
  DetailedEventPage({this.index});

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final eventListProvider = watch(eventStreamProvider);

    return HeaderPage(
      isDetailedPage: true,
      colorStart: HexColor("48A2D6"),
      colorEnd: HexColor("282C8B"),
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
              // Share.share("Classic Oi!");
            },
          )       
        ],
      ),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MQuery.height(0.025, context),
            vertical: MQuery.height(0.02, context)
          ),
          child: eventListProvider.data!.when(
            data: (event) => ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "hero" + index.toString(),
                      child: EventCard(
                        index: index ?? 0,
                        event: event[index!],
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
                            event[index!].type == "Live" 
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
            ),    
            error: (_,__) => Text("a"),
            loading: (){}
          )   
        )
      )
    );
  }
}

// ElevatedButton(
//   child: Text(eventListProvider.data.toString()),
//   onPressed: (){
//     authModel.signOutWithGoogle();
//     onboardingViewModel.cancelCompleteOnboarding();
//   },
// )