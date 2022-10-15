// ignore_for_file: public_member_api_docs, sort_constructors_first

class Student {
  int? id;
  int? rollNo;
  String? name;
  Student({
    this.id,
    this.rollNo,
    this.name,
  });

  Student copyWith({
    int? id,
    int? rollNo,
    String? name,
  }) {
    return Student(
      id: id ?? this.id,
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'roll_no': rollNo,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, Object?> map) {
    return Student(
      id: map['id'] != null ? map['id'] as int : null,
      rollNo: map['roll_no'] != null ? map['roll_no'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  @override
  String toString() => 'Student(id: $id, rollNo: $rollNo, name: $name)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id && other.rollNo == rollNo && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ rollNo.hashCode ^ name.hashCode;
}
