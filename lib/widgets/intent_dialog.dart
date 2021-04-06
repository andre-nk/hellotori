part of 'widgets.dart';

class IntentDialog extends StatefulWidget {

  final Event? targetEvent;

  IntentDialog({required this.targetEvent});

  @override
  _IntentDialogState createState() => _IntentDialogState();
}

class _IntentDialogState extends State<IntentDialog> {

  bool isDefault = true;
  List<bool> isAnswerPage = [false, false];

  ActivityIntent targetIntent = ActivityIntent(
    title: "",
    multipleChoices: [],
    answer: "",
    isActive: true,
    description: "",
    uid: "",
    imageURL: "",
    userWithRightAnswer: [""],
    userWithWrongAnswer: [""],
  );

  TextEditingController controller = TextEditingController();

  String alphanumGenerator(int index){
    return index == 0
      ? "A"
      : index == 1
        ? "B"
        : index == 2
          ? "C"
          : index == 3
            ? "D"
            : "";
  }

  bool answerReviewer(String answer){
    return answer == targetIntent.answer
      ? true
      : false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ScopedReader watch, _){
        final dbProvider = watch(databaseProvider);
        final authProvider = watch(authModelProvider);
        var intentListRaw = dbProvider.intentList(widget.targetEvent!.uid);

        return StreamBuilder<List<ActivityIntent>>(
          stream: intentListRaw,
          builder: (context, snapshot){
            List<ActivityIntent>? activityIntents;
            if(snapshot.hasData){
              activityIntents = snapshot.data!.where(
                (element) => element.isActive == true
              ).toList();
            }

            activityIntents!.removeWhere((element) => 
              element.userWithRightAnswer.contains(authProvider.auth.currentUser!.uid) ||
              element.userWithWrongAnswer.contains(authProvider.auth.currentUser!.uid)
            );

            return Dialog(
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
                  maxHeight: MQuery.height(0.8, context),
                  minWidth: MQuery.width(0.7, context),
                  maxWidth: MQuery.width(0.7, context)
                ),
                child: isDefault
                ? Padding( //DEFAULT
                    padding: EdgeInsets.all(MQuery.height(0.03, context)),
                    child: FadeInUp(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: (){
                                Get.back();
                              },
                              icon: Icon(HelloTori.cross, size: 20)
                            )
                          ),
                          SizedBox(height: MQuery.height(0.02, context)),
                          Icon(HelloTori.horn, size: 56, color: Palette.blueAccent),
                          SizedBox(height: MQuery.height(0.015, context)),
                          Font.out(
                            title: "Notifikasi Acara",
                            fontSize: MQuery.height(0.04, context).toInt(),
                            color: Palette.blueAccent,
                            family: "EinaSemibold"
                          ),
                          SizedBox(height: MQuery.height(0.04, context)),
                          Container(
                            height: MQuery.height(0.45, context),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: activityIntents.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
                                  child: ListTile(  
                                    onTap: (){
                                      setState(() {
                                        isDefault = false;
                                        targetIntent = activityIntents![index];
                                      });
                                    },  
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: MQuery.height(0.005, context),
                                      horizontal: MQuery.height(0.02, context)
                                    ),
                                    title: Font.out(
                                      textAlign: TextAlign.start,
                                      family: "EinaRegular",
                                      title: activityIntents![index].title,
                                      fontSize: MQuery.height(0.02, context).toInt()
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : targetIntent.multipleChoices[0] == "null"       
                  ? Padding( //QUIZ
                      padding: EdgeInsets.all(MQuery.height(0.03, context)),
                      child: FadeInUp(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isDefault = true;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                                )
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: (){
                                    Get.to(() => IntentControl(
                                      eventUID: widget.targetEvent!.uid,
                                      title: targetIntent.title,
                                      description: targetIntent.description!,
                                      answer: targetIntent.answer,
                                      imageURL: targetIntent.imageURL,
                                      multipleChoices: ["null"],
                                      userWithRightAnswer: targetIntent.userWithRightAnswer.map((e) => e.toString()).toList(),
                                      userWithWrongAnswer: targetIntent.userWithWrongAnswer.map((e) => e.toString()).toList(),
                                      isActive: true,
                                    ));
                                  },
                                  icon:  Icon(Icons.notification_important_rounded, color: Palette.black, size: 26),
                                )
                              ),
                              SizedBox(height: MQuery.height(0.02, context)),
                              Font.out(
                                title: targetIntent.title,
                                fontSize: MQuery.height(0.04, context).toInt(),
                                color: Palette.blueAccent,
                                family: "EinaSemibold"
                              ),
                              SizedBox(height: MQuery.height(0.015, context)),
                              SizedBox(height: MQuery.height(0.015, context)),
                              Linkify(
                                text: targetIntent.description ?? "",
                                style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                              ),
                              SizedBox(height: MQuery.height(0.04, context)),
                              Column(
                                children: [
                                  Container(
                                    height: MQuery.height(0.1, context),
                                    child: TextField(
                                      controller: controller,
                                      style: Font.style(
                                        fontSize: MQuery.height(0.02, context).toInt()
                                      ),
                                      decoration: new InputDecoration(
                                        focusedBorder: new OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.blueAccent),
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
                                        hintStyle: new TextStyle(color: Colors.grey[800]),
                                        hintText: "Ketik jawabanmu disini...",
                                        fillColor: Colors.white70
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MQuery.height(0.03, context)),
                                  Container(
                                    height: MQuery.height(0.075, context),
                                    width: MQuery.width(0.45, context),
                                    child: ElevatedButton(
                                      onPressed: (){
                                        if(answerReviewer(controller.text) == true){
                                          dbProvider.addQuizAnswer(
                                            status: true,
                                            eventUID: widget.targetEvent!.uid, 
                                            intentID: targetIntent.uid,
                                            currentList: targetIntent.userWithRightAnswer + [authProvider.auth.currentUser!.uid]);
                                          setState(() {
                                            isAnswerPage = [true, true];
                                          });
                                        } else {
                                          dbProvider.addQuizAnswer(
                                            status: false,
                                            eventUID: widget.targetEvent!.uid, 
                                            intentID: targetIntent.uid,
                                            currentList: targetIntent.userWithWrongAnswer + [authProvider.auth.currentUser!.uid]);
                                          setState(() {
                                            isAnswerPage = [true, false];
                                          });
                                        }
                                      },
                                      child: Font.out(title: "Submit!", color: Palette.white, fontSize: MQuery.height(0.025, context).toInt()),
                                      style: ElevatedButton.styleFrom(
                                        primary: Palette.blueAccent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)
                                        )
                                      )
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : targetIntent.multipleChoices[0] == "info"
                    ? Padding( //INFORMATION
                      padding: EdgeInsets.all(MQuery.height(0.03, context)),
                      child: FadeInUp(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isDefault = true;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                                )
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: (){
                                    Get.to(() => IntentControl(
                                      eventUID: widget.targetEvent!.uid,
                                      title: targetIntent.title,
                                      description: targetIntent.description!,
                                      answer: targetIntent.answer,
                                      imageURL: targetIntent.imageURL,
                                      multipleChoices: [],
                                      userWithRightAnswer: targetIntent.userWithRightAnswer.map((e) => e.toString()).toList(),
                                      userWithWrongAnswer: targetIntent.userWithWrongAnswer.map((e) => e.toString()).toList(),
                                      isActive: true,
                                    ));
                                  },
                                  icon:  Icon(Icons.notification_important_rounded, color: Palette.black, size: 26),
                                )
                              ),
                              SizedBox(height: MQuery.height(0.02, context)),
                              Font.out(
                                title: targetIntent.title,
                                fontSize: MQuery.height(0.04, context).toInt(),
                                color: Palette.blueAccent,
                                family: "EinaSemibold"
                              ),
                              SizedBox(height: MQuery.height(0.015, context)),
                              targetIntent.imageURL != ""
                                ? Column(
                                  children: [
                                    Image(image: NetworkImage(targetIntent.imageURL)),
                                    SizedBox(height: MQuery.height(0.02, context)),
                                  ],
                                )
                                : SizedBox(),
                              Linkify(
                                text: targetIntent.description ?? "",
                                style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                              ),
                              SizedBox(height: MQuery.height(0.04, context)),                   
                            ],
                          ),
                        ),
                      ),
                    )
                    : isAnswerPage[0]
                      ?  Padding( //ANSWER PAGE
                          padding: EdgeInsets.all(MQuery.height(0.03, context)),
                          child: FadeInUp(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: (){
                                        activityIntents!.removeWhere((element) => element.uid == targetIntent.uid);
                                        setState(() {
                                          Get.back();
                                        });
                                      },
                                      icon: Icon(Icons.close_rounded, size: 24)
                                    )
                                  ),
                                  SizedBox(height: MQuery.height(0.02, context)),
                                  Font.out(
                                    title: isAnswerPage[1] == true ? "Kamu benar!" : "Kamu salah",
                                    fontSize: MQuery.height(0.04, context).toInt(),
                                    color: Palette.blueAccent,
                                    family: "EinaSemibold"
                                  ),
                                  SizedBox(height: MQuery.height(0.015, context)),
                                  Linkify(
                                    text: isAnswerPage[1] == true ? "Selamat!" : "Yah! Jangan menyerah ya",
                                    style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                                  ),
                                  SizedBox(height: MQuery.height(0.04, context)),                   
                                ],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(MQuery.height(0.03, context)),
                          child: FadeInUp(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        isDefault = true;
                                      });
                                    },
                                    icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                                  )
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: (){
                                      Get.to(() => IntentControl(
                                        eventUID: widget.targetEvent!.uid,
                                        title: targetIntent.title,
                                        description: targetIntent.description!,
                                        answer: targetIntent.answer,
                                        imageURL: targetIntent.imageURL,
                                        multipleChoices: targetIntent.multipleChoices.map((e) => e.toString()).toList(),
                                        userWithRightAnswer: targetIntent.userWithRightAnswer.map((e) => e.toString()).toList(),
                                        userWithWrongAnswer: targetIntent.userWithWrongAnswer.map((e) => e.toString()).toList(),
                                        isActive: true,
                                      ));
                                    },
                                    icon:  Icon(Icons.notification_important_rounded, color: Palette.black, size: 26),
                                  )
                                ),
                                SizedBox(height: MQuery.height(0.02, context)),
                                Font.out(
                                  title: targetIntent.title,
                                  fontSize: MQuery.height(0.04, context).toInt(),
                                  color: Palette.blueAccent,
                                  family: "EinaSemibold"
                                ),
                                SizedBox(height: MQuery.height(0.015, context)),
                                Font.out(
                                  title: targetIntent.description,
                                  fontSize: MQuery.height(0.025, context).toInt(),
                                  color: Palette.black,
                                  family: "EinaRegular"
                                ),
                                SizedBox(height: MQuery.height(0.04, context)),
                                Container(
                                  height: MQuery.height(0.4, context),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: targetIntent.multipleChoices.length,
                                    itemBuilder: (context, index){
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
                                        child: ListTile(
                                          onTap: (){
                                            if(answerReviewer(alphanumGenerator(index)) == true){
                                              setState(() {
                                                isAnswerPage = [true, true];
                                              });
                                            } else {
                                              setState(() {
                                                isAnswerPage = [true, false];
                                              });
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: MQuery.height(0.005, context),
                                            horizontal: MQuery.height(0.02, context)
                                          ),
                                          title: Font.out(
                                            textAlign: TextAlign.start,
                                            family: "EinaRegular",
                                            title: alphanumGenerator(index) + ". " + targetIntent.multipleChoices[index],
                                            fontSize: MQuery.height(0.0225, context).toInt()
                                          ),
                                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                                        ),
                                      );                  
                                    },
                                  )
                                )
                              ],
                            ),
                          ),
                        )
                )
              );
          }
        );
      }
    );
  } 
}