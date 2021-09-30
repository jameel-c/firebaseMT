import 'package:firebase/otp_screen.dart';
import 'package:firebase/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            customHomeButton("Log a Fishing Spot"),
            customHomeButton("View my Spots"),
            customHomeButton("View my Catches"),
            customHomeButton("MyGear"),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/images/home.svg",height: 40,width: 40,),
                      SvgPicture.asset("assets/images/location.svg",height: 40,width: 40,),
                      SvgPicture.asset("assets/images/fish.svg",height: 40,width: 40,),
                      SvgPicture.asset("assets/images/menu.svg",height: 40,width: 40,),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
     // bottomNavigationBar:
      // BottomNavigationBar(
      //   backgroundColor: Colors.transparent,
      //   onTap: (newIndex) => setState(() => _index = newIndex),
      //   currentIndex: _index,
      //   items: [
      //     BottomNavigationBarItem(icon:SvgPicture.asset("assets/images/home.svg",height: 20,width: 20,), title: Text("")),
      //     BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/location.svg")), title: Text("")),
      //     BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/fish.svg")), title: Text("")),
      //     BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/menu.svg")), title: Text("")),
      //   ],
      // ),
    );

  }
  Widget customHomeButton(String name){
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 100,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(color: Colors.white,width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20),)
          ),
          child: OutlinedButton(

            onPressed: () {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) => OtpScreen()));
            },
            child: Text(name,style: TextStyle(color: Colors.white),),

          ),
        ),
      );
  }
}
