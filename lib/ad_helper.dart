import 'dart:io';



class AdHelper {
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-1350298554996047/6860892719";
    }else if(Platform.isIOS){
      return "ca-app-pub-1350298554996047/6860892719";
    }else{
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get RewardedAd{
    if(Platform.isAndroid){
      return "ca-app-pub-1350298554996047/5154156852";
    }else if(Platform.isIOS){
      return "ca-app-pub-1350298554996047/5154156852";
    }else{
      throw new UnsupportedError("Unsupported platform");
    }
  }
}