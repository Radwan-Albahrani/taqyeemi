// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum FlashCardStatus { notStarted, notCompleted, completed }

extension FlashCardStatusX on FlashCardStatus {
  static Map<String, dynamic> toMap(status) {
    return <String, dynamic>{
      'status': status.toString().split('.').last,
    };
  }



  static FlashCardStatus fromMap(Map<String, dynamic> map) {
    return FlashCardStatusX.fromString(map['status'] as String);
  }

  static FlashCardStatus fromString(String status) {
    switch (status) {
      case 'notStarted':
        return FlashCardStatus.notStarted;
      case 'notCompleted':
        return FlashCardStatus.notCompleted;
      case 'completed':
        return FlashCardStatus.completed;
      default:
        throw Exception('Invalid status');
    }
  }

}

class FlashCard {
  final String id;
  final String term;
  final String definition;
  final FlashCardStatus status;
  FlashCard({
    required this.id,
    required this.term,
    required this.definition,
    required this.status,
  });
  

  FlashCard copyWith({
    String? id,
    String? term,
    String? definition,
    FlashCardStatus? status,
  }) {
    return FlashCard(
      id: id ?? this.id,
      term: term ?? this.term,
      definition: definition ?? this.definition,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'term': term,
      'definition': definition,
      'status': FlashCardStatusX.toMap(status),
    };
  }

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      id: map['id'] as String,
      term: map['term'] as String,
      definition: map['definition'] as String,
      status: FlashCardStatusX.fromMap(map['status'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashCard.fromJson(String source) => FlashCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FlashCard(id: $id, term: $term, definition: $definition, status: $status)';
  }

  @override
  bool operator ==(covariant FlashCard other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.term == term &&
      other.definition == definition &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      term.hashCode ^
      definition.hashCode ^
      status.hashCode;
  }
}
