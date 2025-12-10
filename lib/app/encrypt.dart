// import 'package:hive/hive.dart';
// import 'package:karyaone_mobile/enums/qr_code_type.dart';
// import 'package:karyaone_mobile/models/device_identifier.dart';
// import 'package:karyaone_mobile/util/const.dart';
// import 'package:karyaone_mobile/util/device_info_util.dart';
// import 'package:package_info/package_info.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;

// class DeviceIdentifierUtil {
//   static final DeviceIdentifierUtil _deviceIdentifierUtil =
//       DeviceIdentifierUtil._internal();
//   factory DeviceIdentifierUtil() {
//     return _deviceIdentifierUtil;
//   }
//   DeviceIdentifierUtil._internal();

//   Future<DeviceIdentifier> get deviceIdentifier async {
//     var _userpreferences = Hive.box("userpreferences");
//     var _qrCodeType = _userpreferences.get("QrCodeType", defaultValue: null);
//     if (_qrCodeType == null) {
//       // fresh install
//       // Update on 2020/07/28 default is UUID
//       // var sdkVersion = await DeviceInfoUtil().getAndroidSdkVersion();
//       // _qrCodeType = QrCodeType.IMEI;
//       // if (sdkVersion >= 29) {
//       _qrCodeType = QrCodeType.UniqueId;
//       // }

//       _userpreferences.put("QrCodeType", _qrCodeType);
//     }

//     String value = "";
//     switch (_qrCodeType) {
//       case QrCodeType.IMEI:
//         value = await DeviceInfoUtil().getImei();
//         break;
//       default:
//         value = await DeviceInfoUtil().getUniqueId();
//         break;
//     }
    
//     print('get user identifier on: ${DateTime.now()}');

//     return DeviceIdentifier(
//       qrCodeType: _qrCodeType,
//       value: value,
//       encryptedCode: await encryptQrCode(value),
//     );
//   }

//   Future<String> encryptQrCode(String value) async {
//     var now = DateTime.now().toUtc().add(Duration(hours: 7));
//     // print(now);
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();

//     var text =
//         "$value;${now.day}-${now.month}-${now.year};${now.hour};${packageInfo.version}+${packageInfo.buildNumber}";

//     final key = encrypt.Key.fromUtf8(Constants.qrCodeAesKey);
//     final iv = encrypt.IV.fromUtf8(Constants.qrCodeAesIv);
//     final encrypter =
//         encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
//     return encrypter.encrypt(text, iv: iv).base64;
//   }
// }
