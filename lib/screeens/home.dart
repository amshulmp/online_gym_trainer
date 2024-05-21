import 'package:flutter/material.dart';
import 'package:online_gym_trainer/firebasefunctions.dart/functions.dart';
import 'package:online_gym_trainer/screeens/chats.dart';
import 'package:online_gym_trainer/screeens/login.dart';
import 'package:online_gym_trainer/screeens/payments.dart';
import 'package:online_gym_trainer/screeens/paymenttrack.dart';
import 'package:online_gym_trainer/screeens/profile.dart';
import 'package:online_gym_trainer/screeens/progressupdate.dart';
import 'package:online_gym_trainer/screeens/trainee.dart';
import 'package:online_gym_trainer/widgets/tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text("H O M E"),
      actions: [
        IconButton(onPressed: ()async{
          Navigator.popUntil(context, (route) => route.isFirst);
         Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );
          await signout();
        }, icon:  const Icon(Icons.logout))
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // NeumorphicListTile(
            //   text: "Chats",
            //   imagePath: "lib/assets/chat.png",
            //   ontap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => const ChatsScreen(),
            //           ),
            //         );
            //   },
            // ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             NeumorphicListTile(
              text: "Trainee",
              imagePath: "lib/assets/fitness (1).png",
              ontap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const TraineeScreens(),
                      ),
                    );
              },
            ),
            //  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            //  NeumorphicListTile(
            //   text: "payments",
            //   imagePath: "lib/assets/credit-card.png",
            //   ontap: () {
            //     Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => const PaymentsScreen(),
            //           ),
            //         );
            //   },
            // ),
            //  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            //  NeumorphicListTile(
            //   text: "Progress tracking",
            //   imagePath: "lib/assets/clipboard.png",
            //   ontap: () {
            //     Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => const ProgressTracking(),
            //           ),
            //         );
            //   },
            // ),
            //   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            //  NeumorphicListTile(
            //   text: "Progress update",
            //   imagePath: "lib/assets/status-update.png",
            //   ontap: () {
            //     Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => const ProgressUpdate(),
            //           ),
            //         );
            //   },
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             NeumorphicListTile(
              text: "profile",
              imagePath: "lib/assets/user (2).png",
              ontap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ProfileScreen(),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}