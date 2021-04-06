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
                    MQuery.height(0.025, context),
                    MQuery.height(0.03, context),
                    MQuery.height(0, context),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.help_outline_rounded),
                          onPressed: (){
                            Get.dialog(
                              Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal: MQuery.width(0.03, context)
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                                ),
                                elevation: 0.5,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: MQuery.height(0.6, context),
                                    maxHeight: MQuery.height(0.65, context),
                                    minWidth: MQuery.width(0.7, context),
                                    maxWidth: MQuery.width(0.7, context)
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    padding: EdgeInsets.all(MQuery.height(0.03, context)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_rounded, size: 42),
                                        SizedBox(height: MQuery.height(0.02, context)),
                                        Font.out(
                                          title: "Apa itu LiveChat?",
                                          family: "EinaSemibold",
                                          fontSize: 32,
                                          color: Palette.blueAccent
                                        ),
                                        SizedBox(height: MQuery.height(0.02, context)),
                                        Text(
                                          "LiveChat adalah fitur chat publik bagi semua user hellotori. \nHarap untuk berkomunikasi mengenai topik yang relevan dengan SMA 1 Wonosobo dan event terkait. Dan jangan lupa untuk memakai bahasa sopan dan hindari topik SARA ya guys! \nThank you! \n \n 🥂",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "EinaRegular",
                                            fontSize: 18,
                                            color: Palette.black
                                          )
                                        ),
                                      ],
                                    )
                                  )
                                )
                              )
                            );
                          },
                        ),
                        FadeInUp(
                          from: 5,
                          child: StreamBuilder<List<Chat>>(
                            stream: chatListRaw,
                            builder: (context, snapshot) {
                              List<Chat> chats = snapshot.data!;
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
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(
                            horizontal: MQuery.width(0.005, context)
                          ),
                          height: MQuery.height(0.2, context),
                          child: TextField(
                            minLines: 1,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            controller: controller,
                            style: Font.style(
                              fontSize: 18
                            ),
                            decoration: new InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send_rounded, color: Palette.blueAccent),
                                onPressed: (){
                                  if(controller.text != ""){
                                    dbProvider.addChat(
                                      authProvider.auth.currentUser!.uid,
                                      controller.text,
                                      DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now()).toString(), 
                                      ""
                                    );
                                  }
                                  controller.clear();
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.blueAccent, width: 1.5),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
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
