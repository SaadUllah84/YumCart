import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery/pages/details.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  bool icecream = false,
      pizza = false,
      salad = false,
      burger = false;

  Stream? fooditemStream;
  TextEditingController searchController = TextEditingController();
  bool search = false;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List docs = snapshot.data.docs;
            if (search) {
              docs = docs.where((element) => element["Name"]
                  .toString()
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase())).toList();
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds["Name"],
                              style: AppWidget.semiBoldTextField(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Fresh and healthy",
                              style: AppWidget.LightTextFieldStyle(),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "\$${ds["Price"]}",
                              style: AppWidget.semiBoldTextField(),
                            ),
                          ],
                        ),
                      ),
                          ]
                        ),
                      ),
                    ),
                  ),
                );
              });
          }
          return CircularProgressIndicator();
        });
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List docs = snapshot.data.docs;
            if (search) {
              docs = docs.where((element) => element["Name"]
                  .toString()
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase())).toList();
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                  },
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.all(2),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.network(
                                ds['Image'],
                                height: 175,
                                width: 190,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width /2,
                                  child: Text(ds["Name"],
                                    style: AppWidget.semiBoldTextField(),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  child: Text("Fresh and Healthy ",
                                    style: AppWidget.LightTextFieldStyle(),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  child: Text("\$" + ds["Price"],
                                    style: AppWidget.semiBoldTextField(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello Foodie,",
                        style: AppWidget.boldTextFieldStyle()
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        search = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                        hintText: "Search Food"),
                  ),
                ),
                SizedBox(height: 30,),
                Text("Delcious Food",
                    style: AppWidget.HeadlineTextFieldStyle()
                ),
                Text("Taste that brings you back",
                    style: AppWidget.LightTextFieldStyle()
                ),
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: showItem()
                ),
                SizedBox(height: 20,),
                Container(
                    height: 270, // dart
                    child: allItems()),
                SizedBox(
                  height: 30.0,
                ),
                allItemsVertically()
              ]
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Ice-Cream");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/ice-cream.png", height: 45,
                width: 45,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/pizza.png", height: 45,
                width: 45,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/salad.png", height: 45,
                width: 45,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,),
            ),
          ),
        ),

        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {

            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset("images/burger.png", height: 45,
                width: 45,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,),
            ),
          ),
        ),
      ],
    );
  }
}