part of "../pages.dart";

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  int _index = 0;
  List<Widget> _children = [
    EventPageContent(),
    SchoolPage(),
    PublicChatPage(),
    ShopPage()
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _index = index;
      });
    }

    return Scaffold(
      body: _children[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: "a", 
            icon: Icon(Icons.calendar_today_outlined, color: Palette.black.withOpacity(0.4), size: 24),
            activeIcon: Icon(Icons.calendar_today_rounded, color: Palette.blueAccent, size: 24)
          ),
          BottomNavigationBarItem(
            label: "a",
            icon: Icon(Icons.school_outlined, color:Palette.black.withOpacity(0.4), size: 30),
            activeIcon: Icon(Icons.school, color: Palette.blueAccent, size: 30),
          ),
          BottomNavigationBarItem(
            label: "a",
            icon: Icon(Icons.chat_bubble_outline, color: Palette.black.withOpacity(0.4), size: 26),
            activeIcon: Icon(Icons.chat_bubble, color: Palette.blueAccent, size: 26),
          ),
          BottomNavigationBarItem(
            label: "a",
            icon: Icon(Icons.shopping_bag_outlined, color: Palette.black.withOpacity(0.4), size: 26),
            activeIcon: Icon(Icons.shopping_bag_rounded, color: Palette.blueAccent, size: 26),
          )
        ],
      ),
    );
  }
}

class EventPageContent extends StatefulWidget {
  @override
  _EventPageContentState createState() => _EventPageContentState();
}
class _EventPageContentState extends State<EventPageContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){
        final authModel = watch(authModelProvider);
        final dbProvider = watch(databaseProvider);
        final eventListProvider = watch(eventStreamProvider);
        final mainUserProvider = watch(mainUserStreamProvider(authModel.auth.currentUser!.uid));

        return mainUserProvider.when(
          data: (value){
            if(value.role != "Admin"){
              dbProvider.createUserData(authModel.auth.currentUser);
            }
            return HeaderPage(
              isDetailedPage: false,
              appBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Font.out(
                    textAlign: TextAlign.start,
                    title: "Event Terkini",
                    fontSize: 24,
                    color: Palette.white,
                    family: "EinaBold"
                  ),
                  GestureDetector(
                    onTap: () async {           
                      Get.to(() => ProfilePage(isMainPage: true), transition: Transition.cupertino);                 
                    },
                    child: Hero(
                      tag: "avatar",
                      child: CircleAvatar(
                        radius: MQuery.height(0.035, context),
                        backgroundColor: Palette.lightBlueAccent,
                        backgroundImage: NetworkImage(authModel.auth.currentUser!.photoURL ?? "")
                      ),
                    ),
                  ),             
                ],
              ),
              child: Scaffold(
                floatingActionButton: value.role == "Admin"
                  ? FloatingActionButton(
                      elevation: 2,
                      mini: false,
                      backgroundColor: Palette.blueAccent,
                      child: Icon(Icons.add_rounded, size: 28),
                      onPressed: () async {
                        Get.to(() => EventControl(), transition: Transition.cupertino);
                      },
                    )
                  : SizedBox(),
                body: FadeInUp(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MQuery.height(0.025, context),
                      vertical: MQuery.height(0.02, context)
                    ),
                    child: eventListProvider.data == null
                    ? Center(
                        child: SpinKitCubeGrid(
                          color: Palette.blueAccent,
                          size: 50.0,
                        ),
                      )
                    : eventListProvider.data!.when(
                        data: (event){

                          event.forEach((event) async {
                            var dateString    = event.schedule;
                            DateFormat format = new DateFormat("dd MMMM yy HH:mm");
                            DateTime formattedDate = format.parse(dateString);

                            if(formattedDate.isBefore(DateTime.now())){
                              print("hiya");
                            } else {
                              final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

                              var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                                'alarm_notif',
                                'alarm_notif',
                                'Channel for Alarm notification',
                                icon: 'ic_stat_tori',
                                largeIcon: DrawableResourceAndroidBitmap('ic_stat_tori'),
                              );

                              var iOSPlatformChannelSpecifics = IOSNotificationDetails(
                                  presentAlert: true,
                                  presentBadge: true,
                                  presentSound: true
                              );

                              var platformChannelSpecifics = NotificationDetails(
                                  android: androidPlatformChannelSpecifics,
                                  iOS: iOSPlatformChannelSpecifics);

                              // ignore: deprecated_member_use
                              await flutterLocalNotificationsPlugin.schedule(
                                0,
                                "Acara ${event.title} udah mulai!", 
                                "Ayo ikuti keseruannya hanya di App Hellotori",
                                DateTime.now().add(Duration(seconds: 5)),
                                platformChannelSpecifics,
                                androidAllowWhileIdle: true
                              );    
                            }                 
                          });

                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: event.length,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  Get.to(() => DetailedEventPage(
                                      index: index,
                                      event: event[index],
                                    ), 
                                  transition: Transition.fadeIn);
                                },
                                child: Hero(
                                  tag: "hero" + index.toString(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MQuery.height(0.03, context)
                                    ),
                                    child: EventCard(
                                      index: index,
                                      event: event[index],
                                    ),
                                  ),
                                ),
                              );
                            }
                          );
                        },
                        error: (_,__) => Text("a"),
                        loading: (){
                          
                        }
                    ) 
                  ),
                ),
              ),
            );
          },
          loading: () => Center(child: SpinKitCubeGrid(color: Palette.blueAccent,)),
          error: (_,__) => Text("a")
        );
      }
    );
  }
}