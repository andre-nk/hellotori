part of "../pages.dart";

class PublicChatPage extends StatefulWidget {
  @override
  _PublicChatPageState createState() => _PublicChatPageState();
}

class _PublicChatPageState extends State<PublicChatPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _){
        final authProvider = watch(authModelProvider);
        final dbProvider = watch(databaseProvider);
        var chatListRaw = dbProvider.chatList("");
        TextEditingController controller = TextEditingController();
        ScrollController scrollController = ScrollController();         

        if(scrollController.hasClients){
          scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );          
        }  

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    MQuery.height(0.03, context),
                    MQuery.height(0.05, context),
                    MQuery.height(0.03, context),
                    MQuery.height(0, context),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        FadeInUp(
                          child: StreamBuilder<List<Chat>>(
                            stream: chatListRaw,
                            builder: (context, snapshot) {
                              List<Chat> chats = snapshot.data!;
                              print(chats);
                              return Container(
                                width: MQuery.width(1, context),
                                height: MQuery.height(0.65, context),
                                child: ShaderMask(
                                  shaderCallback: (Rect rect) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.purple,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.purple
                                      ],
                                      stops: [
                                        0.0,
                                        0.05,
                                        0.95,
                                        1.0
                                      ], // 10% purple, 80% transparent, 10% purple
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstOut,
                                  child: ListView.builder(
                                    controller: scrollController,
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: chats.length,
                                    itemBuilder: (context, index) {
                                      print(chats[index]);
                                      return BubbleMessage(
                                        uid: chats[index].senderUID,
                                        dateTime: chats[index].dateTime,
                                        message: chats[index].message,
                                      );
                                    },
                                  ),
                                )
                              );
                            }
                          ),
                        ),                                   
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.symmetric(
                            horizontal: MQuery.width(0.005, context)
                          ),
                          height: MQuery.height(0.1, context),
                          child: TextField(
                            onSubmitted: (str){
                              dbProvider.addChat(
                                authProvider.auth.currentUser!.uid,
                                controller.text,
                                DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now()).toString(), 
                                ""
                              );
                              controller.clear();
                            },
                            maxLines: 1,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.send,
                            controller: controller,
                            style: Font.style(
                              fontSize: 18
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.blueAccent, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 18),
                              hintText: "Ketik pesanmu...",
                              fillColor: Colors.white70
                            ),
                          ),
                        )                   
                      ],
                    ),
                  ),
                ),
            ),
            ),
        );    
      }
    );
  }
}
