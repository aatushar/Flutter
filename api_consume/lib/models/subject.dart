class Subject {
  final int subjectId;
  final String image;
  final String subjectName;

  Subject({
    required this.subjectId,
    required this.image,
    required this.subjectName,
  });

  // Factory method to create a Subject instance from a JSON object
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subjectId'],
      image: json['image'],
      subjectName: json['subjectName'],
    );
  }
}
