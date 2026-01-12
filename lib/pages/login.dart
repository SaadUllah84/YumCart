import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/bottomnav.dart';
import 'package:food_delivery/pages/forgotpassword.dart';
import 'package:food_delivery/pages/signup.dart';
import 'package:food_delivery/widget/app_drawer.dart';
import 'package:food_delivery/widget/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  String email ="",password="";
  final _formkey= GlobalKey<FormState>();

  TextEditingController useremailController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Bottomnav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "No User found for this email",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Wrong password given by the user",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred: ${e.message}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
                              Text("Login", style: AppWidget.HeadlineTextFieldStyle(),
                              ),
                              SizedBox(height: 30,),
                              TextFormField(
                                controller: useremailController,
                                validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Please Enter Password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email', hintStyle: AppWidget.semiBoldTextField(), prefixIcon: Icon(Icons.email_outlined)
                                ),
                              ),
                              SizedBox(height: 25,),
                              TextFormField( controller: userpasswordController,
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
                              SizedBox(height: 30,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                    child: Text("Forgot Password?",style:AppWidget.semiBoldTextField(),)),
                              ),
                              SizedBox(height: 80,),
                              GestureDetector(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = useremailController.text.trim();
                                      password = userpasswordController.text.trim();
                                    });
                                    userLogin();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Please fill in all fields correctly",
                                          style: TextStyle(fontSize: 18, color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1C1C1C),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                        },
                        child: Text("Dont have an account? SignUp",style: AppWidget.semiBoldTextField(),))

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
