import 'dart:ffi';

import '../constants/color_constant.dart';

class CardModel{
  final String user;
  final String cardNumber;
  final String cardExpired;
  final String cardType;
  final int cardBackground;
  final String cardElementTop;
  final String cardElementBottom;

  CardModel(this.user,  this.cardNumber,  this.cardExpired,  this.cardType,  this.cardBackground,  this.cardElementTop,  this.cardElementBottom);
}

List<CardModel> cards = cardData.map(
    (item) => CardModel(
      item['user'] as String,
      item['cardNumber'] as String,
      item['cardExpired'] as String,
      item['cardType'] as String,
      item['cardBackground'] as int,
      item['cardElementTop'] as String,
      item['cardElementBottom'] as String,
    ),
).toList();

var cardData = [
  {
    "user" :"Rakibul Islam",
    "cardNumber" : "**** **** **** 8767",
    "cardExpired" : "04-05-2023",
    "cardType" : "assets/svg/credit-card.svg",
    "cardBackground" : 0xFF009688,
    "cardElementTop" : "assets/svg/top.svg",
    "cardElementBottom" : "assets/svg/bottom.svg"
  },
  {
    "user" :"Name Here",
    "cardNumber" : "**** **** **** 2434",
    "cardExpired" : "04-05-2023",
    "cardType" : "assets/svg/credit-card.svg",
    "cardBackground" : 0xFFFF70A6,
    "cardElementTop" : "assets/svg/top.svg",
    "cardElementBottom" : "assets/svg/bottom.svg"
  },
  {
    "user" :"Another Name",
    "cardNumber" : "**** **** **** 8090",
    "cardExpired" : "04-05-2023",
    "cardType" : "assets/svg/credit-card.svg",
    "cardBackground" : 0xFF009688,
    "cardElementTop" : "assets/svg/top.svg",
    "cardElementBottom" : "assets/svg/bottom.svg"
  }
];