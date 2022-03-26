// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/HomeLoadingPage.dart';
import 'package:nearcals/shared/userLang.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Define Firebase variables
  final regUsernameController = TextEditingController();
  final regEmailController = TextEditingController();
  final regDailyCalControl = TextEditingController();

  //Define Image variable
  File? fileImg;

  @override
  void initState() {
    regUsernameController.text = currentUser.getUserName()!;
    regEmailController.text = currentUser.getEmail()!;
    regDailyCalControl.text = currentUser.getDailyCals().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var styleInput = const TextStyle(color: Colors.white);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.indigo.shade700,
        appBar: AppBar(
          title: Text(text('Profile')),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        buildImage(context),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: regUsernameController,
                      style: styleInput,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: regEmailController,
                      style: styleInput,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: regDailyCalControl,
                      style: styleInput,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.whatshot,
                          color: Colors.white,
                        ),
                        labelText: 'Daily Calories',
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: updateProfile,
                      child: Text(text('Apply')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Widget to create CircleAvatar
  Widget buildImage(BuildContext context) {
    //Variables
    FileImage? image;

    // Null-Safety
    if (fileImg != null) {
      image = FileImage(File(fileImg!.path));
    }

    return ClipOval(
        child: Material(
            color: const Color.fromARGB(
              129,
              180,
              189,
              185,
            ),
            child: Ink.image(
              image: (fileImg != null)
                  ? image as ImageProvider
                  : NetworkImageWithRetry(
                      currentUser.getUserImageURL().toString()),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
              child: InkWell(
                  onTap: () async => showImageSource(context),
                  splashColor: const Color.fromARGB(
                    196,
                    4,
                    59,
                    229,
                  ),
                  highlightColor: const Color.fromARGB(
                    129,
                    180,
                    189,
                    185,
                  )),
            )));
  }

  //Show options to change photo
  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      child: Text(text('Camera')),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      }),
                  CupertinoActionSheetAction(
                      child: Text(text('Gallery')),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }),
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blue.shade900,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: Text(text('Profile Photo'),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  ListTile(
                    iconColor: Colors.blue.shade900,
                    leading: const Icon(Icons.camera_alt),
                    title: Text(text('Camera')),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                      iconColor: Colors.blue.shade900,
                      leading: const Icon(Icons.image),
                      title: Text(text('Gallery')),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }),
                ],
              ));
    }
  }

  ///Function to take photo or retrieve photo from gallery
  Future pickImage(ImageSource source) async {
    try {
      //Get a photo depend on gallery or camera
      final pickFile = await ImagePicker().pickImage(source: source);

      //End function if an image is not selected
      if (pickFile == null) return;

      //Edit and Update photo
      editImage(pickFile.path);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  dynamic newImage;

  ///Function to edit a photo
  Future editImage(String imagePath) async {
    // Set crop settings
    final editImg = await ImageCropper().cropImage(
        sourcePath: imagePath,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue.shade900,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: false,
          aspectRatioLockEnabled: false,
          minimumAspectRatio: 1.0,
        ));

    //Update photo into UI
    if (editImg != null) {
      newImage = editImg;
      setState(() => fileImg = editImg);
    }
  }

  ///Function to update information profile
  void updateProfile() {
    currentUser.setUserName(regUsernameController.text.trim());
    currentUser.setEmail(regEmailController.text.trim());
    currentUser.setDailyCals(int.parse(regDailyCalControl.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(text('Update Successful')),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green.shade700),
    );
    currentUser.setUserImage(newImage).then((value) {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeLoadingPage()));
    });
  }
}
