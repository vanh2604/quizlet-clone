import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
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

  final UserService userService = UserService();

  @override
  void initState() {
    userService.getAvatarURL().then((String result) {
      setState(() {
        avatarURL = result;
      });
    });
    userService.getDisplayName().then((String result) {
      setState(() {
        name = result;
      });
    });
    userService.getEmail().then((String result) {
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
                  color: secondaryColor,
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: avatarURL == ''
                            ? Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: const Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.lineScaleParty,
                                      colors: [Colors.white],
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(avatarURL),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QText(text: name, color: Colors.white, isBold: true),
                          QText(
                            text: email,
                            color: Colors.white,
                          ),
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
