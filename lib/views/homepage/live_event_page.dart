part of "../pages.dart";

class LiveEventPage extends StatefulWidget {

  final int? index;

  const LiveEventPage({Key? key, this.index}) : super(key: key);


  @override
  _LiveEventPageState createState() => _LiveEventPageState();
}

class _LiveEventPageState extends State<LiveEventPage> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    String videoIDGetter(String url){
      url = url.replaceAll("https://www.youtube.com/watch?v=", "");
      print(url);
      return url;
    }

    return SafeArea(
      child: Consumer(
        builder: (context, watch, _){

          final eventListProvider = watch(eventStreamProvider);

          return eventListProvider.data!.when(
            data: (event){
              // ignore: close_sinks
              YoutubePlayerController _controller = YoutubePlayerController(
                initialVideoId: videoIDGetter(event[widget.index!].videoLink),
                params: YoutubePlayerParams( // Defining custom playlist
                    showControls: true,
                    showFullscreenButton: true,
                    desktopMode: Platform.isWindows || Platform.isMacOS ? true : false
                ),
              );
              return Scaffold(
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
                                          title: event[widget.index!].title.length > 20
                                            ? event[widget.index!].title.substring(0,17) + "\n" + event[widget.index!].title.substring(20,event[widget.index!].title.length)
                                            : event[widget.index!].title,
                                          fontSize: 24,
                                          color: Palette.black,
                                          family: "EinaBold"                                   
                                        ),
                                        SizedBox(height: MQuery.height(0.01, context),),
                                        Font.out(
                                          textAlign: TextAlign.start,
                                          title: "Pukul " + event[widget.index!].schedule,
                                          fontSize: 18,
                                          color: Palette.black,
                                          family: "EinaRegular"                                   
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MQuery.width(0.1, context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(HelloTori.horn, size: 26, color: Palette.blueAccent),
                                        Icon(LineIcons.heart, size: 28, color: Palette.blueAccent),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: MQuery.height(0.03, context),),
                              Container(
                                width: MQuery.width(1, context),
                                color: HexColor("C4C4C4"),
                                height: 1,
                              )
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
