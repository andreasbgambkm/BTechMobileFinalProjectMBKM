
class Estate {
  String id;
  String estate;

  Estate({
    required this.id,
    required this.estate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_estate': id,
      'estate': estate,
    };
  }
  static Estate fromMap(Map<String, dynamic> map) {
    return Estate(
      id: map['id_estate'],
        estate: map['estate']

    );
  }


  factory Estate.fromJson(Map<String, dynamic> json) {
    return Estate(
        id: json['id_estate'],
        estate: json['estate']

    );
  }
}
