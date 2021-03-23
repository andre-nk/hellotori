part of "../pages.dart";

class HeaderPage extends StatelessWidget {
  final Widget? appBar;
  final Widget? child;
  final bool? isDetailedPage;

  HeaderPage({this.child, this.appBar, this.isDetailedPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
              ),
              height: MQuery.height(1, context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor("282C8B"),
                    HexColor("48A2D6")
                  ]
                )
              )
            ),    
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: isDetailedPage!
                ? MQuery.height(0.11, context)
                : MQuery.height(0.15, context),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor("282C8B"),
                      HexColor("48A2D6")
                    ]
                  )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  ),
                  child: child
                ),
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: isDetailedPage!
                ? MQuery.height(0.85, context)
                : MQuery.height(0.715, context),
              top: MQuery.height(0.0, context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MQuery.width(0.04, context)
                ),
                child: appBar
              )             
            ),      
          ],
        ),
      )
    );
  }
}
