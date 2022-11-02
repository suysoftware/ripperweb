// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, duplicate_ignore

import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ripper_web/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../models/game_model.dart';
import '../../models/player_model.dart';

var targetGameNo = "";
var totalBetValue;
int sira = 0;

class GameContentDesktop extends StatefulWidget {
  const GameContentDesktop({super.key});

  @override
  State<GameContentDesktop> createState() => _GameContentDesktopState();
}

class _GameContentDesktopState extends State<GameContentDesktop>
    with TickerProviderStateMixin {
  var fortunePlayers = <FortuneItem>[];

  FortuneItemStyle fortuneStyle = const FortuneItemStyle(
      color: Colors.lightGreen,
      borderColor: Colors.black,
      borderWidth: 1.0,
      textAlign: TextAlign.center,
      textStyle: TextStyle(fontFamily: "Roboto"));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameGridView(
          fortunePlayers: fortunePlayers,
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class GameGridView extends StatefulWidget {
  GameGridView({super.key, required this.fortunePlayers});

  List<FortuneItem> fortunePlayers;

  @override
  State<GameGridView> createState() => _GameGridViewState();
}

class _GameGridViewState extends State<GameGridView>
    with TickerProviderStateMixin {
  StreamController<int> controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
   
        SizedBox(
          height: 4.h,
        ),
        gameInfoBuild(),
        SizedBox(
          height: 4.h,
        ),
        fortuneBarBuild(),
        SizedBox(
          height: 4.h,
        ),
        playersTableBuilder()
      ],
    );
  }

  Widget fortuneBarBuild() {
    return StreamBuilder<QuerySnapshot<GameModel>>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .orderBy('gameDate', descending: true)
            .limit(1)
            .withConverter<GameModel>(
              fromFirestore: (snapshot, _) =>
                  GameModel.fromJson(snapshot.data()!),
              toFirestore: (message, _) => message.toJson(),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              // ignore: prefer_const_constructors
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.requireData;
            var qrData = <GameModel>[];
            for (var item in data.docs) {
              qrData.add(item.data());
            }

            targetGameNo = qrData.first.gameNo;
            return StreamBuilder<QuerySnapshot<PlayerModel>>(
                stream: FirebaseFirestore.instance
                    .collection('games')
                    .doc(qrData.first.gameNo)
                    .collection("players")
                    .withConverter<PlayerModel>(
                      fromFirestore: (snapshot, _) =>
                          PlayerModel.fromJson(snapshot.data()!),
                      toFirestore: (message, _) => message.toJson(),
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.requireData;

                    if (data.docs.isEmpty) {
                      return CircularProgressIndicator();
                    } else {
                      var playerData = <PlayerModel>[];
                      for (var item in data.docs) {
                        playerData.add(item.data());

                        widget.fortunePlayers.add(
                            FortuneItem(child: Text(item.data().playerName)));
                      }

                      if (widget.fortunePlayers.first.child.toString() !=
                              'Text(${qrData.first.gameWinner['playerName']})' &&
                          playerData.last.playerName !=
                              qrData.first.gameWinner['playerName'] &&
                          playerData.last.playerName != "-") {
                        //  lineGiver(qrData.first.gameWinner['playerName']);

                        widget.fortunePlayers.insert(
                            1,
                            FortuneItem(
                                child: Text(
                                    qrData.first.gameWinner['playerName'])));
                     
                      }

                      return qrData.first.rollWheel == false
                          ? SizedBox()
                          : FortuneBar(
                              onAnimationEnd: () {
                              
                                FirebaseFirestore.instance
                                    .collection('games')
                                    .doc(qrData.first.gameNo)
                                    .update({'gameFinish': true});
                                widget.fortunePlayers.clear();
                              },
                              styleStrategy: const UniformStyleStrategy(
                                  color: Colors.white,
                                  borderColor: Colors.black,
                                  borderWidth: 1.0,
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(fontFamily: "Roboto")),
                              height: 10.h,
                              fullWidth: false,
                              animateFirst: false,
                              curve: FortuneCurve.spin,
                              physics: CircularPanPhysics(
                                  duration: Duration(seconds: 8),
                                  curve: Curves.easeOutExpo),
                              selected: Stream.value(1),
                              items: widget.fortunePlayers);
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget gameInfoBuild() {
    return StreamBuilder<QuerySnapshot<GameModel>>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .orderBy('gameDate', descending: true)
            .limit(1)
            .withConverter<GameModel>(
              fromFirestore: (snapshot, _) =>
                  GameModel.fromJson(snapshot.data()!),
              toFirestore: (message, _) => message.toJson(),
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.requireData;
            var qrData = <GameModel>[];
            for (var item in data.docs) {
              qrData.add(item.data());
            }

            if (qrData.first.betFinish) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  qrData.first.gameFinish == false
                      ? noMoreBetBuild()
                      : SizedBox(),
                  if (qrData.first.gameFinish)
                    SizedBox(
                      width: 5.w,
                    ),
                  if (qrData.first.gameFinish == false)
                    SizedBox(
                      width: 10.w,
                    ),
                  if (qrData.first.gameFinish)
                    gameWinnerTextBuild(qrData.first.gameWinner['playerName'],
                        qrData.first.gameTotalBet)
                  else
                    gameTotalBetBuild(qrData.first.gameTotalBet / 86400000),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  qrBoxBuild('${qrData.first.gameNo}//RIPPER-ROULETTE'),
                  SizedBox(
                    width: 5.w,
                  ),
                  gameTotalBetBuild(qrData.first.gameTotalBet / 86400000),
                  if (qrData.first.betFinishDate < DateTime.now().millisecond)
                    gameTimerBuild(qrData.first.betFinishDate -
                        DateTime.now().millisecond / 1000)
                  else if (qrData.first.rollTime < DateTime.now().millisecond)
                    gameTimerBuild(qrData.first.rollTime -
                        DateTime.now().millisecond / 1000)
                  else if (qrData.first.newGameDate <
                      DateTime.now().millisecond)
                    gameTimerBuild(qrData.first.newGameDate -
                        DateTime.now().millisecond / 1000)
                ],
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget qrBoxBuild(String qrNo) {
    return Container(
      decoration: BoxDecoration(
          color: themeGreen,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: SizedBox(
          height: 50.sp,
          width: 50.sp,
          child: QrImage(
            data: qrNo,
            size: 50.w,
          ),
        ),
      ),
    );
  }

  Widget gameTotalBetBuild(double totalBet) {
    totalBetValue = totalBet;
    return Column(
      children: [
        const Text(
          "TOTAL BET",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 38, fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$totalBet",
            style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 38,
                fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget playersTableBuilder() {
    return SizedBox(
      height: 15.h,
      width: 50.w,
      child: StreamBuilder<QuerySnapshot<GameModel>>(
          stream: FirebaseFirestore.instance
              .collection('games')
              .orderBy('gameDate', descending: true)
              .limit(1)
              .withConverter<GameModel>(
                fromFirestore: (snapshot, _) =>
                    GameModel.fromJson(snapshot.data()!),
                toFirestore: (message, _) => message.toJson(),
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.requireData;
              var qrData = <GameModel>[];
              for (var item in data.docs) {
                qrData.add(item.data());
              }
              targetGameNo = qrData.first.gameNo;
              return StreamBuilder<QuerySnapshot<PlayerModel>>(
                  stream: FirebaseFirestore.instance
                      .collection('games')
                      .doc(qrData.first.gameNo)
                      .collection("players")
                      .withConverter<PlayerModel>(
                        fromFirestore: (snapshot, _) =>
                            PlayerModel.fromJson(snapshot.data()!),
                        toFirestore: (message, _) => message.toJson(),
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final data = snapshot.requireData;

                      if (data.docs.isEmpty) {
                        return SizedBox();
                      } else {
                        var playerData = <PlayerModel>[];

                        for (var item in data.docs) {
                          //  playerData.clear();

                          playerData.add(item.data());
                        }

                        return playerGridBuild(playerData);

                        /*  ListView.builder(
                          itemCount: playerData.length,
                          itemBuilder: (context, indeksNumarasi) => Text(
                            playerData[indeksNumarasi].playerName,
                            style: TextStyle(fontSize: 5.sp),
                          ),
                        );*/
                      }
                    } else {
                      return Center(
                        child: SizedBox(),
                      );
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget gameTimerBuild(double countTime) {
    return CircularCountDownTimer(
      duration: 10,
      initialDuration: 0,
      controller: CountDownController(),
      width: 15.sp,
      height: 15.sp,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 5.sp,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
    );
  }

  Widget gameWinnerTextBuild(String winnerName, int winValue) {
    return Stack(alignment: Alignment.center, children: [
      Card(
          elevation: 0,
          child: Image.asset(
            'assets/images/winnerbox.png',
            scale: 1.5,
            filterQuality: FilterQuality.high,
          )),
      Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              winnerName.toUpperCase(),
              style: TextStyle(fontFamily: 'Roboto-Medium', fontSize: 22),
            )),
      )
    ]);
  }

  Widget noMoreBetBuild() {
    return Row(
      children: [
        qrGiftBoxBuild(),
        SizedBox(width: 3.w,),

        Container(
          height: 40.sp,
          width: 40.sp,
          decoration: BoxDecoration(
              color: themeGreen,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.all(1.h),
            child: Text(
              'No \n  More \n      Bet!',
              style: TextStyle(fontFamily: 'Roboto', fontSize: 10.sp),
            ),
          ),
        ),
      ],
    );
  }
}

  Widget qrGiftBoxBuild() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gifts')
            .orderBy('finish_time', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            final data = snapshot.requireData;
         
            var giftNo = data.docs.first['gift_no'];
       
            return Container(
              decoration: const BoxDecoration(
                  color: themeGreen,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  children: [
                    Text('Daily Bonus: ${data.docs.first['gift_value']}',style: TextStyle(fontFamily: 'Roboto-Italic'),),
                    SizedBox(
                      height: 32.sp,
                      width: 32.sp,
                      child: QrImage(
                        data: giftNo + "//RIPPER-GIFT",
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
Widget playerGridBuild(List<PlayerModel> playerData) {
  playerData.sort((b, a) => a.betAmount.compareTo(b.betAmount));

  return GridView.builder(
      cacheExtent: 30.h,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, childAspectRatio: 1.2),
      itemCount: playerData.length,
      itemBuilder: (context, indeks) {
        return Card(
          color: themeGreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 9.sp,
              ),
              Text(
                (playerData[indeks].playerName.length >= 8 ? playerData[indeks].playerName.substring(0, 8) : playerData[indeks].playerName),
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              totalBetValue == null
                  ? Text("${playerData[indeks].betAmount / 86400000} Days",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 11))
                  : Text(
                      "${((playerData[indeks].betAmount / 86400000) / (totalBetValue / 100)).toStringAsFixed(2)} %",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 11))
            ],
          ),
        );
      });
      
}
