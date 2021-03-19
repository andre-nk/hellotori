part of "../pages.dart";

class LiveEventPage extends StatefulWidget {

  final String? id;

  const LiveEventPage({Key? key, this.id}) : super(key: key);


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
      url = url.replaceAll("https://m.youtube.com/watch?v=", "");
      return url;
    }

    // ignore: close_sinks
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: "VvX7OubU4oc",
      params: YoutubePlayerParams( // Defining custom playlist
          startAt: Duration(seconds: 30),
          showControls: true,
          showFullscreenButton: true,
      ),
    );

    return SafeArea(
      child: Column(
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
              color: Colors.red,
              
            ),
          )
        ],
      )
    );
  }
}
