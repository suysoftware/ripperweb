// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

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
var exampleList = [
  {
    'playerUid': "0ATPaMfkqpV0FOPIzeCKVTxRhog2",
    'playerName': "Ahmet",
  },
  {
    'playerUid': "2HfYfL6FhEfdPJkheiROapswI6Q2",
    'playerName': "Fuat",
  },
  {
    'playerUid': "2hDEf4bT8qaFdc787eZ3riZ1xl82",
    'playerName': "Mithat",
  },
  {
    'playerUid': "5Hy9qeC92bPtJVcuVerGVNGS1nu1",
    'playerName': "Sezer",
  },
  {
    'playerUid': "8i32nWJNyUcT5hZ5f4lkz542dGD2",
    'playerName': "Aybüke",
  },
  {
    'playerUid': "ATf4jdEuijXUpC0mUabY5sP3q3c2",
    'playerName': "Hüseyin",
  },
  {
    'playerUid': "AntyoZckMFZ2b74HQ7251wWwiNn2",
    'playerName': "Emirhan",
  },
  {
    'playerUid': "CZVnLYJolaWQXnSiuNXuL2PMMz02",
    'playerName': "Keremhan",
  },
  {
    'playerUid': "CevxTssggMa6GlAzBSx9j3Tyalk1",
    'playerName': "Samed",
  },
  {
    'playerUid': "F4HkslVK5ZNX6wFlGtjTaJSTsHj2",
    'playerName': "Rabia",
  },
  {
    'playerUid': "IPtojs6lt5VS97GQkaFebVFRL6o2",
    'playerName': "Eda",
  },
  {
    'playerUid': "O6e9PZH6W9UFNmjDBdDgariWiPQ2",
    'playerName': "Layan",
  },
  {
    'playerUid': "UwZE0Zmz2MMjssciSbeSGHwHInh2",
    'playerName': "Kerim",
  },
  {'playerUid': "VJqv5dT0s6TU6gzKBVKOORbUW152", 'playerName': "Damla"},
];

class GameContentMobile extends StatefulWidget {
  const GameContentMobile({super.key});

  @override
  State<GameContentMobile> createState() => _GameContentMobileState();
}

class _GameContentMobileState extends State<GameContentMobile>
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
        /* IconButton(
            onPressed: () {
              setState(() {
                var rndValue = Random();

                int daySayisi = rndValue.nextInt(150);

                int betValue = daySayisi * 86400000;

                var exampleRef =
                    FirebaseFirestore.instance.collection("bet_pool").doc();
                exampleRef.set({
                  "betAmount": betValue,
                  "playerName": exampleList[sira]['playerName'],
                  "playerUid": exampleList[sira]['playerUid'],
                  "playerPhoto":
                      "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
                  "betDate": DateTime.now(),
                  "targetGameNo": targetGameNo,
                });
                sira = sira + 1;
              });
            },
            icon: Icon(Icons.plus_one)),
       
       */
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
              return const Center(
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.requireData;

                    if (data.docs.isEmpty) {
                      return const CircularProgressIndicator();
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
                          ? const SizedBox()
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
                                  duration: const Duration(seconds: 8),
                                  curve: Curves.easeOutExpo),
                              selected: Stream.value(1),
                              items: widget.fortunePlayers);
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return const Center(
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
              return const Center(
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
                      : const SizedBox(),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget qrBoxBuild(String qrNo) {
    return Container(
      decoration: const BoxDecoration(
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
              fontFamily: "Roboto", fontSize: 17, fontWeight: FontWeight.w400),
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
                return const Center(
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final data = snapshot.requireData;

                      if (data.docs.isEmpty) {
                        return const SizedBox();
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
                      return const Center(
                        child: SizedBox(),
                      );
                    }
                  });
            } else {
              return const Center(
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
      textStyle: const TextStyle(
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
              style: const TextStyle(fontFamily: 'Roboto-Medium', fontSize: 22),
            )),
      )
    ]);
  }

  Widget noMoreBetBuild() {
    return Column(
      children: [
        qrGiftBoxBuild(),
        SizedBox(
          width: 3.w,
        ),
        Container(
          height: 60.sp,
          width: 60.sp,
          decoration: const BoxDecoration(
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
            return const Center(
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
                  Text(
                    'Daily Bonus: ${data.docs.first['gift_value']}',
                    style: const TextStyle(fontFamily: 'Roboto-Italic'),
                  ),
                  SizedBox(
                    height: 28.sp,
                    width: 28.sp,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

Widget playerGridBuild(List<PlayerModel> playerData) {
  playerData.sort((b, a) => a.betAmount.compareTo(b.betAmount));

  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 10.h, crossAxisCount: 3, childAspectRatio: 1.5),
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
                playerData[indeks].playerName,
                style: const TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              totalBetValue == null
                  ? Text("${playerData[indeks].betAmount / 86400000} Days",
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 11))
                  : Text(
                      "${((playerData[indeks].betAmount / 86400000) / (totalBetValue / 100)).toStringAsFixed(2)} %",
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 11))
            ],
          ),
        );
      });
}
