part of "widgets.dart";

class BubbleMessage extends ConsumerWidget {
  final String uid;
  final String message;
  final String dateTime;

  BubbleMessage({required this.uid, required this.message, required this.dateTime});
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authModel = watch(authModelProvider);
    final dbModel = watch(databaseProvider);

    var dateString    = dateTime.substring(0, dateTime.length - 5);
    DateFormat format = new DateFormat("dd MMMM yyyy");
    DateFormat format2 = new DateFormat("yMd");
    var formattedDate = format.parse(dateString);

    DateTime globalScheduleToday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day
    );

    String isScheduleToday(){
      return formattedDate.isAtSameMomentAs(globalScheduleToday) 
      ? dateTime.substring(dateTime.length - 5, dateTime.length)
      : format2.format(formattedDate) + ", " + dateTime.substring(dateTime.length - 5, dateTime.length);
    }
    
    return uid == authModel.auth.currentUser!.uid
      ? Padding(
          padding: EdgeInsets.symmetric(
            vertical: MQuery.height(0.02, context)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MQuery.height(0.09, context),
                  minWidth: MQuery.width(0.2, context),
                  maxWidth: MQuery.width(0.3, context),

                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MQuery.height(0.02, context),
                    vertical: MQuery.height(0.015, context)
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Palette.lightBlueAccent
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Linkify(
                        text: message,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 16,
                          fontFamily: "EinaRegular"
                        ),
                      ),
                      SizedBox(height: MQuery.height(0.01, context)),
                      Font.out(
                        title: isScheduleToday(),
                        color: Palette.black.withOpacity(0.5),
                        fontSize: 12
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: MQuery.width(0.02, context)),
              CircleAvatar(
                radius: MQuery.height(0.025, context),
                backgroundColor: Palette.lightBlueAccent,
                backgroundImage: NetworkImage(authModel.auth.currentUser!.photoURL ?? "")
              )
            ],
          ),
        )
      : StreamBuilder<OtherUser>(
        stream: dbModel.otherUserProfile(uid),
        builder: (context, snapshot) {
          OtherUser? otherUser = snapshot.data;
          return Padding(
              padding: EdgeInsets.symmetric(
                vertical: MQuery.height(0.02, context)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: MQuery.height(0.025, context),
                    backgroundColor: Palette.lightBlueAccent,
                    backgroundImage: NetworkImage(otherUser!.profilePicture)
                  ),
                  SizedBox(width: MQuery.width(0.02, context)),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MQuery.height(0.12, context),
                      minWidth: MQuery.width(0.2, context),
                      maxWidth: MQuery.width(0.3, context),

                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MQuery.height(0.02, context),
                        vertical: MQuery.height(0.015, context)
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Palette.lightBlueAccent.withOpacity(0.5)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Font.out(
                            title: otherUser.name,
                            color: Palette.black,
                            fontSize: 14,
                            family: "EinaSemiBold",
                            textAlign: TextAlign.start
                          ),
                          SizedBox(height: MQuery.height(0.0025, context)),
                          Linkify(
                            text: message,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Palette.black,
                              fontSize: 16,
                              fontFamily: "EinaRegular"
                            ),
                          ),
                          SizedBox(height: MQuery.height(0.0025, context)),
                          Font.out(
                            title: isScheduleToday(),
                            color: Palette.black.withOpacity(0.5),
                            fontSize: 12
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      );
  }
}