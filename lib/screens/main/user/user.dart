import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  final StorageService storageService = StorageService();
  Widget profileCard = const ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              await _uploadAvatar();
              setState(() {
                profileCard = const ProfileCard();
              });
            },
            child: profileCard,
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

  Future<void> _uploadAvatar() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      await storageService.uploadAvatar(result);
    }
  }

  // final ImagePicker _picker = ImagePicker();

  // Future imgFromGallery() async {
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       uploadAvatar(pickedFile);
  //     }
  //   });
  // }

  // Future imgFromCamera() async {
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       uploadAvatar(pickedFile);
  //     }
  //   });
  // }

  // void _showPicker(BuildContext context) {
  //   showBarModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //                 imgFromGallery();
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 imgFromCamera();
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
