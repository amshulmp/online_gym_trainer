import 'package:flutter/material.dart';
import 'package:online_gym_trainer/widgets/tile.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T R A I N E R S"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: ListView.builder(
          itemCount: 60,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                NeumorphicListTile(
                  text: "trainer$index",
                  count: "",
                  imagePath: "lib/assets/user (2).png",
                  ontap: () {},
                ),
                  SizedBox(
            height:  MediaQuery.of(context).size.height * 0.013
           ),
              ],
            );
          },
        ),
      ),
    );
  }
}
