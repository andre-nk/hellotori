part of "../pages.dart";

class ShopControl extends StatefulWidget {

  final String title;
  final String description;
  final String imageURL;
  final String uid;
  final int price;
  final bool switchValue;

  const ShopControl({
    this.uid = "",
    this.title = "",
    this.description = "",
    this.imageURL = "",
    this.price = 0,
    this.switchValue = false
  });

  @override
  _ShopControlState createState() => _ShopControlState();
}

class _ShopControlState extends State<ShopControl> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String _image = "";
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {

    if(widget.title != ""){
      titleController.text = widget.title;
      descriptionController.text = widget.description;
      priceController.text = widget.price.toString();
      switchValue = widget.switchValue;
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
              icon: Icon(Icons.arrow_back_ios_rounded, color: Palette.black,),
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
                    SizedBox(height: MQuery.height(0.025, context)),
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
                        labelText: "Judul produk",
                        hintText: "Masukkan judul produk..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(
                      maxLines: 10,
                      style: Font.style(),
                      controller: descriptionController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Deskripsi produk",
                        hintText: "Deskripsikan produk disini..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: Font.style(),
                      controller: priceController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.blueAccent)
                        ),
                        labelText: "Harga produk...",
                        hintText: "Deskripsikan produk disini..."
                      ),         
                    ),
                    SizedBox(height: MQuery.height(0.05, context)),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: MQuery.height(0.15, context),
                        maxHeight:  MQuery.height(0.225, context)
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
                                  child: Text("Pilih foto produk"),
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
                                  child: Text("Hapus foto"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Font.out(
                          title: "Terjual habis?",
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
                          if(_image != ""){
                            storeProvider.getDownloadURL(_image).then((value){
                              if(titleController.text == ""){
                                Get.snackbar("Judul belum diisi", "Silahkan isi judul sebelum membuat produk!");
                              } else {
                                if(widget.title != ""){
                                  print('edit');
                                  dbProvider.editShopItem(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    price: int.parse(priceController.text),
                                    imageURL: value,
                                    eventUID: widget.uid,
                                    isSold: switchValue
                                  );
                                } else {
                                  print('create');
                                  dbProvider.addShopItem(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    price: int.parse(priceController.text),
                                    imageURL: value,
                                  );
                                }                             
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
                                              title: widget.title == "" ? "Berhasil!" : "Berhasil Diedit!",
                                              family: "EinaSemibold",
                                              fontSize: 32,
                                              color: Palette.blueAccent
                                            ),
                                            SizedBox(height: MQuery.height(0.02, context)),
                                            Text(
                                              widget.title == ""
                                              ? "Silahkan review ulang event yang telah dibuat di halaman Shop! \n \n 🥂"
                                              : "Silahkan review ulang event yang telah diedit di halaman Shop! \n \n 🥂",
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
                                ).then((value) => Get.offAll(EventPage(), transition: Transition.cupertino));               
                              } 
                            });  
                          } else {
                            if(titleController.text == ""){
                              Get.snackbar("Judul belum diisi", "Silahkan isi judul sebelum membuat produk!");
                            } else {
                              dbProvider.editShopItem(
                                title: titleController.text,
                                description: descriptionController.text,
                                price: int.parse(priceController.text),
                                imageURL: _image,
                                eventUID: widget.uid,
                                isSold: switchValue
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
                                            title: widget.title == "" ? "Berhasil!" : "Berhasil Diedit!",
                                            family: "EinaSemibold",
                                            fontSize: 32,
                                            color: Palette.blueAccent
                                          ),
                                          SizedBox(height: MQuery.height(0.02, context)),
                                          Text(
                                            widget.title == ""
                                            ? "Silahkan review ulang event yang telah dibuat di halaman Shop! \n \n 🥂"
                                            : "Silahkan review ulang event yang telah diedit di halaman Shop! \n \n 🥂",
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
                              ).then((value) => Get.offAll(EventPage(), transition: Transition.cupertino));               
                            }                         
                          }       
                        },
                        title: Font.out(
                          title: widget.title == "" ? "Buat Produk" : "Edit Produk",
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