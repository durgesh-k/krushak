import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:krushak/globals.dart';

class NearbyTrainingsAdd extends StatefulWidget {
  const NearbyTrainingsAdd({Key? key}) : super(key: key);

  @override
  State<NearbyTrainingsAdd> createState() => _NearbyTrainingsAddState();
}

class _NearbyTrainingsAddState extends State<NearbyTrainingsAdd> {
  double opacity = 0.0;
  double emailOpacity = 0.0;
  String msg = '';
  TextEditingController title = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String start = '';
  String end = '';

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: startTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != startTime)
      setState(() {
        startTime = picked_s;
        start = '${startTime.hour}:${startTime.minute}';
      });
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: endTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != endTime)
      setState(() {
        endTime = picked_s;
        end = '${endTime.hour}:${endTime.minute}';
      });
  }

  Future<void> addSubmission() async {
    final _storage = FirebaseStorage.instance;

    await Permission.storage.request();
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc'],
      );
      PlatformFile pdf;
      var fileName = result!.paths.toString().split('/').last;
      if (result != null) {
        setState(() {
          submitting = true;
        });
        var snapshot = await _storage
            .ref()
            .child('$fileName-${FirebaseAuth.instance.currentUser!.uid}')
            .putFile(File(result.files.first.path!));
        var downloadUrl = await snapshot.ref.getDownloadURL();
        Map<String, dynamic> map = {
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'file': downloadUrl.toString(),
          'filename': fileName.toString()
        };
        try {
          await FirebaseFirestore.instance.collection('Nearby').add(map);
          showToast('File submitted successfully');
          setState(() {
            submitting = false;
          });
        } catch (e) {
          setState(() {
            submitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Publish New Training',
              style: TextStyle(
                  fontFamily: 'SemiBold', fontSize: 20, color: secondary),
            ),
          ],
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Title',
              style: TextStyle(
                  fontFamily: 'SemiBold', fontSize: 16, color: secondary),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: title,
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
                      color: Colors.black.withOpacity(0.0), width: 2),
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
                hintText: 'Your Training title here',
                hintStyle: TextStyle(
                  fontFamily: "Medium",
                  fontSize: 20, //16,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Date',
              style: TextStyle(
                  fontFamily: 'SemiBold', fontSize: 16, color: secondary),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary!.withOpacity(0.3)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      startDate != null
                          ? "" +
                              DateFormat("MMM d, yy")
                                  .format(startDate!)
                                  .toString()
                          : "Select ",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary),
                    ),
                    TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                  itemStyle: TextStyle(
                                      color: secondary,
                                      fontFamily: 'SemiBold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  cancelStyle: TextStyle(
                                    fontFamily: 'SemiBold',
                                    color: Colors.black54,
                                  ),
                                  doneStyle: TextStyle(
                                    fontFamily: 'SemiBold',
                                    color: primary,
                                  )),
                              showTitleActions: true,
                              minTime: DateTime(1950, 3, 5),
                              maxTime: DateTime(2023, 3, 5), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print(date.toString());
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            final String formatted = formatter.format(date);

                            startDate = date;
                            // print(userDetails!);
                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Icon(Icons.calendar_month_outlined))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary!.withOpacity(0.3)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      endDate != null
                          ? "" +
                              DateFormat("MMM d, yy")
                                  .format(endDate!)
                                  .toString()
                          : "Select ",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary),
                    ),
                    TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                  itemStyle: TextStyle(
                                      color: secondary,
                                      fontFamily: 'SemiBold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  cancelStyle: TextStyle(
                                    fontFamily: 'SemiBold',
                                    color: Colors.black54,
                                  ),
                                  doneStyle: TextStyle(
                                    fontFamily: 'SemiBold',
                                    color: primary,
                                  )),
                              showTitleActions: true,
                              minTime: DateTime(1950, 3, 5),
                              maxTime: DateTime(2023, 3, 5), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print(date.toString());
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            final String formatted = formatter.format(date);

                            endDate = date;
                            // print(userDetails!);
                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Icon(Icons.calendar_month_outlined))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Time',
              style: TextStyle(
                  fontFamily: 'SemiBold', fontSize: 16, color: secondary),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary!.withOpacity(0.3)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      start != null ? "" + start.toString() : "Select ",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary),
                    ),
                    TextButton(
                        onPressed: () async {
                          await _selectStartTime(context);
                        },
                        child: Icon(Icons.hourglass_bottom_rounded))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary!.withOpacity(0.3)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      end != null ? "" + end.toString() : "Select ",
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 16,
                          color: secondary),
                    ),
                    TextButton(
                        onPressed: () async {
                          await _selectEndTime(context);
                        },
                        child: Icon(Icons.hourglass_bottom_rounded))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
