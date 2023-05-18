import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_learn_app/Controllers/premium_controller.dart';
import 'package:my_learn_app/Views/help_faq.dart';
import 'package:my_learn_app/Constants/string_constant.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  int _selectedCardIndex = -1;

  final _controller = PremiumController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Upgrade to Pro',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_img/bg_img_2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Image.asset(
                _controller.PremiumPages[0].mainImage,
                height: 130,
                width: 130,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Unlock Everything!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Access exclusive affirmations.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Daily backup of your personal data.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Affirmations that reasonate with you.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Enjoy your first 5 days. its free.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCardIndex =
                                  0; // set the selected card index
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1),
                                colors: _selectedCardIndex == 0
                                    ? <Color>[
                                        Color(0xffdadada),
                                        Color(0xffa0b3b8)
                                      ]
                                    : <Color>[
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255)
                                      ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            height: 70,
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("for 1 Month"),
                                Text(
                                  '\$10.00*',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCardIndex =
                                  1; // set the selected card index
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1),
                                colors: _selectedCardIndex == 1
                                    ? <Color>[
                                        Color(0xffdadada),
                                        Color(0xffa0b3b8)
                                      ]
                                    : <Color>[
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255)
                                      ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            height: 70,
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("for 12 Months"),
                                Text(
                                  '\$50.00',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        Platform.isAndroid
                            ? 'Secured by the Play Store. Payments will be charged to your PlayStore account at confirmation of purhase.'
                            : 'Secured by the App Store. Payments will be charged to your iTunes account at confirmation of purhase.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HelpFAQScreen()));
                              },
                              child: Text(
                                'FAQ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {
                                PremiumController.launchUrl(
                                    StaticLinks.privacyPolicy);
                              },
                              child: Text(
                                'PRIVACY',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {
                                PremiumController.launchUrl(StaticLinks.terms);
                              },
                              child: Text(
                                'TERMS',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
