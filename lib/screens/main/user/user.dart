import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quizlet/services/auth.services.dart';
import 'package:quizlet/services/storage.services.dart';
import 'package:quizlet/widgets/user/option_card.dart';
import 'package:quizlet/widgets/user/profile_card.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showPicker(context),
            child: const ProfileCard(),
          ),
          GestureDetector(
            child: const OptionCard(icon: Icons.storage_rounded, text: 'Sets'),
            onTap: () async {},
          ),
          GestureDetector(
            child: const OptionCard(
              icon: Icons.folder_copy_rounded,
              text: 'Folders',
            ),
            onTap: () async {},
          ),
          GestureDetector(
            child: const OptionCard(
              icon: Icons.settings_rounded,
              text: 'Settings',
            ),
            onTap: () async {},
          ),
          GestureDetector(
            child: const OptionCard(
              icon: Icons.door_back_door_rounded,
              text: 'Sign Out',
            ),
            onTap: () async {
              await AuthService().signOut();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/introduction',
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        uploadAvatar(pickedFile);
      }
    });
  }

  Future imgFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        uploadAvatar(pickedFile);
      }
    });
  }

  void _showPicker(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
