import 'package:encrypt/encrypt.dart';

class EncryptionController {
  static final aesKey = 'mykey';

  static String encryptData(data) {
    final key = Key.fromUtf8(aesKey);
    final iv = IV.fromUtf8(aesKey);
    final aesEncrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = aesEncrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

// Decrypt data
  static String decryptData(final String encrypted) {
    final key = Key.fromUtf8(aesKey);
    final iv = IV.fromUtf8(aesKey);
    final aesEncrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final data = aesEncrypter.decrypt64(encrypted, iv: iv);
    return data;
  }
}
