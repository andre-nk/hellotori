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
    PublicChatPage()
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
            icon: Icon(Icons.calendar_today_rounded, color: Palette.black.withOpacity(0.4), size: 24),
            activeIcon: Icon(Icons.calendar_today_rounded, color: Palette.blueAccent, size: 24)
          ),
          BottomNavigationBarItem(
            label: "a",
            icon: Icon(Icons.school_outlined, color:Palette.black.withOpacity(0.4), size: 30),
            activeIcon: Icon(Icons.school_outlined, color: Palette.blueAccent, size: 30),
          ),
          BottomNavigationBarItem(
            label: "a",
            icon: Icon(Icons.chat_bubble_outline, color: Palette.black.withOpacity(0.4), size: 26),
            activeIcon: Icon(Icons.chat_bubble_outline, color: Palette.blueAccent, size: 26),
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
        // final storeProvider = watch(storageProvider);

        dbProvider.createUserData(authModel.auth.currentUser);

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
                  Get.to(() => ProfilePage(), transition: Transition.cupertino); 
                  // String _image;
                  // final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

                  // setState(() {
                  //   if (pickedFile != null) {
                  //     _image = pickedFile.path;
                  //     storeProvider.uploadFile(_image);
                  //   } else {
                  //     print('No image selected.');
                  //   }
                  // });                 
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
                    data: (event) => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: event.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => DetailedEventPage(
                                index: index, share: [event[index].videoLink, event[index].share],
                              ), 
                            transition: Transition.fadeIn);
                          },
                          child: Hero(
                            tag: "hero" + index.toString(),
                            child: EventCard(
                              index: index,
                              event: event[index],
                            ),
                          ),
                        );
                      }
                    ),
                    error: (_,__) => Text("a"),
                    loading: (){
                      
                    }
                ) 
              ),
            ),
          ),
        );
      }
    );
  }
}