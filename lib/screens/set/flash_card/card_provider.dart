import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizlet/data/fake_data.dart';

import '../../../model/card_model.dart';

enum CardStatus { like, dislike }

class CardProvider extends ChangeNotifier {
  List<CardModel2> listQuestion=[];
  bool isDragging = false;
  double angle = 0;
  Offset _position = Offset.zero;
  Offset get position => _position;
  Size _screenSize = Size.zero;
  int totalCard = 0;
  int understandCount = 0;
  int dontUnderstandCount = 0;
  bool isListEmpty = false;
  bool isStarted= false;
  CardProvider() {
    resetList();
  }

  void setListQuestion(List <CardModel2> question) {
    if(!isStarted) {
      listQuestion = question.reversed.toList();
      totalCard = listQuestion.length;
    }
    isStarted = true;
  }

  void resetList() {
    //listQuestion = question2s.reversed.toList();
    totalCard = listQuestion.length;
    understandCount = 0;
    dontUnderstandCount = 0;
    notifyListeners();
  }

  void startPosition(DragStartDetails details) {
    isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition() {
    isDragging = false;
    notifyListeners();
    final status = getStatus(force: true);
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void like() {
    angle = 20;
    _position += Offset(2 * _screenSize.width / 2, 0);
    if (listQuestion.isEmpty) {
      isListEmpty = true;
    }
    _nextCard();
    understandCount++;
    notifyListeners();
  }

  void dislike() {
    angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    if (listQuestion.isEmpty) {
      isListEmpty = true;
    }
    _nextCard();
    dontUnderstandCount++;
    notifyListeners();
  }

  Future _nextCard() async {
    if (listQuestion.isEmpty) {
      isListEmpty = true;
      return;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    listQuestion.removeLast();
    resetPosition();
  }

  int getCurrentNumberOfCard() {
    return listQuestion.length;
  }

  int getOrderCurrentIndexCard() {
    return totalCard - getCurrentNumberOfCard();
  }

  bool isEmptyListData() {
    return listQuestion.length == 1 || listQuestion.isEmpty;
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;
    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    if (force) {
      const delta = 100;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    } else {
      const delta = 20;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    }
    return null;
  }

  void resetPosition() {
    isDragging = false;
    _position = Offset.zero;
    angle = 0;
    notifyListeners();
  }

  void setScreenSize(Size screenSize) {
    _screenSize = screenSize;
  }
}
