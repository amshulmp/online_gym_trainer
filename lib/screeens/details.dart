// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_gym_trainer/config/styles.dart';
import 'package:online_gym_trainer/firebasefunctions.dart/functions.dart';
import 'package:online_gym_trainer/screeens/home.dart';
import 'package:online_gym_trainer/widgets/button.dart';
import 'package:online_gym_trainer/widgets/neumorphicbox.dart';
import 'package:online_gym_trainer/widgets/textbox.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  String? selectedType;
  File? file;
  bool showimage = false;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        showimage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Details To Continue",
                  style: Styles.subtitle(context),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              showimage
                  ? CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.1,
                      backgroundImage: FileImage(File(file!.path)),
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: false,
                tcontroller: locationcontroller,
                type: TextInputType.name,
                hinttext: "Location",
                icon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: false,
                tcontroller: phonecontroller,
                type: TextInputType.number,
                hinttext: "Phone",
                icon: Icon(
                  Icons.phone,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox2(
                hideText: false,
                tcontroller: descriptioncontroller,
                type: TextInputType.name,
                hinttext: "Description",
                icon: Icon(
                  Icons.description,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Row(
                children: [
                  Radio<String>(
                    value: 'Offline',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  Text(
                    'Offline',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  Radio<String>(
                    value: 'Online',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Row(
                children: [
                  Expanded(
                    child: NeumorphicBox(
                        child: TextButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text("pick image (optional)"))),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              CustomLoginButton(
                  text: "Submit",
                  onPress: () async {
                    if (locationcontroller.text.trim().isEmpty ||
                        phonecontroller.text.trim().isEmpty ||
                        descriptioncontroller.text.trim().isEmpty ||
                        selectedType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    String imageUrl = "";
                    if (file != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Uploading image and details...'),
                          duration: Duration(seconds: 3),
                        ),
                      );

                      final imageUrl = await uploadFileToFirebase(file!);
                      if (imageUrl!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to upload image.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        return;
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Uploading details...'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }

                    await updateprofile({
                      "image": imageUrl,
                      "location": locationcontroller.text.trim(),
                      "description": descriptioncontroller.text.trim(),
                      "phone": int.parse(phonecontroller.text.trim()),
                      "type": selectedType,
                    });

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const HomeScreen(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
