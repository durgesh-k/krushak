import 'package:flutter/material.dart';
import 'package:krushak/auth/auth.dart';
import 'package:krushak/globals.dart';
import 'package:page_transition/page_transition.dart';

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String? lang = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: getHeight(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.srcOver),
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/farmer.jpg',
                ))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: getHeight(context) * 0.3,
                    width: getWidth(context) * 0.4,
                    child: Image.asset(
                      'assets/english_logo_transparent.png',
                      fit: BoxFit.contain,
                    )),
                Text(
                  'Choose your language\n',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 30, color: secondary),
                ),
                Text(
                  'अपनी भाषा चुनें',
                  style: TextStyle(
                      fontFamily: 'SemiBold', fontSize: 30, color: secondary),
                ),
                SizedBox(
                  height: getHeight(context) * 0.08,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      lang = 'English';
                      langCode = 'en';
                      language = 'English';
                    });
                  },
                  child: Container(
                    height: 60,
                    width: getWidth(context),
                    decoration: BoxDecoration(
                        color: lang == 'English' ? primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'English',
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            color:
                                lang == 'English' ? Colors.white : Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.03,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      lang = 'Hindi';
                      langCode = 'hi';
                      language = 'हिन्दी';
                    });
                  },
                  child: Container(
                    height: 60,
                    width: getWidth(context),
                    decoration: BoxDecoration(
                        color: lang == 'Hindi' ? primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'हिन्दी',
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            color:
                                lang == 'Hindi' ? Colors.white : Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.bounceInOut,
                          type: PageTransitionType.rightToLeft,
                          child: PhoneAuth()),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: getWidth(context),
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'Next | आगे जाए ➟',
                        style: TextStyle(
                            fontFamily: 'SemiBold',
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
