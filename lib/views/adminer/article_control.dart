part of "../pages.dart";

class ArticleControl extends StatefulWidget {

  final String header;
  final String article;
  final List<dynamic> imageURLs;

  ArticleControl({
    required this.header,
    required this.article,
    required this.imageURLs
  });

  @override
  _ArticleControlState createState() => _ArticleControlState();
}

class _ArticleControlState extends State<ArticleControl> {

  TextEditingController headerController = TextEditingController();
  TextEditingController articleController = TextEditingController();
  List<dynamic> _images = [];
  List<dynamic> _localImages = [];

  @override
  Widget build(BuildContext context) {

    headerController.text = widget.header;
    articleController.text = widget.article;

    return Consumer(
      builder: (context, watch, _){

        final storeProvider = watch(storageProvider);
        final dbProvider = watch(databaseProvider);

        _images = widget.imageURLs;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MQuery.height(0.15, context),
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Icon(Icons.arrow_back_ios_rounded, color: Palette.black),
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
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(                 
                      style: Font.style(),
                      controller: headerController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        prefixIcon: Icon(Icons.title_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Judul artikel (Header)",
                        hintText: "Masukkan judul artikel..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(
                      maxLines: 30,
                      style: Font.style(),
                      controller: articleController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Isi artikel",
                        hintText: "Ketik isi artikel.."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),    
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: MQuery.height(0.3, context),
                        maxHeight:  MQuery.height(0.5, context)
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
                            SizedBox(height: MQuery.height(0.01, context)), 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Palette.blueAccent
                                  ),
                                  child: Text("Tambah cover"),
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      storeProvider.uploadFile(pickedFile.path, pickedFile.path);
                                      _localImages.add(pickedFile.path);
                                    } else {
                                      print('No image selected.');
                                    }                                     
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
                                      _images = [];                                  
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: MQuery.height(0.01, context)),
                            Container(
                              height: MQuery.height(0.3, context),
                              child: ListView.builder(
                                itemCount: _images.length,
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
                                      child: Font.out(
                                        title: _images[index],
                                        fontSize: 16
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
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
                          if(_images != widget.imageURLs){

                            _localImages.forEach((element) async {
                              await storeProvider.getDownloadURL(element).then((value) =>  _images.add(value));
                            });

                            dbProvider.editBios(
                              headline: headerController.text,
                              article: articleController.text,
                              photoURLs: _images,
                              type: "school"
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
                                          "Silahkan review ulang artikel yang telah diedit di halaman terkait! \n \n 🥂",
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
                            ).then((value) => Get.to(() => SchoolPage(), transition: Transition.cupertino));               
                          } else {
                            dbProvider.editBios(
                              headline: headerController.text,
                              article: articleController.text,
                              photoURLs: widget.imageURLs,
                              type: "school"
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
                                          "Silahkan review ulang artikel yang telah diedit di halaman terkait! \n \n 🥂",
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
                            ).then((value) => Get.to(() => SchoolPage(), transition: Transition.cupertino));               
                          }
                        },
                        title: Font.out(
                          title: "Edit artikel",
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