class StepInfoModel {
  StepInfoModel({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  StepInfoModel copyWith({
    String? title,
    String? description,
  }) =>
      StepInfoModel(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory StepInfoModel.fromJson(Map<String, dynamic> json) => StepInfoModel(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
