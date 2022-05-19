class CardModel {
  String? question;
  Map<String, bool>? answer;
  CardModel(this.question, this.answer);
}

class CardModel2 {
  String? question;
  String? answer;
  List<String>? listAnswer;
  CardModel2(this.question, this.answer, this.listAnswer);
}
