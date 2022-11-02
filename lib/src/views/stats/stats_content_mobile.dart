import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripper_web/src/models/time_screen_models.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/time_screen_cubit.dart';

class StatsContentMobile extends StatefulWidget {
  const StatsContentMobile({super.key});

  @override
  State<StatsContentMobile> createState() => _StatsContentMobileState();
}

class _StatsContentMobileState extends State<StatsContentMobile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeScreenCubit, TimeScreenModels>(
        builder: (context, snapshot) {
      return Container(
        child: buildTimeText(
            numberTextSize: 15.sp,
            textSize: 10.sp,
            timeType: "Year",
            timeValue: snapshot.year,
            topPadding: 100.h < 1200 ? 4.h : 1.4.h),
      );
    });
  }

  Widget buildTimeText(
      {required String timeType,
      required double textSize,
      required double numberTextSize,
      required int timeValue,
      required double topPadding}) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('settings')
            .doc('stats')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            final data = snapshot.requireData;

            int totalYear = data['total_year'].toInt();
            return Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             
                  Text(
                  totalYear.toString(),
                    style: TextStyle(
                        fontFamily: "Roboto-Thin", fontSize: numberTextSize),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    timeType,
                    style: TextStyle(
                        fontFamily: "Roboto-Light", fontSize: textSize),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
