part of "../pages.dart";

class ImagePreviewer extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImagePreviewer({
    required this.imagePath,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: (){
                    Get.back();
                  },
                ),
                Font.out(
                  title: title,
                  fontSize: 18,
                  family: "EinaSemiBold"
                )
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: PinchZoom(
                    image: Image.network(imagePath),
                    zoomedBackgroundColor: Colors.black.withOpacity(0.3),
                    resetDuration: const Duration(milliseconds: 100),
                    maxScale: 2.5,
                    onZoomStart: (){print('Start zooming');},
                    onZoomEnd: (){print('Stop zooming');},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}