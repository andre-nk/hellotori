part of "services.dart";

class TransactionController {
  
  // Google App Script Web URL.
  static String mainURL = "https://script.google.com/macros/s/AKfycbzjrEbIlzjeB2CDe7w7JNKr0sX0ArJvVXA2QRVC6Hl0qC3gRFmbfqSOfC7k16HDxw7U/exec";
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  static const STATUS_SUCCESS = "SUCCESS";

  TransactionController(this.callback);

  void submitForm(TransactionForm transactionForm) async{
    try{
      await http.post(Uri.parse(mainURL + transactionForm.toParams()));
    } catch(e){
      print(e);
    }
  }
}