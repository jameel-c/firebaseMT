import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/home_screen.dart';
import 'package:firebase/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {

      try {
          Timer(
              Duration(seconds: 0),
                  () async {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text,
                        password: passwordController.text).then((value) {
                          print("value$value");
                          usernameController.clear();
                          passwordController.clear();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()));
                    });
                  });
          setState(() {
          });
      }
      catch(e) {
        _showAlert(context,e.toString());
      }    }
      else {
      print('Form is invalid');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
           child:
          Form(
             key: _formKey,
             child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => RegistrationScreen()));
                      },
                      child: Text('SIGNUP',style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),


                Container(
                    height: 200,
                    width: 300,
                    child: Image.asset('assets/images/appLogo.png')),
                SizedBox(height: 20,),
                labelandTextField("Username",usernameController),
                labelandTextField("Password",passwordController),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.black87
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 1)
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  onPressed: ()  async {

                    // try {
                    //   await FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text,
                    //       password: passwordController.text).then((value) {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (BuildContext context) => HomeScreen()));
                    //   });
                    // }
                    // catch(e) {
                    //   _showAlert(context);
                    // }
                    validateAndSave();
                    FocusScope.of(context).requestFocus(new FocusNode()); //remove focus

                  },
                )

              ],
          ),
           ),
        ),
      ),
    );
  }
  void _showAlert(BuildContext context,String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Failed"),
          content: Text("$message"),
        )
    );
  }
  Widget labelandTextField(String name,TextEditingController controller){
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              TextFormField(
                controller: controller,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                ),
                validator: (value) =>
                value!.isEmpty ? '$name cannot be blank' : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
