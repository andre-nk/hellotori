part of "../pages.dart";

class DetailedEventPage extends StatelessWidget {

  final int? index;
  final Event? event;

  DetailedEventPage({@required this.index, @required this.event});

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
          child: event == null
            ? Center(
                child: SpinKitCubeGrid(
                  color: Palette.blueAccent,
                  size: 50.0,
                ),
              )
            : Hero(
                tag: "hero" + index.toString(),
                child: EventCard(
                  index: index,
                  event: event,
                ),
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