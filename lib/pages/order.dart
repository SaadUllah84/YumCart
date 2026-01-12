import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import '../widget/widget_support.dart' show AppWidget;
class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String?  id, wallet;
  int total = 0, amount2=0;

  void startTimer(){
      Timer(Duration(seconds: 3),(){
        amount2=total;
        setState(() {

        });
      });
  }

  getthesharedpref()async{
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getWalletKey();
    setState(() {

    });
  }

  ontheload()async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {

    });
  }
  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }


  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData ?
          ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                total = total+ int.parse(ds["Total"]);
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20,bottom: 10),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(ds["Quantity"])),
                          ),
                          SizedBox(width: 20,),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                ds["Image"],
                                height: 90, width: 90, fit: BoxFit.cover,)),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              children: [
                                Text(ds["Name"], style: AppWidget.semiBoldTextField(),
                                maxLines: 2
                                  ,),
                                Text("\$" + ds["Total"], style: AppWidget.semiBoldTextField(),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
              : CircularProgressIndicator();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Center(child: Text(
                    "Food Cart", style: AppWidget.HeadlineTextFieldStyle(),))
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height/2,
                child: foodCart()),
            Spacer(),
            Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total price",style: AppWidget.boldTextFieldStyle(),),
                    Text("\$" + total.toString(), style: AppWidget.semiBoldTextField(),)
                  ],
                ),
              ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                int amount = int.parse(wallet!) - amount2;
                await DatabaseMethods().UpdateUserWallet(id!, amount.toString());
                await SharedPreferenceHelper().saveUserWallet(amount.toString());

                // Clear the food cart after checkout
                await DatabaseMethods().clearFoodCart(id!);

                // Optionally, reset the total amount to 0
                setState(() {
                  total = 0;
                });
              },
              child: Container(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),
                  child: Center(child: Text("Checkout",style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
