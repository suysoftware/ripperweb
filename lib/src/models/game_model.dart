
class GameModel {
  late String gameNo;
  late dynamic gameWinner;
  late String gameQr;
  late int gameDate;
  late int gameTotalBet;
  late bool gameFinish;
  late bool rollWheel;
  late bool betFinish;
  late List<dynamic> playerList;
  late int betFinishDate;
  late int rollTime;
  late int newGameDate;

  GameModel(
      this.gameNo,
      this.gameWinner,
      this.gameQr,
      this.gameDate,
      this.gameTotalBet,
      this.gameFinish,
      this.rollWheel,
      this.betFinish,
      this.playerList,
      this.betFinishDate,
      this.rollTime,
      this.newGameDate);

  GameModel.fromJson(Map<String, dynamic> json)
      : this(
          json["gameNo"] as String,
          json["gameWinner"] as dynamic,
          json["gameQr"] as String,
          json["gameDate"] as int,
          json["gameTotalBet"] as int,
          json["gameFinish"] as bool,
          json["rollWheel"] as bool,
          json["betFinish"] as bool,
          json["playerList"] as List<dynamic>,
          json["betFinishDate"] as int,
          json["rollTime"] as int,
          json["newGameDate"] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      "gameNo": gameNo,
      "gameWinner": gameWinner,
      "gameQr": gameQr,
      "gameDate": gameDate,
      "gameTotalBet": gameTotalBet,
      "gameFinish": gameFinish,
      "rollWheel": rollWheel,
      "betFinish": betFinish,
      "playerList": playerList,
      "betFinishDate": betFinishDate,
      "rollTime": rollTime,
      "newGameDate": newGameDate
    };
  }
}
