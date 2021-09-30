import 'package:firebase/login_screen.dart';
import 'package:firebase/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController secondnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repasswordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if(passwordController.text.trim() == repasswordController.text.trim()) {
        try {
          FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text,
              password: passwordController.text).then((value) {
            FirebaseFirestore.instance.collection("Users").doc(value.user!.uid).set(
                {"email" : emailController.text, "password" : passwordController.text,
                  "firstname": firstnameController.text,"lastname":secondnameController.text}
            );
            emailController.clear();
            passwordController.clear();
            firstnameController.clear();
            secondnameController.clear();
            setState(() {});
            _showAlert(context,"user created successfully. click verify button for email verification");

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => LoginScreen()));
          });
        }catch (e){
          _showAlert(context,e.toString());
        }

      }
      else{
        _showAlert(context,"please enter the same password");

      }

    }
    else {
      print('Form is invalid');
    }
  }
  void _showAlert(BuildContext context,String data) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Failed"),
          content: Text("$data"),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
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
                            builder: (BuildContext context) => OtpScreen()));
                      },
                      child: Text('Varify Email',style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),

                Text("Registration", style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),),
                labelandTextField("First Name", firstnameController),
                labelandTextField("Last Name", secondnameController),
                labelandTextField("Email", emailController),
                labelandTextField("Enter Password", passwordController),
                labelandTextField("Re Enter Password", repasswordController),

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
                        border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Text(
                      'Proceed',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onPressed: () {
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

  Widget labelandTextField(String name, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 30, right: 30),
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
