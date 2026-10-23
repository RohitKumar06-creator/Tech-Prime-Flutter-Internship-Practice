import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedFirestoreData() async {
  final firestore = FirebaseFirestore.instance;

  // 1. Seed 10 Doctors
  final doctors = [
    {
      'name': 'Dr. Sarah Jenkins',
      'specialization': 'Cardiologist',
      'experience': '12 Years',
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=400',
      'hospital': 'City Heart Institute',
    },
    {
      'name': 'Dr. Marcus Vance',
      'specialization': 'Neurologist',
      'experience': '15 Years',
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=400',
      'hospital': 'Central Neuro Care',
    },
    {
      'name': 'Dr. Emily Alcott',
      'specialization': 'Pediatrician',
      'experience': '8 Years',
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1594824813566-78853a491f09?q=80&w=400',
      'hospital': 'Children Wellness Center',
    },
    {
      'name': 'Dr. Robert Chen',
      'specialization': 'Dermatologist',
      'experience': '10 Years',
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=400',
      'hospital': 'Skin & Aesthetic Clinic',
    },
    {
      'name': 'Dr. Sophia Martinez',
      'specialization': 'Orthopedic Surgeon',
      'experience': '14 Years',
      'rating': 4.9,
      'imageUrl': 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?q=80&w=400',
      'hospital': 'Bone & Joint Medical',
    },
    {
      'name': 'Dr. David Kim',
      'specialization': 'General Physician',
      'experience': '9 Years',
      'rating': 4.6,
      'imageUrl': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=400',
      'hospital': 'Community Primary Care',
    },
    {
      'name': 'Dr. Aisha Patel',
      'specialization': 'Gynecologist',
      'experience': '11 Years',
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?q=80&w=400',
      'hospital': 'Women Health Clinic',
    },
    {
      'name': 'Dr. James Wilson',
      'specialization': 'Psychiatrist',
      'experience': '13 Years',
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1527613426441-4da17471b66d?q=80&w=400',
      'hospital': 'Mind Care Center',
    },
    {
      'name': 'Dr. Olivia Taylor',
      'specialization': 'Ophthalmologist',
      'experience': '7 Years',
      'rating': 4.8,
      'imageUrl': 'https://images.unsplash.com/photo-1651008376811-b90baee60c1f?q=80&w=400',
      'hospital': 'Vision Care Institute',
    },
    {
      'name': 'Dr. Daniel Reynolds',
      'specialization': 'ENT Specialist',
      'experience': '10 Years',
      'rating': 4.7,
      'imageUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=400',
      'hospital': 'ENT Specialists Center',
    },
  ];

  for (var doc in doctors) {
    await firestore.collection('doctors').add(doc);
  }

  // 2. Seed Medicines
  final medicines = [
    {
      'name': 'Paracetamol 500mg',
      'category': 'Pain Relief & Fever',
      'price': 12.50,
      'imageUrl': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=400',
      'prescriptionRequired': false,
    },
    {
      'name': 'Amoxicillin 250mg',
      'category': 'Antibiotics',
      'price': 28.00,
      'imageUrl': 'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=400',
      'prescriptionRequired': true,
    },
    {
      'name': 'Vitamin C 1000mg',
      'category': 'Supplements',
      'price': 18.99,
      'imageUrl': 'https://images.unsplash.com/photo-1550572017-edd951aa8f72?q=80&w=400',
      'prescriptionRequired': false,
    },
    {
      'name': 'Ibuprofen 400mg',
      'category': 'Anti-inflammatory',
      'price': 15.00,
      'imageUrl': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=400',
      'prescriptionRequired': false,
    },
  ];

  for (var med in medicines) {
    await firestore.collection('medicines').add(med);
  }

  // 3. Seed Ambulance Providers
  final ambulances = [
    {
      'providerName': 'City Emergency Express',
      'type': 'Advanced Life Support (ALS)',
      'phone': '+1-800-555-0199',
      'eta': '8-12 mins',
      'isAvailable': true,
    },
    {
      'providerName': 'Red Cross Medical Response',
      'type': 'Basic Life Support (BLS)',
      'phone': '+1-800-555-0144',
      'eta': '5-8 mins',
      'isAvailable': true,
    },
  ];

  for (var amb in ambulances) {
    await firestore.collection('ambulances').add(amb);
  }
}
