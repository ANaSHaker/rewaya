import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import 'Home.dart';
import 'constants.dart';


class Draweer extends StatefulWidget {


  @override
  _DraweerState createState() => _DraweerState();
}

class _DraweerState extends State<Draweer> with TickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: WillPopScope(
          onWillPop: () {
            return  AwesomeDialog(
              context: context,

              headerAnimationLoop: false,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              body: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: Text("هل تود اغلاق التطبيق",textAlign: TextAlign.center,),
                ),

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(

                      color: Colors.green,
                      child: Text("نعم"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      child: Text("لا"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            )
                .show();


          },
          child: KFDrawer(

            controller: KFDrawerController(
              initialPage : HomePage(),
              items: [
                KFDrawerItem.initWithPage(
                  text: Text("مشاركه التطبيق", style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    Share.share(
                        "Hey! Check out this app on Playstore. Coupons app for all offers from different places. If you love the app please review the app on playstore and share it with your friends. https://play.google.com/store/apps/details?id=com.rewaya.rewaya");

                  },

                ),
                KFDrawerItem.initWithPage(
                  text: Text(
                    "تقييم التطبيق",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.stars, color: Colors.white),
                  onPressed: () {
                    LaunchReview.launch();

                  },
                ),
                KFDrawerItem.initWithPage(
                  text: Text(
                    "الوضع الليلي",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.info, color: Colors.white),
                  onPressed: changeBrightness

                ),
              ],
            ),
            header: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset(
                  'assets/logo.png',
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            decoration: Theme.of(context).brightness == Brightness.dark
                ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradientDarkStart, gradientDarkEnd],
                tileMode: TileMode.repeated,
              ),
            ) : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradientLightStart, gradientLightEnd],
                tileMode: TileMode.repeated,
              ),
            ),
            footer: Container(),
          ),
        )


    );
  }
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}
