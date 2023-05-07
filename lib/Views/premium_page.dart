import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_learn_app/Controllers/premium_controller.dart';

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
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _controller.PremiumPages[0].mainImage,
              height: 200,
              width: 200,
            ),
            Text(
              "Unlock Everything!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCardIndex = 0; // set the selected card index
                        });
                      },
                      child: Card(
                        color: _selectedCardIndex == 0
                            ? Colors.blue
                            : Colors.white54, // change color based on selection
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text("for 1 Month"),
                              Text(
                                '\$10.00*',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCardIndex = 1; // set the selected card index
                        });
                      },
                      child: Card(
                        color: _selectedCardIndex == 1
                            ? Colors.blue
                            : Colors.white54, // change color based on selection
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text("for 12 Months"),
                              Text(
                                '\$50.00',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
