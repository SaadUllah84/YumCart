import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/bottomnav.dart';
import 'package:food_delivery/pages/home.dart';
import 'package:food_delivery/pages/login.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {

  String email="",password="",name="";

  TextEditingController namecontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration( )async{
    if(password!=null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Registration Successfull"
            ,style: TextStyle(
              fontSize: 20
            ),),)));
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name" : namecontroller.text,
          "Email" : mailcontroller.text,
          "Wallet" : "0",
          "Id" : Id,
        };

        await DatabaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserWallet("0");
        await SharedPreferenceHelper().saveUserId(Id);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>Bottomnav()));
      }
      on FirebaseException catch (e) {
        if (e.code == "Weak-password"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,content: Text(
            "Password provided is too weak ",
            style: TextStyle(
                fontSize: 18
            ),),));
        }
        else if(e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent, content: Text(
            "Account Already exists",
            style: TextStyle(
              fontSize: 18
          ),) ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0F0F0F), // near black
                          Color(0xFF1C1C1C), // charcoal
                        ])
                ),
        
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60,left: 20,right: 20),
                child: Column(
                  children: [
                    Center(child: Image.asset("images/logo.png",width: MediaQuery.of(context).size.width/1.5,fit: BoxFit.cover,)),
                    SizedBox(height: 50,),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2,
                        decoration: BoxDecoration(
                            color: Colors.white,borderRadius: BorderRadius.circular(20)
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text("SignUp", style: AppWidget.HeadlineTextFieldStyle(),
                              ),
                              SizedBox(height: 30,),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Please Enter Name ";
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                    hintText: 'Username', hintStyle: AppWidget.semiBoldTextField(), prefixIcon: Icon(Icons.person_2_outlined)
                                ),
                              ),
                              SizedBox(height: 30,),
                              TextFormField(
                                controller: mailcontroller,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Please Enter E-Mail";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email', hintStyle: AppWidget.semiBoldTextField(), prefixIcon: Icon(Icons.email_outlined)
                                ),
                              ),
                              SizedBox(height: 25,),
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Please Enter Password";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Password', hintStyle: AppWidget.semiBoldTextField(), prefixIcon: Icon(Icons.lock)
                                ),
                              ),
                              SizedBox(height: 80,),
                              GestureDetector(
                                onTap: ()async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = mailcontroller.text;
                                      name = namecontroller.text;
                                      password = passwordcontroller.text;
                                    });
                                  }
                                  registration();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF1C1C1C),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: 'poppins', fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
        
                      ),
                    ),
                    SizedBox(height: 60,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                        child: Text("Already have an account? Login",style: AppWidget.semiBoldTextField(),))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
