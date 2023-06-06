
class Division {
   String id;
   String division;
   String estateId;

  Division({
    required this.id,
    required this.division,
    required this.estateId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_division': id,
      'division': division,
      'id_estate': estateId,
    };
  }

  factory Division.fromMap(Map<String, dynamic> map) {
    return Division(
      id: map['id_division'],
      division: map['division'],
      estateId: map['id_estate']
    );
  }
   factory Division.fromJson(Map<String, dynamic> json) {
     return Division(
         id      : json['id_division'],
         division: json['division'],
         estateId: json['id_estate']

     );
   }

}
