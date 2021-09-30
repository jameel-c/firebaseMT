import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  EmailAuth emailAuth =  new EmailAuth(sessionName: "Sample session");

  @override
  void initState() {
    super.initState();
  }
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5
    );
    if (result) {
        print("otp send");
    }
    else{
      print("otp send failed");

    }
  }
  void verify() {
    bool result = emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: otpController.value.text);
    if (result) {
      print("otp varified");

    }
    else{
      print("not varified");

    }
  }

    @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          child: Column(
            children: [
              SizedBox(height: 100,),
              Container(
                  height: 200,
                  width: 300,
                  child: Image.asset('assets/images/appLogo.png')),
              SizedBox(height: 20,),
              Text("Please verify your Email", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),
              labelandTextField(emailController),
              Padding(
                padding: const EdgeInsets.only(top: 25.0,left: 30,right: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                    child: TextField(
                      controller: otpController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.black87,
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 2)
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                onPressed: () {
                  verify();
                  FocusScope.of(context).requestFocus(new FocusNode()); //remove focus

                },
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget labelandTextField(TextEditingController controller){
    return  Padding(
      padding: const EdgeInsets.only(top: 25.0,left: 30,right: 30),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  sendOtp();
                },
                child: Text('Send OTP',style: TextStyle(color: Colors.blue),),
              ),
            )
          ],
        ),
      ),
    );
  }

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
            TextField(
              controller: controller,
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
