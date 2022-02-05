import 'package:flutter/material.dart';
import 'package:openpgp/openpgp.dart';
import 'package:openpgpsample/encrypt_decrypt.dart';

void main() {
  runApp(const MyApp());
}

const passphrase = 'sample';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  KeyPair? _defaultKeyPair;

  @override
  void initState() {
    super.initState();
    initKeyPair();
  }

  Future<void> initKeyPair() async {
    var keyOptions = KeyOptions()..rsaBits = 1024;
    var keyPair = await OpenPGP.generate(
        options: Options()
          ..name = 'test'
          ..email = 'test@test.com'
          ..passphrase = passphrase
          ..keyOptions = keyOptions);

    setState(() {
      _defaultKeyPair = keyPair;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (_defaultKeyPair == null) {
      return Container();
    }
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("OpenPGP sample app"),

      ),
      body: ListView(key: Key('list'),
      children: [
        EncryptAndDecrypt(
              title: "Encrypt And Decrypt",
              keyPair: _defaultKeyPair,
              key: Key("encrypt-decrypt"),
            ),
      ],
      ),
    ));
  }
}
