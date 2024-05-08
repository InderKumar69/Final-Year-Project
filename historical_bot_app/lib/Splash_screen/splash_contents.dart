// Created clas for splash screen content
// we declare String Datatype and Image, Title, Description Variable
class SplashContents {
  String image;
  String title;
  String description;

  SplashContents(
      {required this.image, required this.title, required this.description});
}

// Array of Splash Screen Content for declaring Array In Flutter we declare List as a Array
// In Flutter Array name is List
List<SplashContents> contents = [
  // All This Splash Screen content will declare through i Variable
  SplashContents(
      title: 'Choose Your Location',
      image: 'assets/map1.png',
      description: "In This App you can easily"
          " Navigate and Reach "
          "to your Destiny"),
  SplashContents(
      title: 'AR Guide Bot',
      image: 'assets/robot2.png',
      description: "AR (Augmented Reality) Bot"
          "will guide you and tell you"
          "the History of different Cities"
          "of Pakistan"),
  SplashContents(
      title: 'Quality Voice & Message',
      image: 'assets/vm.png',
      description: "In this app bot"
          "will tell you the history "
          "through Voice and Message"),
];
