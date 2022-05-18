import 'package:quizlet/model/card_model.dart';

List<CardModel> questions = [
  CardModel(
    "How Many Whiskers does the average cat have on each side of its face ?",
    {
      "1": false,
      "3": false,
      "12": true,
      "5,007": false,
    },
  ),
  CardModel("When does a cat purr ?", {
    "When it cares for its kittens": false,
    "When it needs confort": false,
    "When it feels content": false,
    "All of the above": true,
  }),
  CardModel("What is the averge nulber of kittens in a litter ?", {
    "1 to 2": false,
    "3 to 5": true,
    "8 to 10": false,
    "12 to 14": false,
  }),
  CardModel("How many moons does Mars have ?", {
    "1": false,
    "2": false,
    "4": true,
    "8": false,
  }),
  CardModel("What is Mars's nickname ?", {
    "The red planet": true,
    "The dusty planet": false,
    "The hot planet": false,
    "The smelly planet": false,
  }),
  CardModel("About How long would it take to travel to Mars ?", {
    "Three days": false,
    "A month": false,
    "Eight months": true,
    "Two years": false,
  }),
  CardModel("Mars is Named after the Roman god Mars. What is he the god of ?", {
    "Fire": false,
    "Love": false,
    "Agriculture": false,
    "War": true,
  }),
  CardModel("Mars Is the ___ planet from the sun ?", {
    "Second": false,
    "Third": false,
    "Fourth": true,
    "Sixth": false,
  }),
  CardModel(
      "Where did Orville and Wilbur Wright build their first flying airplane ?",
      {
        "Paris, France": false,
        "Boston, Massachusetts": false,
        "Kitty Hawk, North Carolina": true,
        "Tokyou, Japan": false,
      }),
  CardModel(
      "The First astronuts to travel to space came from which country ?", {
    "United States": false,
    "Soviet Union (now Russia)": true,
    "China": false,
    "Rocketonia": false,
  }),
];
