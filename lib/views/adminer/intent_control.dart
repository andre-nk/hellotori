part of "../pages.dart";

class IntentControl extends StatefulWidget {
  final String title;
  final String description;
  final String answer;
  final String imageURL;
  final String eventUID;
  final List<String> multipleChoices;
  final List<String> userWithRightAnswer;
  final List<String> userWithWrongAnswer;
  final bool isActive;

  IntentControl({
    this.title = "",
    this.description  = "",
    this.answer = "",
    this.imageURL = "",
    this.eventUID = "",
    this.multipleChoices = const [],
    this.userWithRightAnswer = const [],
    this.userWithWrongAnswer = const [],
    this.isActive = true
  });

  @override
  _IntentControlState createState() => _IntentControlState();
}

class _IntentControlState extends State<IntentControl> {

  String alphanumGenerator(int index){
    return index == 0
      ? "A. "
      : index == 1
        ? "B. "
        : index == 2
          ? "C. "
          : index == 3
            ? "D. "
            : "";
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController answer = TextEditingController();
  List<TextEditingController> multipleChoices = [];
  List<String> userWithRightAnswer = [];
  List<String> userWithWrongAnswer = [];
  bool isActive = false;
  String type = "Info";
  String _image = "";

  @override
  Widget build(BuildContext context) {
    multipleChoices = [
      TextEditingController(text: alphanumGenerator(0)),
      TextEditingController(text: alphanumGenerator(1)),
      TextEditingController(text: alphanumGenerator(2)),
      TextEditingController(text: alphanumGenerator(3))
    ];

    if(widget.title != ""){
      titleController.text = widget.title;
      descriptionController.text = widget.description;
      _image = widget.imageURL;
      isActive = widget.isActive;
      userWithRightAnswer = widget.userWithRightAnswer;
      userWithWrongAnswer = widget.userWithWrongAnswer;

      if(widget.multipleChoices != const []){
        if(widget.multipleChoices.length > 1){
          for (var i = 0; i < widget.multipleChoices.length; i++) {
            multipleChoices[i].text = widget.multipleChoices[i];
          }
        }else {
          answer.text = widget.answer;
        }
      }
    }

    return Consumer(
      builder: (context, watch, _){
        final storeProvider = watch(storageProvider);
        final dbProvider = watch(databaseProvider);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MQuery.height(0.15, context),
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Palette.black),
              onPressed: (){
                Get.back();
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  MQuery.width(0.03, context),
                  0,
                  MQuery.width(0.03, context),
                  0 
                ),
                child: Column(
                  children: [

                    //GENERAL INPUT
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(                 
                      style: Font.style(),
                      controller: titleController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        prefixIcon: Icon(Icons.title_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Judul intent",
                        hintText: "Masukkan judul intent..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(
                      maxLines: 7,
                      style: Font.style(),
                      controller: descriptionController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Isi intent (pengumuman atau isi pertanyaan)",
                        hintText: "Ketik isi intent disini..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),    
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: MQuery.height(0.2, context),
                        maxHeight:  MQuery.height(0.2, context)
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: HexColor("C4C4C4").withOpacity(0.1),
                          border: Border.all(
                            color: Palette.blueAccent
                          )
                        ),
                        height: 300,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: MQuery.height(0.02, context)), 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Palette.blueAccent
                                  ),
                                  child: Text("Tambah gambar"),
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                                    setState(() {
                                      if (pickedFile != null) {
                                        _image = pickedFile.path;
                                        storeProvider.uploadFile(_image, _image);
                                      } else {
                                        print('No image selected.');
                                      }
                                    });                                   
                                  },
                                ),
                                ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Palette.blueAccent
                                  ),
                                  child: Text("Hapus gambar"),
                                  onPressed: (){
                                    setState(() {
                                      _image = "";                               
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: MQuery.height(0.01, context)),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                horizontal: MQuery.width(0.02, context)
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: MQuery.width(0.02, context)
                              ),
                              height: MQuery.height(0.075, context),
                              width: 0.8 * double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                border: Border.all(color: HexColor("C4C4C4"))
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Font.out(
                                  title: _image,
                                  fontSize: 16
                                ),
                              ),                        
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    
                    //DIVINER
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: type,
                        isExpanded: true,
                        icon: Container(
                          padding: EdgeInsets.only(left: MQuery.width(0.37, context)),
                          child: Icon(Icons.arrow_drop_down_sharp)
                        ),
                        iconSize: 20,
                        elevation: 32,
                        style: Font.style(),
                        underline: Container(
                          height: 2,
                          color: Palette.blueAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            type = newValue!;
                          });
                        },
                        items: <String>["Info", "Quiz", "Pilgan"].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.02, context)),
                    
                    //CUSTOMED WIDGETS
                    type == "Pilgan"
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: MQuery.height(0.44, context),
                            maxHeight:  MQuery.height(0.44, context)
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: HexColor("C4C4C4").withOpacity(0.1),
                              border: Border.all(
                                color: Palette.blueAccent
                              )
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:  MQuery.height(0.42, context),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index){
                                      return index != 4
                                      ? Container(
                                        alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.fromLTRB(
                                            MQuery.width(0.02, context),
                                            MQuery.width(0.02, context),
                                            MQuery.width(0.02, context),
                                            0),
                                          width: 0.8 * double.infinity,
                                          child: TextField(
                                            maxLines: 1,
                                            style: Font.style(),
                                            controller: multipleChoices[index],
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Palette.blueAccent)
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Palette.blueAccent)
                                              ),
                                              hintText: "Ketik jawaban disini..."
                                            ),         
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.fromLTRB(
                                              MQuery.width(0.02, context),
                                              MQuery.width(0.02, context),
                                              MQuery.width(0.02, context),
                                              0),
                                            width: 0.8 * double.infinity,
                                            child: TextField(
                                              maxLines: 1,
                                              style: Font.style(),
                                              controller: answer,
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Palette.blueAccent)
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Palette.blueAccent)
                                                ),
                                                hintText: "Ketik huruf opsi yang benar..."
                                              ),         
                                            ),
                                          );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : type == "Quiz"
                        ? TextField(
                            maxLines: 1,
                            style: Font.style(),
                            controller: answer,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.blueAccent)
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.blueAccent)
                              ),
                              labelText: "Jawaban singkat quiz...",
                              hintText: "Ketik jawaban disini..."
                            ),         
                          )
                        : type == "Info"
                          ? SizedBox()
                          : SizedBox(),
                    
                    SizedBox(height: MQuery.height(0.05, context)),
                    Font.out(
                      title: "User dengan jawaban benar:",
                      family: "EinaRegular",
                      fontSize: 18,
                      color: Palette.black
                    ),
                    SizedBox(height: MQuery.height(0.02, context)),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor("C4C4C4").withOpacity(0.1),
                        border: Border.all(
                          color: Palette.blueAccent
                        )
                      ),                      
                      height: MQuery.height(0.3, context),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: userWithRightAnswer.length,
                        itemBuilder: (context, index){
                          return Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                              horizontal: MQuery.width(0.02, context)
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: MQuery.width(0.02, context)
                            ),
                            height: MQuery.height(0.075, context),
                            width: 0.8 * double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(color: HexColor("C4C4C4"))
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: StreamBuilder<OtherUser>(
                                stream: dbProvider.otherUserProfile(userWithRightAnswer[index]),
                                builder: (context, snapshot){
                                  return Font.out(
                                    title: snapshot.data!.name, 
                                    fontSize: 16
                                  );
                                }
                              ) 
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    Font.out(
                      title: "User dengan jawaban salah:",
                      family: "EinaRegular",
                      fontSize: 18,
                      color: Palette.black
                    ),
                    SizedBox(height: MQuery.height(0.02, context)),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor("C4C4C4").withOpacity(0.1),
                        border: Border.all(
                          color: Palette.blueAccent
                        )
                      ),  
                      height: MQuery.height(0.3, context),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: userWithWrongAnswer.length,
                        itemBuilder: (context, index){
                          return Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                              horizontal: MQuery.width(0.02, context)
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: MQuery.width(0.02, context)
                            ),
                            height: MQuery.height(0.075, context),
                            width: 0.8 * double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(color: HexColor("C4C4C4"))
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: StreamBuilder<OtherUser>(
                                stream: dbProvider.otherUserProfile(userWithWrongAnswer[index]),
                                builder: (context, snapshot){
                                  return Font.out(
                                    title: snapshot.data!.name, 
                                    fontSize: 16
                                  );
                                }
                              ) 
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Font.out(
                          title: "Intent aktif?",
                          family: "EinaRegular",
                          fontSize: 16,
                        ),
                        Switch(
                          activeColor: Palette.blueAccent,
                          value: isActive,
                          onChanged: (bool val){
                            setState(() {
                              isActive = !isActive;                
                            });
                          }
                        )
                      ],
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    Container(
                      height: MQuery.height(0.08, context),
                      width: MQuery.width(0.8, context),
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Palette.blueAccent.withOpacity(0.2),
                            blurRadius: 60,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: OnboardingButton(
                        color: Colors.white,
                        method: () async {
                          if(_image == ""){
                            if(widget.title == ""){    
                              dbProvider.createIntent(
                                title: titleController.text,
                                description: descriptionController.text,
                                multipleChoices: type == "Info"
                                  ? ["info"]
                                  : type == "Quiz"
                                    ? ["null"]
                                    : multipleChoices.map((e) => e.text).toList(),
                                imageURL: "",
                                answer: answer.text,
                                eventUID: widget.eventUID
                              );
                              
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
                                          Icon(Icons.check_circle, color: Colors.green, size: 42),
                                          SizedBox(height: MQuery.height(0.02, context)),
                                          Font.out(
                                            title: "Berhasil Dibuat!",
                                            family: "EinaSemibold",
                                            fontSize: 32,
                                            color: Palette.blueAccent
                                          ),
                                          SizedBox(height: MQuery.height(0.02, context)),
                                          Text(
                                            "Silahkan review ulang intent yang telah dibuat di halaman terkait! \n \n 🥂",
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
                              ).then((value) => Get.to(() => EventPage(), transition: Transition.cupertino)); 
                            } else {   
                              dbProvider.updateIntent(
                                title: titleController.text,
                                description: descriptionController.text,
                                multipleChoices: type == "Info"
                                  ? ["info"]
                                  : type == "Quiz"
                                    ? ["null"]
                                    : multipleChoices.map((e) => e.text).toList(),
                                imageURL: _image,
                                answer: answer.text,
                                wrong: userWithWrongAnswer,
                                right: userWithRightAnswer,
                                isActive: isActive,
                                eventUID: widget.eventUID
                              );
                              
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
                                          Icon(Icons.check_circle, color: Colors.green, size: 42),
                                          SizedBox(height: MQuery.height(0.02, context)),
                                          Font.out(
                                            title: "Berhasil Diedit!",
                                            family: "EinaSemibold",
                                            fontSize: 32,
                                            color: Palette.blueAccent
                                          ),
                                          SizedBox(height: MQuery.height(0.02, context)),
                                          Text(
                                            "Silahkan review ulang intent yang telah diedit di halaman terkait! \n \n 🥂",
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
                              ).then((value) => Get.to(() => EventPage(), transition: Transition.cupertino)); 
                            }              
                          }
                        },
                        title: Font.out(
                          title: widget.title == "" ? "Buat intent" : "Edit intent",
                          family: "EinaSemibold",
                          fontSize: 20,
                          color: Palette.blueAccent
                        ),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                  ]
                )
              )
            )
          )
        );
      }
    );
  }
}