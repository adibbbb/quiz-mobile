import 'package:cloud_firestore/cloud_firestore.dart';

var questionsRaw = {
  "level1": [
    {
      "question": "Lambang sila pertama Pancasila adalah…",
      "options": ["Padi dan kapas", "Bintang", "Pohon beringin"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "Sikap menghargai teman saat berbicara adalah dengan cara…",
      "options": [
        "Memotong pembicaraan",
        "Mendengarkan dengan baik",
        "Pergi begitu saja",
      ],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Contoh perilaku gotong royong adalah…",
      "options": [
        "Bermain sendiri",
        "Membersihkan kelas bersama",
        "Berteriak pada teman",
      ],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Sila ketiga berbunyi…",
      "options": [
        "Persatuan Indonesia",
        "Ketuhanan Yang Maha Esa",
        "Kemanusiaan yang Adil dan Beradab",
      ],
      "correctAnswer": 2,
      "score": 5,
    },
    {
      "question": "Menjaga kebersihan kelas adalah tanggung jawab…",
      "options": ["Guru saja", "Semua siswa", "Ketua kelas saja"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question":
          "Menghargai perbedaan agama termasuk sikap yang sesuai dengan sila…",
      "options": ["Pertama", "Keempat", "Kelima"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Saat rapat kelas, kita harus…",
      "options": [
        "Berebut bicara",
        "Mendengarkan pendapat teman",
        "Pulang duluan",
      ],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Sikap adil berarti…",
      "options": [
        "Memilih teman favorit saja",
        "Memberi kesempatan sama pada semua",
        "Tidak mau berbagi",
      ],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Sila kelima berbunyi…",
      "options": [
        "Keadilan sosial bagi seluruh rakyat Indonesia",
        "Kerakyatan yang dipimpin oleh hikmat kebijaksanaan",
        "Persatuan Indonesia",
      ],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "Contoh bekerja sama di rumah adalah…",
      "options": [
        "Mencuci piring bersama",
        "Menonton TV saja",
        "Tidur siang terus",
      ],
      "correctAnswer": 0,
      "score": 5,
    },
  ],

  "level2": [
    {
      "question": "Kegiatan yang dilakukan untuk memenuhi kebutuhan disebut…",
      "options": ["Hiburan", "Pekerjaan", "Permainan"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Contoh pekerjaan di sekolah adalah…",
      "options": ["Pedagang", "Guru", "Petani"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Lingkungan rumah disebut juga…",
      "options": ["Lingkungan keluarga", "Lingkungan desa", "Lingkungan kota"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "Pasar adalah tempat untuk…",
      "options": ["Bermain", "Menjual dan membeli barang", "Berolahraga"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Transportasi darat adalah…",
      "options": ["Pesawat", "Kapal", "Mobil"],
      "correctAnswer": 2,
      "score": 5,
    },
    {
      "question": "Yang termasuk benda kebutuhan sehari-hari adalah…",
      "options": ["Laptop mewah", "Makanan", "Patung"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Sungai adalah contoh lingkungan…",
      "options": ["Buatan", "Alam", "Pasar"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Pekerjaan nelayan dilakukan di…",
      "options": ["Gunung", "Laut", "Kebun"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Rumah sakit adalah tempat untuk…",
      "options": ["Berbelanja", "Berobat", "Menonton film"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Alat pembayaran yang sering digunakan adalah…",
      "options": ["Batu", "Uang", "Daun"],
      "correctAnswer": 1,
      "score": 5,
    },
  ],

  "level3": [
    {
      "question": "15 + 7 = …",
      "options": ["20", "22", "18"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "30 – 12 = …",
      "options": ["18", "20", "15"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "5 × 4 = …",
      "options": ["20", "15", "25"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "24 ÷ 6 = …",
      "options": ["5", "4", "3"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Nilai tempat angka 5 pada bilangan 354 adalah…",
      "options": ["Satuan", "Puluhan", "Ratusan"],
      "correctAnswer": 2,
      "score": 5,
    },
    {
      "question": "100 – 43 = …",
      "options": ["47", "57", "63"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Pola bilangan: 2, 4, 6, 8, …",
      "options": ["10", "12", "7"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "Hasil dari 12 + 13 = …",
      "options": ["25", "23", "22"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "Bilangan genap adalah…",
      "options": ["11", "15", "16"],
      "correctAnswer": 2,
      "score": 5,
    },
    {
      "question": "Bentuk uang pecahan adalah…",
      "options": ["Meja", "Rp 1.000", "Ayunan"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Bangun datar yang memiliki 3 sisi adalah…",
      "options": ["Segitiga", "Persegi", "Lingkaran"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "9 × 3 = …",
      "options": ["27", "21", "18"],
      "correctAnswer": 0,
      "score": 5,
    },
    {
      "question": "50 + 25 = …",
      "options": ["65", "70", "75"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "48 ÷ 8 = …",
      "options": ["6", "8", "5"],
      "correctAnswer": 1,
      "score": 5,
    },
    {
      "question": "Ketinggian 120 cm sama dengan…",
      "options": ["1 m 20 cm", "2 m", "20 cm"],
      "correctAnswer": 0,
      "score": 5,
    },
  ],
};

void pushInjectQuestion() async {
  final firestore = FirebaseFirestore.instance;

  // Collection tujuan
  final questionsCollection = firestore
      .collection('quizzes') // collection utama
      .doc('quiz_1') // document quiz_1
      .collection('questions'); // subcollection questions

  // Bisa juga langsung firestore.collection('quiz_1/questions') kalau pakai slash

  // 3️⃣ Mapping level ke quiz doc
  final levelToQuizDoc = {
    'level1': 'quiz_1',
    'level2': 'quiz_2',
    'level3': 'quiz_3',
  };

  for (var levelKey in ['level1', 'level2', 'level3']) {
    final quizId = levelToQuizDoc[levelKey];
    final questions = questionsRaw[levelKey] as List<dynamic>;

    final questionsCollection = firestore
        .collection('quizzes')
        .doc(quizId)
        .collection('questions');

    for (var q in questions) {
      await questionsCollection.add({
        'question': q['question'],
        'options': (q['options'] as List<dynamic>).cast<String>(),
        'correctAnswer': q['correctAnswer'],
        'score': q['score'],
      });

      print(
        "Level $levelKey: soal '${q['question']}' berhasil ditambahkan ke $quizId",
      );
    }
  }

  print("Semua soal Level 1–3 berhasil diupload!");
}
