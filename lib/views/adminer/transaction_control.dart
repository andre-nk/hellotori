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

  int amount = 0;

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
                child: Column(
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
                              setState(() {
                                amount--;                                
                              });
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

                          _showSnackbar(String message) {
                            Get.snackbar("Woi!", message);
                          }

                          TransactionForm form = TransactionForm(
                            name: nameController.text,
                            email: emailController.text,
                            alamat: addressController.text,
                            produk: widget.productTitle,
                            telepon: telephoneController.text,
                            jumlah: amount.toString()
                          );

                          TransactionController transactionController = TransactionController((String response){
                          print("Response: $response");
                          if(response == TransactionController.STATUS_SUCCESS){
                            //
                            _showSnackbar("Feedback Submitted");
                          } else {
                            _showSnackbar("Error Occurred!");
                          }
                        });

                        _showSnackbar("Submitting Feedback");

                        // Submit 'feedbackForm' and save it in Google Sheet

                        transactionController.submitForm(form);

                          // const _credentials = 
                          // {
                          //   "type": "service_account",
                          //   "project_id": "",
                          //   "private_key_id": "",
                          //   "private_key": "",
                          //   "client_email": "",
                          //   "client_id": "",
                          //   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                          //   "token_uri": "https://oauth2.googleapis.com/token",
                          //   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                          //   "client_x509_cert_url": ""
                          // };                   

                          // final gsheets = GSheets(_credentials);
                          // const _spreadsheetId = '1q80spq-4Ad9vwKlCkOpyPdaEkUlfd1mB3De-8riGv8w';
                          // // fetch spreadsheet by its id
                          // final spreadSheet = await gsheets.spreadsheet(_spreadsheetId);
                          // var sheet = spreadSheet.worksheetByTitle('hellotori');
                          // final secondRow = form.toJson();
                          // await sheet!.values.map.appendRow(secondRow);

                          // TransactionController.submitForm(form, (String response){
                          //   print("Response: $response");
                          //   if (response == TransactionController.STATUS_SUCCESS) {
                          //     // Feedback is saved succesfully in Google Sheets.
                          //     print("yes");
                          //   } else {
                          //     // Error Occurred while saving data in Google Sheets.
                          //     print("NYET");
                          //   }
                          // });
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
                )
              )
            )
          )
        );
      }
    );
  }
}