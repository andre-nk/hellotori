part of "widgets.dart";

class EventCard extends StatelessWidget {

  final int? index;
  final Event? event;

  EventCard({@required this.index, @required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(                      
        image: DecorationImage(
          image: AssetImage("assets/classic_show_1.png"),
          fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.all(Radius.circular(35))
      ),
      margin: EdgeInsets.only(
        top: index == 0 ? 5 : MQuery.height(0.01, context)
      ),                       
      height: MQuery.height(0.35, context),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: MQuery.height(0.275, context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  HexColor("1D59A7"),
                  HexColor("48A2D6").withOpacity(0)
                ]
              )
            )
          ),    
          Positioned(
            top: MQuery.height(0.23, context),
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MQuery.height(0.03, context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Font.out(                              
                    title: event!.title ?? "",
                    fontSize: 24,
                    color: Palette.white,
                    family: "EinaSemiBold"                                   
                  ),
                  Font.out(
                    title: "Pukul " + event!.schedule!,
                    fontSize: 18,
                    color: Palette.white,
                    family: "EinaRegular"                                   
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: MQuery.height(0.25, context),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MQuery.height(0.03, context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Font.out(
                    title: "NOW SHOWING",
                    fontSize: 18,
                    color: Palette.white,
                    family: "EinaSemiBold"
                  ),
                  event!.type == "Live"
                  ? Image(
                      image: AssetImage("assets/live_icon.png"),
                    )
                  : Icon(Icons.access_alarms_rounded, color: Palette.white,)
                ],
              ),
            ),
          ),                             
        ],
      ),
    );
  }
}