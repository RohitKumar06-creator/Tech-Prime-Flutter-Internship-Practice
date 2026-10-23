class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String experience;
  final String? imageUrl;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    this.imageUrl,
  });

  // Factory constructor to deserialize Firestore documents later
  factory DoctorModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DoctorModel(
      id: documentId,
      name: map['name'] ?? '',
      specialization: map['specialization'] ?? '',
      experience: map['experience'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  // Convert to Map for uploading to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialization': specialization,
      'experience': experience,
      'imageUrl': imageUrl,
    };
  }
}
