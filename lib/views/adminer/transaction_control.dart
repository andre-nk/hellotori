part of "../pages.dart";

class TransactionControl extends StatefulWidget {

  final String productTitle;
  final String imageURL;

  TransactionControl({required this.productTitle, required this.imageURL});

  @override
  _TransactionControlState createState() => _TransactionControlState();
}

class _TransactionControlState extends State<TransactionControl> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  int amount = 1;

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, watch, _){

        final authProvider = watch(authModelProvider);

        nameController.text = authProvider.auth.currentUser!.displayName ?? "";
        emailController.text = authProvider.auth.currentUser!.email ?? "";
        
        print(amount);

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MQuery.height(0.1, context),
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
                child: Consumer(
                  builder: (context, watch, _){

                    final shopInfo = watch(shopInfoProvider);

                    return shopInfo.when(
                      data: (value){
                        return Column(
                          children: [
                            Container(
                              height: MQuery.height(0.1, context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Image(
                                        image: NetworkImage(widget.imageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MQuery.width(0.025, context)),
                                  Text(
                                    widget.productTitle,
                                    style: TextStyle(
                                      fontFamily: "EinaSemiBold",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      color: Palette.black
                                    )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: MQuery.height(0.075, context)),
                            TextField(                 
                              style: Font.style(),
                              controller: nameController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                prefixIcon: Icon(Icons.title_rounded),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                labelText: "Nama penerima",
                                hintText: "Masukkan nama penerima..."
                              ),         
                            ),
                            SizedBox(height: MQuery.height(0.05, context)),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 1,
                              style: Font.style(),
                              controller: emailController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                labelText: "E-mail penerima",
                                hintText: "Masukkan e-mail penerima..."
                              ),         
                            ),
                            SizedBox(height: MQuery.height(0.05, context)),
                            TextField(
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              style: Font.style(),
                              controller: telephoneController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                labelText: "Nomor telepon penerima",
                                hintText: "Masukkan telepon penerima..."
                              ),         
                            ),
                            SizedBox(height: MQuery.height(0.05, context)),
                            TextField(
                              maxLines: 7,
                              style: Font.style(),
                              controller: addressController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent)
                                ),
                                labelText: "Alamat penerima",
                                hintText: "Masukkan alamat penerima..."
                              ),         
                            ),
                            SizedBox(height: MQuery.height(0.05, context)),
                            Container(
                              height: MQuery.height(0.05, context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Font.out(
                                    title: "Jumlah:",
                                    family: "EinaRegular",
                                    fontSize: 16,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Palette.blueAccent,
                                      elevation: 0
                                    ),
                                    onPressed: (){
                                      if(amount == 1){
                                        Get.snackbar("Jumlah pesanan minimal 1", "Silahkan pesan produk ini dengan jumlah lebih dari 1");
                                      } else {
                                        setState(() {
                                          amount--;                                
                                        });
                                      }
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                  Text(amount.toString(),
                                    style: TextStyle(
                                      fontFamily: "EinaSemiBold",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      color: Palette.black
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Palette.blueAccent,
                                      elevation: 0
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        amount++;                               
                                      });
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ],
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

                                  String outputMessage = value[3] + "%0a*${widget.productTitle}*%0a" + 
                                    "%0aIni data diri saya kak: %0aNama: " + nameController.text + "%0a" +
                                    "E-mail: " + emailController.text + "%0a" +
                                    "No. Telepon: " + telephoneController.text + "%0a" + 
                                    "Alamat: " + addressController.text + "%0a" + 
                                    "Jumlah: " + amount.toString() + "%0a" +
                                    "Terimakasih kak, saya tunggu konfirmasinya!"
                                  ;

                                  await launch("https://wa.me/${value[0]}?text=$outputMessage");
                                },
                                title: Font.out(
                                  title: "Lanjutkan order",
                                  family: "EinaSemibold",
                                  fontSize: 20,
                                  color: Palette.blueAccent
                                ),
                              ),
                            ),
                            SizedBox(height: MQuery.height(0.05, context)),
                          ]
                        );
                      },
                      loading: (){
                        return FloatingActionButton(
                          elevation: 2,
                          mini: false,
                          backgroundColor: Palette.blueAccent,
                          child: Icon(Icons.shopping_cart_rounded, size: 24),
                          onPressed: () async {
                            // await launch("https://wa.me/${value[0]}?text=Hello");
                          },
                        );
                      },
                      error: (_,__){
                        return FloatingActionButton(
                          elevation: 2,
                          mini: false,
                          backgroundColor: Palette.blueAccent,
                          child: Icon(Icons.shopping_cart_rounded, size: 24),
                          onPressed: () async {
                            // await launch("https://wa.me/${value[0]}?text=Hello");
                          },
                        );
                      }
                    
                    );
                  }
                )
              )
            )
          )
        );
      }
    );
  }
}