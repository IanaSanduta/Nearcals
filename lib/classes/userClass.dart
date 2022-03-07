import 'package:nearcals/classes/utility.dart';

class UserProfile {
  //Data members
  late String _userName;
  late String _email;
  late String _userImage;
  late int _dailyCals;
  late int _currentCals;

  //Default constructor
  UserProfile(){
    _userName = '';
    _email = '';
    _userImage = '';
    _dailyCals = 0;
    _currentCals = 0;
  }

  //Named constructor
  UserProfile.useMap(Map data){
    if(data.length == dbUser.values.length) {
      _userName = Utility.sentenceCase(data[dbUser.name.text]);
      _email = data[dbUser.email.text];
      _userImage =  data[dbUser.image.text];
      _dailyCals = data[dbUser.dailyCal.text];
      _currentCals =  data[dbUser.currentCal.text];
    }
    else{
       UserProfile();
    }
  }

  //Show info of the class
  @override
  String toString() {
    return " userName: $_userName \n userEmail: $_email \n userImage: $_userImage \n dailyCals: $_dailyCals \n currentCals: $_currentCals";
  }

  //Setters
  void setUserName(String un) {
    _userName = Utility.sentenceCase(un);
  }

  void setEmail(String e) {
    _email = e;
  }

  void setUserImage(String im) {
    _userImage = im;
  }

  void setDailyCals(int dc) {
    _dailyCals = dc;
  }

  void setCurrentCals(int cc) {
    _currentCals = cc;
  }

  //Getters
  String getUserName() {
    return _userName;
  }

  String getEmail() {
    return _email;
  }

  String getUserImage() {
    return _userImage;
  }

  int getDailyCals() {
    return _dailyCals;
  }

  int getCurrentCals() {
    return _currentCals;
  }

}

/// Database User's structure
enum dbUser {
  name,
  email,
  image,
  dailyCal,
  currentCal
}

///Associations Key and Values
extension NamesExtension on dbUser {
  String get text {
    switch (this) {
      case dbUser.name:
        return 'userName';
      case dbUser.email:
        return 'userEmail';
      case dbUser.image:
        return 'userImage';
      case dbUser.currentCal:
        return 'userCurrentCal';
      case dbUser.dailyCal:
        return 'userDailyCal';
      default:
        return '';
    }
  }
}
