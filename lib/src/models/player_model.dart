class PlayerModel {
  late String playerName;
  late String playerPhoto;
  late int betAmount;

  PlayerModel(
      this.playerName,
       this.playerPhoto,
  this.betAmount);

  PlayerModel.fromJson(Map<String, dynamic> json)
      : this(
          json["playerName"] as String,
          json["playerPhoto"] as String,
          json["betAmount"] as int,
   
        );

  Map<String, dynamic> toJson() {
    return {
      "playerName": playerName,
      "playerPhoto": playerPhoto,
      "betAmount": betAmount,
   
    };
  }
}
