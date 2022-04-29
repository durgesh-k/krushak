import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krushak/globals.dart';
import 'package:krushak/home.dart';
import 'package:krushak/languageSelect.dart';
import 'package:page_transition/page_transition.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Home();
    } else {
      return LanguageSelect();
    }
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LanguageSelect()),
      );
    });
  } catch (e) {
    print("error");
  }
}

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  double opacity = 0.0;
  double emailOpacity = 0.0;
  double passOpacity = 0.0;
  String msg = '';
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  bool loading = false;
  bool sentloading = false;
  String? countryCode = '+91';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: const EdgeInsets.only(left: 48.0),
          child: Container(
            height: height,
            width: width,
            child: Form(
              key: loginkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(context) * 0.07,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 30,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * 0.04,
                  ),
                  Image.asset(
                    'assets/logo_transparent.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please enter your Mobile Number\n',
                    style: TextStyle(
                        fontFamily: 'Bold', fontSize: 30, color: secondary),
                  ),
                  Text(
                    'अपना मोबाइल नंबर दर्ज करें',
                    style: TextStyle(
                        fontFamily: 'Bold', fontSize: 30, color: secondary),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        child: TextFormField(
                          initialValue: countryCode,
                          onChanged: (v) {
                            setState(() {
                              countryCode = v;
                            });
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(' ')
                          ],
                          style: TextStyle(
                            fontFamily: "Medium",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            filled: false,
                            fillColor: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: mobile,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              setState(() {
                                opacity = 1.0;
                                emailOpacity = 1.0;
                                msg = 'Mobile Number is required';
                              });
                              return null;
                            } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                .hasMatch(value)) {
                              setState(() {
                                opacity = 1.0;
                                emailOpacity = 1.0;
                                msg = 'Please enter a valid Mobile Number';
                              });
                              return null;
                            }
                            setState(() {
                              emailOpacity = 0.0;
                            });
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(' ')
                          ],
                          style: TextStyle(
                            fontFamily: "Medium",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            filled: false,
                            fillColor: Colors.white.withOpacity(0.1),
                            suffixIcon: Icon(
                              Icons.error,
                              size: 15,
                              color: Colors.red.withOpacity(emailOpacity),
                            ),
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                              fontFamily: "Medium",
                              fontSize: 20, //16,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(milliseconds: 300),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 10,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: width * 0.8,
                          child: Text(
                            msg,
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'MediumItalic'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                      elevation: 0,
                      splashColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        if (emailOpacity == 0.0) {
                          setState(() {
                            opacity = 0.0;
                          });
                        }
                        if (loginkey.currentState!.validate()) {
                          /*setState(() {
                            loading = true;
                          });*/
                          if (emailOpacity == 0.0) {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            setState(() {
                              sentloading = true;
                            });

                            await auth.verifyPhoneNumber(
                              phoneNumber: '$countryCode ${mobile.text}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                /*var result = await auth
                                    .signInWithCredential(credential);
                                showToast('Account Created');
                                var user = result.user;

                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.bounceInOut,
                                        type: PageTransitionType.rightToLeft,
                                        child: HomePage()),
                                  );
                                } else {
                                  showToast(
                                      'Error creating account\nPlease try again');
                                }*/
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                              codeSent: (String verificationId,
                                  int? forceResendingToken) {
                                //showToast('OTP sent');
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.bounceInOut,
                                      type: PageTransitionType.rightToLeft,
                                      child: PhoneOTP(
                                        verificationId: verificationId,
                                      )),
                                );
                              },
                              verificationFailed:
                                  (FirebaseAuthException error) {
                                //Navigator.pop(context);
                                setState(() {
                                  sentloading = false;
                                });
                                /*showToast(
                                    'Error Verifying\nPlease check your Mobile Number and try again');*/
                              },
                            );
                          }
                        } else {}
                      },
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primary),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: sentloading
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Next | आगे जाए ➟',
                                        style: TextStyle(
                                            fontFamily: 'SemiBold',
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class PhoneOTP extends StatefulWidget {
  final String? verificationId;
  const PhoneOTP({this.verificationId});

  @override
  _PhoneOTPState createState() => _PhoneOTPState();
}

class _PhoneOTPState extends State<PhoneOTP> {
  double opacity = 0.0;
  double emailOpacity = 0.0;
  double passOpacity = 0.0;
  String msg = '';
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  bool loading = false;
  bool sentloading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: const EdgeInsets.only(left: 48.0, top: 0),
          child: Container(
            height: height,
            width: width,
            child: Form(
              key: loginkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(context) * 0.07,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 30,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * 0.04,
                  ),
                  Image.asset(
                    'assets/logo_transparent.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please enter your OTP\n',
                    style: TextStyle(
                        fontFamily: 'Bold', fontSize: 30, color: secondary),
                  ),
                  Text(
                    'अपना ओटीपी दर्ज करें',
                    style: TextStyle(
                        fontFamily: 'Bold', fontSize: 30, color: secondary),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: otp,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        setState(() {
                          opacity = 1.0;
                          emailOpacity = 1.0;
                          msg = 'OTP is required';
                        });
                        return null;
                      } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        setState(() {
                          opacity = 1.0;
                          emailOpacity = 1.0;
                          msg = 'OTP must be 6 digits only';
                        });
                        return null;
                      }
                      setState(() {
                        emailOpacity = 0.0;
                      });
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.3), width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      filled: false,
                      fillColor: Colors.white.withOpacity(0.1),
                      suffixIcon: Icon(
                        Icons.error,
                        size: 15,
                        color: Colors.red.withOpacity(emailOpacity),
                      ),
                      hintText: 'One Time Password',
                      hintStyle: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 20, //16,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(milliseconds: 300),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 10,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: width * 0.8,
                          child: Text(
                            msg,
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'MediumItalic'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  MaterialButton(
                      elevation: 0,
                      splashColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        if (emailOpacity == 0.0) {
                          setState(() {
                            opacity = 0.0;
                          });
                        }
                        if (loginkey.currentState!.validate()) {
                          /*setState(() {
                            loading = true;
                          });*/
                          if (emailOpacity == 0.0) {
                            setState(() {
                              sentloading = true;
                            });
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            final code = otp.text.trim();
                            try {
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: widget.verificationId!,
                                      smsCode: code);

                              var result =
                                  await _auth.signInWithCredential(credential);

                              var user = result.user;
                              if (user != null) {
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({'language': langCode});
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.bounceInOut,
                                        type: PageTransitionType.rightToLeft,
                                        child: Home()),
                                    (route) => false);
                              } else {
                                setState(() {
                                  sentloading = false;
                                });
                                //showToast('Incorrect OTP\nPlease try again');
                                print("Error");
                              }
                            } catch (e) {
                              setState(() {
                                sentloading = false;
                              });
                              //showToast('Incorrect OTP\nPlease try again');
                            }
                          }
                        } else {}
                      },
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primary),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: sentloading
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Next | आगे जाए ➟',
                                        style: TextStyle(
                                            fontFamily: 'SemiBold',
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
