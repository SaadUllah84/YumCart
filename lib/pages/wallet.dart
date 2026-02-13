import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/payment_service.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = new TextEditingController();
  gettheSharedpref ()async{
    wallet = await SharedPreferenceHelper().getWalletKey();
    id= await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }

  ontheload()async{
    await gettheSharedpref();
    setState(() {

    });

  }
  @override
  void initState() {
    ontheload();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: wallet ==null? CircularProgressIndicator():
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(child: Text(
                      "Wallet", style: AppWidget.HeadlineTextFieldStyle(),))
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                child: Row(
                  children: [
                    Image.asset("images/wallet.png", height: 60,
                      width: 60,
                      fit: BoxFit.cover,),
                    SizedBox(height: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Wallet", style: AppWidget.semiBoldTextField(),),
                        SizedBox(height: 5,),
                        Text(
                          "\$" + wallet!, style: AppWidget.boldTextFieldStyle(),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Add money ", style: AppWidget.semiBoldTextField(),),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      makePayment('100');
                    },

                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        "\$" + "100", style: AppWidget.semiBoldTextField(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      makePayment('500');
                     },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        "\$" + "500", style: AppWidget.semiBoldTextField(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      makePayment("1000");
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        "\$" + "1000", style: AppWidget.semiBoldTextField(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      makePayment("2000");
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        "\$" + "2000", style: AppWidget.semiBoldTextField(),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  openEdit();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF121515)
                  ),
                  child: Center(child: Text("Add Money", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Poppins'),)),
                ),
              ),

            ],

          ),
        )
    );
  }

  Future<void> makePayment(String amount) async {
    bool success = await PaymentService().makePayment(amount);
    if (success) {
      add = int.parse(wallet!) + int.parse(amount);
      await SharedPreferenceHelper().saveUserWallet(add.toString());
      await DatabaseMethods().updateUserWallet(id!, add.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text("Payment Successful")
                      ],
                    )
                  ],
                ),
              ));
      await gettheSharedpref();
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Payment Cancelled or Failed"),
              ));
    }
  }

Future<void> openEdit() {
  return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(width: 60,),
                  Center(
                    child: Text("Add Money" ,style: TextStyle(color: Color(
                        0xFF131313),fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Amount"),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: amountcontroller,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Enter Amount"),

                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  makePayment(amountcontroller.text);
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(color: Color(0xFF1C1C1C), borderRadius: BorderRadius.circular(10),),child: Center(child: Text("Pay",style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      )
  ));
}}