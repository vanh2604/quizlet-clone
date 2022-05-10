import 'package:flutter/material.dart';
import 'package:quizlet/services/user.services.dart';
import 'package:quizlet/utils/colors.dart';
import 'package:quizlet/widgets/qtext.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String avatarURL = '';
  String name = '';
  String email = '';

  @override
  void initState() {
    getAvatarURL().then((String result) {
      setState(() {
        avatarURL = result;
      });
    });
    getDisplayName().then((String result) {
      setState(() {
        name = result;
      });
    });
    getEmail().then((String result) {
      setState(() {
        email = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 100,
                child: Container(
                  color: secondaryColor.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      avatarURL == ''
                          ? Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.05),
                              child: const CircularProgressIndicator(),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(avatarURL),
                              backgroundColor: Colors.transparent),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QText(text: name, color: Colors.white, isBold: true),
                          QText(
                              text: email, color: Colors.white, isBold: false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
