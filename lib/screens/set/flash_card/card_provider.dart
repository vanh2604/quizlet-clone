
import 'dart:math';

import 'package:flutter/material.dart';

enum CardStatus{like, dislike}

class CardProvider extends ChangeNotifier {
  List<String> urlImages = [];
  bool isDragging =  false;
  double angle = 0;
  Offset _position = Offset.zero;
  Offset get position => _position;
  Size _screenSize = Size.zero;
  int totalCard = 0;
  int understandCount = 0;
  int dontUnderstandCount = 0;
  bool isListEmpty = false;
  CardProvider() {
    resetList();
  }

  void resetList() {
    urlImages = <String>[
      "img/gri.jpeg",
      // "img/img_1.jpeg",
      // "img/img_2.jpeg",
      // "img/img_3.jpeg",
      // "img/img_4.jpeg",
      // "img/img_5.jpeg",
      // "img/img_6.jpeg",
      // "img/img_7.jpeg",
      // "img/img_8.jpeg",
      // "img/img_9.jpeg",
      // "img/img_10.jpeg",
      // "img/img_11.jpeg",
      // "img/img_12.jpeg",
      // "img/img_13.jpeg",
      "img/img_14.jpeg",
      "img/img_15.jpeg",
      "img/img_16.jpeg",
      ""
    ].reversed.toList();
    totalCard = urlImages.length;
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
    _position+=Offset(2*_screenSize.width/2,0);
    if(urlImages.isEmpty) {
      isListEmpty = true;}
    _nextCard();
    understandCount++;
    notifyListeners();
  }

  void dislike() {
    angle = -20;
    _position -= Offset(2*_screenSize.width,0);
    if(urlImages.isEmpty) {
      isListEmpty = true;}
    _nextCard();
    dontUnderstandCount++;
    notifyListeners();
  }

  Future _nextCard() async {
    if(urlImages.isEmpty) {
      isListEmpty = true;
      return;
    }
      await Future.delayed(const Duration(milliseconds:  100));
      urlImages.removeLast();
      resetPosition();
  }

  int getCurrentNumberOfCard() {
    return urlImages.length;
  }

  int getOrderCurrentIndexCard() {
    return  totalCard-getCurrentNumberOfCard();
  }

  bool isEmptyListData() {
    return urlImages.length == 1 || urlImages.isEmpty;
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(),_position.dy.abs());
    final opacity = pos/delta;
    return min(opacity,1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    if (force) {
      final delta = 100;
      if (x>=delta) {
        return CardStatus.like;
      } else if(x<=-delta) {
        return CardStatus.dislike;
      }
    } else {
      final delta = 20;
      if (x>=delta) {
        return CardStatus.like;
      } else if (x<=-delta) {
        return CardStatus.dislike;
      }
    }

  }

  void resetPosition() {
    isDragging =false;
    _position = Offset.zero;
    angle = 0;
    notifyListeners();
  }

  void setScreenSize(Size screenSize) {
    _screenSize = screenSize;
  }
}