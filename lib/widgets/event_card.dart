part of "widgets.dart";

class EventCard extends StatelessWidget {
  final int index;
  final Event event;

  EventCard({required this.index, required this.event});

  @override
  Widget build(BuildContext context) {

    var dateString    = event.schedule.substring(0, event.schedule.length - 5);
    DateFormat format = new DateFormat("dd MMMM yy");
    var formattedDate = format.parse(dateString);

    DateTime scheduleHm = DateTime(
      formattedDate.year,
      formattedDate.month,
      formattedDate.day,
      DateFormat("hh:mm").parse(event.schedule.substring(event.schedule.length - 5, event.schedule.length)).hour,
      DateFormat("hh:mm").parse(event.schedule.substring(event.schedule.length - 5, event.schedule.length)).minute
    );

     DateTime globalScheduleToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
    );

    print(!formattedDate.isAtSameMomentAs(globalScheduleToday));

    String isScheduleToday(){
      return !formattedDate.isAtSameMomentAs(globalScheduleToday) 
        ? "Pukul " + event.schedule.substring(event.schedule.length - 5, event.schedule.length)
        : event.schedule.toString().substring(0, event.schedule.length - 6) + ", pukul " + event.schedule.substring(event.schedule.length - 5, event.schedule.length);
    }

    String isScheduleLive(){
      return DateTime.now().isBefore(scheduleHm)
        ? "UPCOMING EVENT" 
        : event.type == "Live"
          ? "NOW SHOWING"
          : "PASSED EVENT";
    }
  // print(schedule.toString() + " " + DateTime.now().toString());

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
            top: MQuery.height(0.24, context),
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
                    textAlign: TextAlign.start,                            
                    title: event.title.length > 20
                      ? event.title.substring(0,16) + "..."
                      : event.title,
                    fontSize: 24,
                    color: Palette.white,
                    family: "EinaSemiBold"                                   
                  ),
                  Font.out(
                    title: isScheduleToday(),
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
                    title: isScheduleLive(),
                    fontSize: 18,
                    color: Palette.white,
                    family: "EinaSemiBold"
                  ),
                  event.type == "Live"
                  ? Image(
                      image: AssetImage("assets/live_icon.png"),
                    )
                  : event.type == "Passed"
                    ? SizedBox()
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