import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_gym_trainer/config/styles.dart';
import 'package:online_gym_trainer/firebasefunctions.dart/functions.dart';
import 'package:online_gym_trainer/screeens/chatpage.dart';

class TraineeScreens extends StatelessWidget {
  const TraineeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("trainees"),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection("users")
            .where("traineremail", isEqualTo: auth.currentUser?.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('You Have No Trainees '),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(userData["username"] ?? "",style: Styles.subtitle(context),), 
                        leading:userData["image"]==null|| userData["image"].isEmpty ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("lib/assets/user (2).png")):Image.network(userData["image"]), 
                        onTap: () {
 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>  ChatPage(username:userData["username"] , email: userData["email"],),
                      ),
                    );

                          },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
