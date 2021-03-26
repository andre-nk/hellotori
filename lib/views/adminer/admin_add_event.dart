part of "../pages.dart";

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  List<Asset> images = <Asset>[];
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController shareController = TextEditingController();
  String _image = "";

  @override
  Widget build(BuildContext context) {
    final String title = "";
    bool switchValue = true;

    //values
    String dropdownValue = "Live";
    String dateTime = DateFormat("dd MMMM yy").format(DateTime.now()).toString();
    String timeOfday = DateFormat("HH : mm").format(DateTime.now()).toString();

    // Future<void> loadAssets() async {
    //   List<Asset> resultList = <Asset>[];
    //   String error = 'No Error Detected';
    //   try {
    //     resultList = await MultiImagePicker.pickImages(
    //       maxImages: 300,
    //       enableCamera: true,
    //       selectedAssets: images,
    //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    //       materialOptions: MaterialOptions(
    //         actionBarColor: "#abcdef",
    //         actionBarTitle: "Example App",
    //         allViewTitle: "All Photos",
    //         useDetailsView: false,
    //         selectCircleStrokeColor: "#000000",
    //       ),
    //     );
    //   } on Exception catch (e) {
    //     error = e.toString();
    //   }
    //   if (!mounted) return;

    //   setState(() {
    //       images = resultList;
    //     }
    //   );
    // }
    // Widget buildGridView() {
    //   return GridView.count(
    //     crossAxisCount: 3,
    //     children: List.generate(images.length, (index) {
    //       Asset asset = images[index];
    //       return AssetThumb(
    //         asset: asset,
    //         width: 300,
    //         height: 300,
    //       );
    //     }),
    //   );
    // }

    return Consumer(
      builder: (context, watch, _){

        final storeProvider = watch(storageProvider);

        return  Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Icon(Icons.arrow_back_ios_rounded, color: Palette.black,),
            title: Text(title),
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
                    SizedBox(height: MQuery.height(0.05, context),),
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
                        labelText: "Judul acara",
                        hintText: "Masukkan judul acara..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),
                    TextField(
                      style: Font.style(),
                      controller: linkController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        prefixIcon: Icon(Icons.link_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Link Eksternal Acara",
                        hintText: "Link video, live, website..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),
                    TextField(
                      style: Font.style(),
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        prefixIcon: Icon(Icons.article_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Deskripsi acara",
                        hintText: "Masukkan deskripsi acara..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),
                    TextField(
                      style: Font.style(),
                      controller: shareController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        prefixIcon: Icon(Icons.share),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Deskripsi share acara",
                        hintText: "Masukkan deskripsi saat share acara..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.03, context)),
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
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
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Live', 'Passed', 'Static'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.03, context)),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate:DateTime(2300)
                        );
                        if(picked != null){
                          setState(() {
                            dateTime = DateFormat("dd MMMM yy").format(picked).toString();
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Font.out(
                            title: dateTime,
                            family: "EinaRegular",
                            fontSize: 16,
                          ),
                          Icon(
                            Icons.calendar_today_rounded
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if(picked != null){
                          setState(() {
                            timeOfday = "${picked.toString().substring(0,1) + ":" + picked.toString().substring(2,3) }";
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Font.out(
                            title: timeOfday,
                            family: "EinaRegular",
                            fontSize: 16,
                          ),
                          Icon(
                            Icons.watch_later_outlined
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.03, context)), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Font.out(
                          title: "Live chat aktif?",
                          family: "EinaRegular",
                          fontSize: 16,
                        ),
                        Switch(
                          activeColor: Palette.blueAccent,
                          value: switchValue,
                          onChanged: (bool val){
                            setState(() {
                              switchValue = !switchValue;                      
                            });
                          }
                        )
                      ],
                    ),
                    SizedBox(height: MQuery.height(0.03, context)), 
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: 350,
                        maxHeight: 350
                      ),
                      child: Container(
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
                                  child: Text("Pilih cover"),
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

                                    setState(() {
                                      if (pickedFile != null) {
                                        _image = pickedFile.path;
                                        print(_image);
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
                                      images = [];                                  
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: MQuery.height(0.01, context)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.03, context)),
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
                          // storeProvider.uploadFile();
                          storeProvider.getDownloadURL(_image).then((value){
                            print(
                              titleController.text + 
                              descriptionController.text +
                              linkController.text +
                              shareController.text +
                              dropdownValue +
                              dateTime + timeOfday +
                              value +
                              switchValue.toString() 
                            );
                          });               
                        },
                        title: Font.out(
                          title: "Keluar Akun",
                          family: "EinaSemibold",
                          fontSize: 20,
                          color: Colors.red
                        ),
                      ),
                    ),
                    SizedBox(height: MQuery.height(0.05, context),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}