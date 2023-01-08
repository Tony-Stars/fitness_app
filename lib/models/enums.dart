import "package:flutter/material.dart";

enum Specification {
  body,
  press,
  arms,
  legs,
  back,
  breast;

  @override
  String toString() {
    switch (this) {
      case Specification.body:
        return "Всё тело";
      case Specification.press:
        return "Пресс";
      case Specification.arms:
        return "Руки";
      case Specification.legs:
        return "Ноги";
      case Specification.back:
        return "Спина";
      case Specification.breast:
        return "Грудь";
    }
  }
}

enum Complexity {
  easy,
  medium,
  hard;

  Color get color {
    switch (this) {
      case Complexity.easy:
        return Colors.green;
      case Complexity.medium:
        return Colors.yellow;
      case Complexity.hard:
        return Colors.red;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Complexity.easy:
        return "Легко";
      case Complexity.medium:
        return "Средне";
      case Complexity.hard:
        return "Сложно";
    }
  }
}
