import 'package:flutter/material.dart';

class Answer{
  final String answer;
  final String image;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Answer({
    @required this.answer,
    @required this.image,
  });

  Answer copyWith({
    String answer,
    String image,
  }) {
    if ((answer == null || identical(answer, this.answer)) &&
        (image == null || identical(image, this.image))) {
      return this;
    }

    return new Answer(
      answer: answer ?? this.answer,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Answer{answer: $answer, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Answer &&
          runtimeType == other.runtimeType &&
          answer == other.answer &&
          image == other.image);

  @override
  int get hashCode => answer.hashCode ^ image.hashCode;

  factory Answer.fromMap(Map<String, dynamic> map) {
    return new Answer(
      answer: map['answer'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'answer': this.answer,
      'image': this.image,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}