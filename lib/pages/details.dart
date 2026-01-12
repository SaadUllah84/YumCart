import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details({required this.detail, required this.image, required this.name, required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1,
      total = 0;
  String?  id;

  getthesharedpref()async{
    id= await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  ontheload()async{
    await getthesharedpref();
    setState(() {

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
            Image.network(
              widget.image,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.5,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: AppWidget.semiBoldTextField(),),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular((8))
                    ),
                    child: Icon(Icons.remove, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20.0,),
                Text(a.toString(), style: AppWidget.semiBoldTextField(),),
                SizedBox(width: 20.0,),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular((8))
                    ),
                    child: Icon(Icons.add, color: Colors.white,),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Text(widget.detail, maxLines: 3,
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Text("Delivery Time ", style: AppWidget.LightTextFieldStyle(),),
                SizedBox(width: 30.0,),
                Icon(Icons.alarm, color: Colors.black54,),
                SizedBox(width: 6.0,),
                Text("30 min", style: AppWidget.semiBoldTextField(),)
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price", style: AppWidget.semiBoldTextField(),),
                      Text("\$" + total.toString(),
                        style: AppWidget.boldTextFieldStyle(),),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image,

                      };
                      await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.orangeAccent,content: Text(
                        "Food added to cart ",
                        style: TextStyle(
                            fontSize: 18
                        ),),));
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ), child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      ],
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}