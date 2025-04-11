import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Data/Doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class Database {
  Future create(String email, String name) async {
    final doc = FirebaseFirestore.instance.collection('Patient').doc(email);
    return await doc.set({
      'name': name,
      'email': email,
      'dob': "01/01/2000",
      'dpw': 0,
      'gender': "none",
      'height': 0,
      'weight': 0,
      'mpd': 0,
      'img':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgB730p0ChSl_CNr5N6n05AGzEtEAhFypOFg&usqp=CAU",
    });
  }

  Future read(String email) async {
    final doc = FirebaseFirestore.instance.collection('Patient').doc(email);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      UserProfileData.name = snapshot['name'];
      UserProfileData.email = snapshot['email'];
      UserProfileData.imgUrl = snapshot['img'];
      UserProfileData.aboutVal.addAll({
        0: snapshot['gender'],
        1: snapshot['dob'],
        2: snapshot['height'],
        3: snapshot['weight'],
      });
      UserProfileData.otherVal.addAll({
        0: snapshot['mpd'],
        1: snapshot['dpw'],
        2: "10:00 pm",
        3: "06:00 am"
      });
      print(snapshot);
    }
  }

  Future update(
    String name,
    String email,
    String gender,
    String dob,
    int height,
    int weight,
    int mpd,
    int dpw,
  ) async {
    print("x");
    FirebaseFirestore.instance.collection('Patient').doc(email).set({
      'name': name,
      'email': email,
      'gender': gender,
      'dob': dob,
      'height': height,
      'weight': weight,
      'mpd': mpd,
      'dpw': dpw,
      'img': UserProfileData.imgUrl,
    });
    print("done");
  }

  Future<void> getDocList() async {
    FirebaseFirestore.instance.collection('Doctor').get().then((value) {
      for (var docSnap in value.docs) { 
        Doctor.DocList.add(docSnap.data());
        Doctor.DocNameList.add(docSnap['name']);
      }
    });
  }
}

class Disease {
  static final Map<String, Map<String, dynamic>> _localData = {
    'Acne': {
      'name': 'Acne',
      'over': 'Acne is a common skin condition...',
      'img': 'assets/images/acne.jpg',
      'symp': ['Pimples', 'Blackheads', 'Whiteheads'],
      'images': [
        'assets/images/acne_1.jpg',
        'assets/images/acne_2.jpg',
      ],
      
    },
    'Eczema': {
      'name': 'Eczema',
      'img': 'assets/images/ECZEMA.jpg',
      'over':
          'Eczema (atopic dermatitis) is a condition that makes your skin red and itchy. It\'s common in children but can occur at any age, often appearing as patches of dry, scaly skin.',
      'symp': [
        'Dry, sensitive skin',
        'Red, inflamed patches',
        'Severe itching',
      ],
      'images': [
        'assets/images/eczema_1.jpg',
        'assets/images/eczema_2.jpeg',
        'assets/images/eczema_3.jpg'
      ],
    },
    'Rosacea': {
      'name': 'Rosacea',
      'img': 'assets/images/ROSACEA.jpg',
      'over': 'Chronic facial redness and visible blood vessels.',
      'symp': [
        'Facial redness',
        'Swollen bumps',
        'Eye irritation',
        'Thickened skin'
      ],
      'images': ['assets/images/rosacea_1.jpg', 'assets/images/rosacea_2.jpg'],
    },
    'Hives': {
      'name': 'Hives',
      'img': 'assets/images/HIVES.jpg',
      'over': 'Raised, itchy welts triggered by allergic reactions.',
      'symp': ['Raised welts', 'Itching', 'Burning sensation', 'Swelling'],
      'images': ['assets/images/hives_1.jpg', 'assets/images/hives_2.jpg'],
    },
    'Vitiligo': {
      'name': 'Vitiligo',
      'img': 'assets/images/VITILIGO.jpg',
      'over': 'Loss of skin pigment causing white patches.',
      'symp': [
        'Patchy skin color loss',
        'Premature whitening of hair',
        'Mucous membrane discoloration'
      ],
      'images': [
        'assets/images/vitiligo_1.jpg',
        'assets/images/vitiligo_2.jpeg'
      ],
    },
    'Psoriasis': {
      'name': 'Psoriasis',
      'img': 'assets/images/Psoriasis.JPG',
      'over': 'Autoimmune condition causing rapid skin cell buildup.',
      'symp': [
        'Red patches',
        'Silvery scales',
        'Dry cracked skin',
        'Itching/burning'
      ],
      'images': [
        'assets/images/psoriasis_1.jpg',
        'assets/images/psoriasis_2.jpg'
      ],
      'treatments': [
        'Topical steroids',
        'Light therapy',
        'Systemic medications'
      ]
    },
  };

  // Fetch data from Firebase or return hardcoded data
  Future<Map<String, dynamic>> read(String name) async {
    return _localData[name] ??
        {
          'name': name,
        };
  }

  Future<void> uploadAssetToFirebase() async {
    try {
      // Load asset image as bytes
      final byteData = await rootBundle.load('assets/images/download (7).jpg');
      final Uint8List bytes = byteData.buffer.asUint8List();

      // Define path in Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('acne_asset_${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload as Uint8List
      final uploadTask = await ref.putData(bytes);

      // Get download URL
      final url = await ref.getDownloadURL();

      print('Image uploaded from assets! URL: $url');
    } catch (e) {
      print('Upload error: $e');
    }
  }
  // Future read(String name) async {
      
    
  //   final doc = FirebaseFirestore.instance.collection('Disease').doc('Acne');
  //   final snapshot = await doc.get();
  //   if (snapshot.exists) {
  //     return snapshot;
  //   } else {
  //     return null;
  //   }
  // }
}
