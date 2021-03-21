part of "../pages.dart";

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){
        final authModel = watch(authModelProvider);
        final dbProvider = watch(databaseProvider);
        // final onboardingViewModel = context.read(onboardingViewModelProvider);
        final eventListProvider = watch(eventStreamProvider);

        dbProvider.createUserData(authModel.auth.currentUser);

        print(eventListProvider);

        return HeaderPage(
          isDetailedPage: false,
          colorStart: HexColor("48A2D6"),
          colorEnd: HexColor("282C8B"),
          appBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Font.out(
                textAlign: TextAlign.start,
                title: "Event Terkini",
                fontSize: 24,
                color: Palette.white,
                family: "EinaBold"
              ),
              GestureDetector(
                onTap: (){},
                child: CircleAvatar(
                  radius: MQuery.height(0.035, context),
                  backgroundColor: Palette.lightBlueAccent,
                  backgroundImage: NetworkImage(authModel.auth.currentUser!.photoURL ?? "")
                ),
              ),             
            ],
          ),
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MQuery.height(0.025, context),
                vertical: MQuery.height(0.02, context)
              ),
              child: eventListProvider.data == null
                ? Center(
                    child: SpinKitCubeGrid(
                      color: Palette.blueAccent,
                      size: 50.0,
                    ),
                  )
                : eventListProvider.data!.when(
                    data: (event) => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: event.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => DetailedEventPage(index: index), transition: Transition.fadeIn);
                          },
                          child: Hero(
                            tag: "hero" + index.toString(),
                            child: EventCard(
                              index: index,
                              event: event[index],
                            ),
                          ),
                        );
                      }
                    ),
                    error: (_,__) => Text("a"),
                    loading: (){}
                  ) 
            )
          )
        );
      },
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