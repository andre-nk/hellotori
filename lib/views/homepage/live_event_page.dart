part of "../pages.dart";

class LiveEventPage extends StatefulWidget {

  final int? index;
  const LiveEventPage({Key? key, this.index}) : super(key: key);

  @override
  _LiveEventPageState createState() => _LiveEventPageState();
}

class _LiveEventPageState extends State<LiveEventPage> with TickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String videoIDGetter(String url){
      url = url.replaceAll("https://www.youtube.com/watch?v=", "");
      return url;
    }
    return SafeArea(
      child: Consumer(
        builder: (context, watch, _){
          final eventListProvider = watch(eventStreamProvider);
          final dbProvider = watch(databaseProvider);
          
          return eventListProvider.data!.when(
            data: (event){
              print(event[widget.index!].likes);
              // ignore: close_sinks
              YoutubePlayerController _controller = YoutubePlayerController(
                initialVideoId: videoIDGetter(event[widget.index!].videoLink),
                params: YoutubePlayerParams( // Defining custom playlist
                    showControls: true,
                    showFullscreenButton: true,
                    desktopMode: Platform.isWindows || Platform.isMacOS ? true : false
                ),
              );

              String schedule = event[widget.index!].schedule;

              List activityIntentRaw = jsonDecode(event[widget.index!].activityIntent);
              List<ActivityIntent> activityIntents = [];

              activityIntentRaw.forEach((element) {
                activityIntents.add(
                  ActivityIntent(
                    id: element["id"],
                    title: element["title"],
                    description: element["description"],
                    multipleChoices: element["multipleChoices"], 
                    answer: element["answer"], 
                    isActive: element["isActive"]
                  )
                );
              });

              bool isActivityIntentActive(){
                bool val = false;
                activityIntents.forEach((element) {
                  if(element.isActive == true){
                    val = true;
                    //TODO: LOCAL NOTIFICATION
                  } else {
                    val = val;
                  }
                });
                return val;
              }

              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
                        controller: _controller,
                        child: YoutubePlayerIFrame(
                          aspectRatio: 16 / 9,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 17,
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(MQuery.width(0.03, context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MQuery.width(0.3, context),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Font.out(
                                          textAlign: TextAlign.start,                             
                                          title: event[widget.index!].title,
                                          fontSize: 24,
                                          color: Palette.black,
                                          family: "EinaBold"                                   
                                        ),
                                        SizedBox(height: MQuery.height(0.01, context),),
                                        Font.out(
                                          textAlign: TextAlign.start,
                                          title: schedule.toString().substring(0, schedule.length - 6) + ", pukul " + schedule.substring(schedule.length - 5, schedule.length),
                                          fontSize: 18,
                                          color: Palette.black,
                                          family: "EinaRegular"                                   
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MQuery.width(0.11, context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        activityIntents.length < 0
                                        ? Icon(HelloTori.cross, size: 26, color: Palette.blueAccent)
                                        : activityIntents.length > 0 && isActivityIntentActive() 
                                          ? Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    Get.dialog(
                                                      IntentDialog(
                                                        intents: activityIntents,
                                                      )                                                       
                                                    );
                                                  },
                                                  child: Icon(HelloTori.horn, size: 26, color: Palette.blueAccent)
                                                ),
                                                Positioned(
                                                  top: MQuery.height(0.02, context),
                                                  left: MQuery.width(0.015, context),
                                                  child: Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                            : Icon(HelloTori.horn, size: 26, color: Palette.blueAccent),
                                        Heart(
                                          dbProvider: dbProvider,
                                          event: event[widget.index!],
                                        )
                                      ]   
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: MQuery.height(0.03, context),),
                              Container(
                                width: MQuery.width(1, context),
                                color: HexColor("C4C4C4"),
                                height: 1,
                              ),
                            ],
                          ),
                        ),          
                      ),
                    )
                  ],
                ),
              );
            },
            error: (_,__) => Text("a"),
            loading: (){
              return SpinKitChasingDots();
            }
          );
        }
      )
    );
  }
}
