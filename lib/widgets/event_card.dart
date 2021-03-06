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

    DateTime globalScheduleToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
    );

    String isScheduleToday(){
      return formattedDate.isAtSameMomentAs(globalScheduleToday) 
        ? "Pukul " + event.schedule.substring(event.schedule.length - 5, event.schedule.length)
        : event.schedule.toString().substring(0, event.schedule.length - 6) + ", pukul " + event.schedule.substring(event.schedule.length - 5, event.schedule.length);
    }

    String isScheduleLive(){
      return event.type == "Static" && DateFormat("dd MMMM yyyy HH:mm").parse(event.schedule).isBefore(globalScheduleToday)
        ? "Event OSIS!"
        : event.type == "Live" && formattedDate.isAtSameMomentAs(globalScheduleToday)
        ? "SIARAN LANGSUNG"
        : event.type == "Passed" || DateFormat("dd MMMM yyyy HH:mm").parse(event.schedule).isBefore(globalScheduleToday)
          ? "ACARA SELESAI"
          : "SEGERA TAYANG";
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      foregroundDecoration: BoxDecoration(
        color: isScheduleLive() == "ACARA SELESAI"
          ? Colors.grey 
          : Colors.transparent,
        backgroundBlendMode: BlendMode.saturation
      ),
      decoration: BoxDecoration(                      
        image: DecorationImage(
          image: NetworkImage(event.photo),
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
                  isScheduleLive() == "ACARA SELESAI" ? HexColor("48A2D6") :ColorCollection.generateColor(),
                  HexColor("48A2D6").withOpacity(0)
                ]
              )
            )
          ),    
          Positioned(
            top: MQuery.height(0.03, context),
            right: 0,
            left: 0,
            bottom: MQuery.height(0.03, context),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MQuery.height(0.03, context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Font.out( 
                        textAlign: TextAlign.start,                            
                        title: event.title.length > 25
                          ? event.title.substring(0,21) + "..."
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
                ],
              ),
            ),
          ),                            
        ],
      ),
    );
  }
}