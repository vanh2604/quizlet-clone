import 'package:flutter/material.dart';
import 'package:quizlet/widgets/user/option_card.dart';
import 'package:quizlet/widgets/user/profile_card.dart';
import 'package:quizlet/services/auth.services.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileCard(),
          GestureDetector(
            child: const OptionCard(icon: Icons.storage_rounded, text: 'Sets'),
            onTap: () async {},
          ),
          GestureDetector(
            child: const OptionCard(
                icon: Icons.folder_copy_rounded, text: 'Folders'),
            onTap: () async {},
          ),
          GestureDetector(
            child: const OptionCard(
                icon: Icons.door_back_door_rounded, text: 'Sign Out'),
            onTap: () async {
              await AuthService().signOut();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/introduction', (Route<dynamic> route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
