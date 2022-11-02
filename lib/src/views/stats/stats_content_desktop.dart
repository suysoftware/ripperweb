import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripper_web/src/models/time_screen_models.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/time_screen_cubit.dart';


class StatsContentDesktop extends StatefulWidget {
  const StatsContentDesktop({super.key});

  @override
  State<StatsContentDesktop> createState() => _StatsContentDesktopState();
}

class _StatsContentDesktopState extends State<StatsContentDesktop> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeScreenCubit, TimeScreenModels>(
        builder: (context, snapshot) {
      return Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
           
         
      
          buildTimeText(
              numberTextSize: 15.sp,
              textSize: 10.sp,
              timeType: "Year",
              timeValue: snapshot.year,
              topPadding: 100.h < 1200 ? 0.h : 1.4.h),
        
         // startNewGift(),
        ],
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


  Widget startNewGift() {
    return TextButton(
        onPressed: () {
          int giftValue = 500;
          var dateNow = DateTime.now().add(const Duration(days: 1));
          var giftRef = FirebaseFirestore.instance.collection('gifts').doc();
          giftRef.set({
            'finish_time': dateNow,
            'gift_area': const GeoPoint(31.2, 32.1),
            'gift_no': giftRef.id,
            'gift_value': giftValue,
            'location_requirement': false
          });
          var staticRef = FirebaseFirestore.instance
              .collection('gifts')
              .doc(giftRef.id)
              .collection('gift_statistics')
              .doc('scan_statistics');
          staticRef.set({'scan_amount': 0});

          var recievedRef = FirebaseFirestore.instance
              .collection('gifts')
              .doc(giftRef.id)
              .collection('recieved_list');
          recievedRef.add({
            'gift_no': giftRef.id,
            'gift_value': giftValue,
            'recieve_location': const GeoPoint(31.2, 32.1),
            'recieve_time': 1656855074036,
            'reciever_uid': 'abidikkubidik'
          });
        },
        child: const Text('new gift'));
  }
}
