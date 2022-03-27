class Quiz{
  final String image;
  final String answer;
  final List choice_list;

  Quiz({
    required this.image,
    required this.answer,
    required this.choice_list,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      image: json["image"],
      answer: json["answer"],
      choice_list: (json['choice_list'] as List).map((choice) => choice).toList() ,
    );
  }
}