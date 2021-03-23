part of "../pages.dart";

class LiveEventPage extends StatefulWidget {

  final int? index;
  const LiveEventPage({Key? key, this.index}) : super(key: key);

  @override
  _LiveEventPageState createState() => _LiveEventPageState();
}

class _LiveEventPageState extends State<LiveEventPage> with TickerProviderStateMixin{
  
  ScrollController scrollController = ScrollController();         

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
          final authProvider = watch(authModelProvider);
          // final onboardingViewModel = context.read(onboardingViewModelProvider);
          
          return eventListProvider.data!.when(
            data: (event){            
              //YOUTUBE PLAYER SET UP
              // ignore: close_sinks
              YoutubePlayerController _controller = YoutubePlayerController(
                initialVideoId: videoIDGetter(event[widget.index!].videoLink),
                params: YoutubePlayerParams( // Defining custom playlist
                    showControls: true,
                    showFullscreenButton: true,
                    desktopMode: Platform.isWindows || Platform.isMacOS ? true : false
                ),
              );
              _controller.onEnterFullscreen = () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              };
              _controller.onExitFullscreen = () {
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                Future.delayed(const Duration(seconds: 1), () {
                  _controller.play();
                });
                Future.delayed(const Duration(seconds: 5), () {
                  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                });
              };

              //ACTIVITY INTENTS
              // onboardingViewModel.setFirestoreLiveKey(event[widget.index!].activityIntent);
              // List activityIntentRaw = jsonDecode(onboardingViewModel.firestoreLiveKey);
              // List<ActivityIntent> activityIntents = [];
              // activityIntentRaw.forEach((element) {
              //   activityIntents.add(
              //     ActivityIntent(
              //       id: element["id"],
              //       title: element["title"],
              //       description: element["description"],
              //       multipleChoices: element["multipleChoices"], 
              //       answer: element["answer"], 
              //       isActive: element["isActive"]
              //     )
              //   );
              // });

              //ACTIVITY INTENT
              var intentListRaw = dbProvider.intentList(event[widget.index!].uid);
              bool isActivityIntentActive(List<ActivityIntent> activityIntents){
                bool val = false;
                activityIntents.forEach((element) {
                  if(element.isActive == true){
                    val = true;
                  } else {
                    val = val;
                  }
                });
                return val;
              }
              print(intentListRaw.length);

              //LIVE CHAT
              var chatListRaw = dbProvider.chatList(event[widget.index!].uid);

              //CONSTANTS
              String schedule = event[widget.index!].schedule;
              TextEditingController controller = TextEditingController();

              return Scaffold(
                resizeToAvoidBottomInset: true,
                body: ListView(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Container(
                      height: MQuery.height(1.2, context),
                      child: Stack(
                        children: [
                          Container(
                            height: MQuery.height(1.25, context),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
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
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MQuery.width(1, context),
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
                                                      SizedBox(height: MQuery.height(0.005, context),),
                                                      Font.out(
                                                        textAlign: TextAlign.start,
                                                        title: schedule.toString().substring(0, schedule.length - 6) + ", pukul " + schedule.substring(schedule.length - 5, schedule.length),
                                                        fontSize: 16,
                                                        color: Palette.black,
                                                        family: "EinaRegular"                                   
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: MQuery.height(0.015, context),),
                                                Container(
                                                  width: MQuery.width(1, context),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.share, color: Palette.blueAccent,),
                                                        onPressed: (){},
                                                      ),
                                                      IconButton(
                                                        onPressed: (){
                                                          scrollController.animateTo(
                                                            0.0,
                                                            curve: Curves.easeOut,
                                                            duration: const Duration(milliseconds: 300),
                                                          );
                                                        },
                                                        icon: Icon(Icons.comment_outlined, color: Palette.blueAccent, size: 26)
                                                      ),
                                                      Heart(
                                                        dbProvider: dbProvider,
                                                        event: event[widget.index!],
                                                      ),
                                                      StreamBuilder<List<ActivityIntent>>(
                                                        stream: intentListRaw,
                                                        builder: (context, snapshot){
                                                          List<ActivityIntent>? activityIntents;
                                                          activityIntents = snapshot.data;
                                                          return snapshot.hasData == true
                                                          ? activityIntents!.length < 0
                                                              ? IconButton(
                                                                  onPressed: (){},
                                                                  icon: Icon(HelloTori.horn, size: 26, color: Palette.blueAccent)
                                                                )
                                                              : activityIntents.length > 0 && isActivityIntentActive(activityIntents) 
                                                                ? Stack(
                                                                    clipBehavior: Clip.none,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed: (){
                                                                          Get.dialog(
                                                                            IntentDialog(
                                                                              targetEvent: event[widget.index!],
                                                                            )                                                       
                                                                          );
                                                                        },
                                                                        icon: Icon(HelloTori.horn, size: 26, color: Palette.blueAccent)
                                                                      ),                                                           
                                                                      Positioned(
                                                                        top: 25,
                                                                        left: 25,
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
                                                                  : IconButton(
                                                                      onPressed: (){},
                                                                      icon: Icon(HelloTori.horn, size: 26, color: Palette.blueAccent)
                                                                    )
                                                          : SizedBox();                      
                                                        }
                                                      )
                                                    ]   
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: MQuery.height(0.015, context)),
                                            Container(
                                              width: MQuery.width(1, context),
                                              color: HexColor("C4C4C4"),
                                              height: 1,
                                            ),
                                            SizedBox(height: MQuery.height(0.03, context)),
                                            StreamBuilder<List<Chat>>(
                                              stream: chatListRaw,
                                              builder: (context, snapshot){
                                                List<Chat> chats = snapshot.data!;
                                                return snapshot.data != null
                                                  ? Container(
                                                      width: MQuery.width(1, context),
                                                      height: MQuery.height(0.55, context),
                                                      child: ShaderMask(
                                                        shaderCallback: (Rect rect) {
                                                          return LinearGradient(
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                                                            stops: [0.0, 0.05, 0.95, 1.0], // 10% purple, 80% transparent, 10% purple
                                                          ).createShader(rect);
                                                        },
                                                        blendMode: BlendMode.dstOut,
                                                        child: ListView.builder(
                                                          reverse: true,
                                                          physics: BouncingScrollPhysics(),
                                                          itemCount: chats.length,
                                                          itemBuilder: (context, index){
                                                            return BubbleMessage(
                                                              uid: chats[index].senderUID,
                                                              dateTime: chats[index].dateTime,
                                                              message: chats[index].message,
                                                            );
                                                          },
                                                        ),                                                        
                                                      )
                                                    )
                                                  : SizedBox();
                                              }
                                            )
                                          ],
                                        ),
                                      ),
                                    ),          
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: MQuery.height(1.1, context),
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MQuery.width(0.02, context)
                              ),
                              height: MQuery.height(0.1, context),
                              child: TextField(
                                onSubmitted: (str){
                                  dbProvider.addChat(
                                    authProvider.auth.currentUser!.uid,
                                    controller.text,
                                    DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now()).toString(), 
                                    event[widget.index!].uid);
                                  controller.clear();
                                },
                                maxLines: 1,
                                textCapitalization: TextCapitalization.sentences,
                                textInputAction: TextInputAction.send,
                                controller: controller,
                                style: Font.style(
                                  fontSize: 18
                                ),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(color: Palette.blueAccent, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(50.0),
                                    ),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(50.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 18),
                                  hintText: "Ketik pesanmu...",
                                  fillColor: Colors.white70
                                ),
                              ),
                            )
                          )
                        ],
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
