import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_gym_trainer/config/styles.dart';
import 'package:online_gym_trainer/firebasefunctions.dart/functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File ?file;
   Future<void> pickCertificateFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    } else {
      // User canceled the image picking
    }
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Trainers")
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
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
              child: Text('No data available.'),
            );
          } else {
            final trainerData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.height * 0.2,
                            child: CircleAvatar(
                              backgroundImage: trainerData["image"].isEmpty||trainerData["image"]==null
                                  ? const AssetImage("lib/assets/user (2).png")
                                      as ImageProvider<Object>
                                  : NetworkImage(trainerData["image"]),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () async{
                                await pickCertificateFile();
                              final image= await uploadFileToFirebase(file!);
                              updateprofile({"image":image});
                              },
                              icon: const Icon(Icons.add_a_photo,color: Colors.black,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Username",
                          style: Styles.subtitlegrey(context),
                        ),
                     
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${trainerData["username"]}",
                        style: Styles.labelText(context),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "email",
                          style: Styles.subtitlegrey(context),
                        ),
                     
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${trainerData["email"]}",
                        style: Styles.labelText(context),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone",
                          style: Styles.subtitlegrey(context),
                        ),
                     
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${trainerData["phone"]}",
                        style: Styles.labelText(context),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: Styles.subtitlegrey(context),
                        ),
                     
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${trainerData["location"]}",
                        style: Styles.labelText(context),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Type",
                          style: Styles.subtitlegrey(context),
                        ),
                     
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${trainerData["type"]}",
                        style: Styles.labelText(context),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
