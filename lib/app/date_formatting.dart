import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Fungsi untuk memformat tanggal dari string ke format yang diinginkan.
///
/// Contoh string input yang diterima (ISO-8601):
/// - "2012-02-27"
/// - "2012-02-27 13:27:00"
/// - "2012-02-27T14+00:00"
///
/// Jika format input berbeda, gunakan parameter [fromFormat] untuk menyesuaikan format.
///
/// [dateString] : String tanggal input.
/// [fromFormat] : Format input (opsional, default ISO-8601).
/// [toFormat] : Format output yang diinginkan (wajib diisi).

///
/// Jika parsing gagal, fungsi akan mengembalikan string input tanpa perubahan.
String formatDateString(
  String dateString, {
  String fromFormat = "",
  required String toFormat,
}) {
  try {
    // Parsing string ke DateTime berdasarkan format input
    DateTime parsedDate;
    if (fromFormat.isEmpty) {
      // Jika tidak ada format input, gunakan parsing default (ISO-8601)
      parsedDate = DateTime.parse(dateString);
    } else {
      // Parsing dengan format input khusus
      parsedDate = DateFormat(fromFormat).parse(dateString);
    }

    // Format DateTime ke string output berdasarkan format yang diinginkan
    return DateFormat(toFormat).format(parsedDate);
  } catch (e) {
    // Jika parsing gagal, kembalikan string input
    debugPrint("Error parsing date: $e");
    return dateString;
  }
}

String formatCurrency(num value) {
  return "Rp ${NumberFormat('#,###', 'id_ID').format(value)}";
}

String timeAgo(String isoDateString) {
  final date = DateTime.parse(isoDateString).toLocal();
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} detik yang lalu';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} menit yang lalu';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} jam yang lalu';
  } else if (diff.inDays < 7) {
    return '${diff.inDays} hari yang lalu';
  } else if (diff.inDays < 30) {
    return '${(diff.inDays / 7).floor()} minggu yang lalu';
  } else if (diff.inDays < 365) {
    return '${(diff.inDays / 30).floor()} bulan yang lalu';
  } else {
    return '${(diff.inDays / 365).floor()} tahun yang lalu';
  }
}
