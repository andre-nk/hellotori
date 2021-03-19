part of "../pages.dart";

class DetailedEventPage extends StatefulWidget {

  final int? index;
  final Event? event;

  DetailedEventPage({@required this.index, @required this.event});

  @override
  _DetailedEventPageState createState() => _DetailedEventPageState();
}

class _DetailedEventPageState extends State<DetailedEventPage> {
  @override
  Widget build(BuildContext context) {
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
          child: widget.event == null
          ? Center(
              child: SpinKitCubeGrid(
                color: Palette.blueAccent,
                size: 50.0,
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "hero" + widget.index.toString(),
                      child: EventCard(
                        index: widget.index ?? 0,
                        event: widget.event!,
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
                            Font.out(
                              textAlign: TextAlign.start,
                              title: widget.event!.description,
                              fontSize: 18,
                              family: "EinaRegular"
                            ),
                            SizedBox(height: MQuery.height(0.03, context)),
                            widget.event!.type == "Live" 
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
                                      id: widget.event!.videoLink,
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