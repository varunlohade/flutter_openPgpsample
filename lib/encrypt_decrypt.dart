import 'package:flutter/material.dart';
import 'package:openpgp/openpgp.dart';
import 'package:openpgpsample/button_widget.dart';
import 'package:openpgpsample/input_widget.dart';
import 'package:openpgpsample/title_widget.dart';

const passphrase = 'sample';

class EncryptAndDecrypt extends StatefulWidget {
  const EncryptAndDecrypt({
    Key? key,
    required this.title,
    required KeyPair? keyPair,
  })  : keyPair = keyPair,
        super(key: key);

  final KeyPair? keyPair;
  final String title;
  @override
  _EncryptAndDecryptState createState() => _EncryptAndDecryptState();
}

class _EncryptAndDecryptState extends State<EncryptAndDecrypt> {
  String _encrypted = "";
  String _decrypted = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            TitleWidget(widget.title),
            InputWidget(
                title: "Encrypt",
                key: Key("encrypt"),
                result: _encrypted,
                onPressed: (controller) async {
                  try {
                    var encrypted = await OpenPGP.encrypt(
                        controller.text, widget.keyPair!.publicKey);
                    setState(() {
                      _encrypted = encrypted;
                    });
                  } catch (e) {
                    print(e);
                  }
                }),
            ButtonWidget(
                result: _decrypted,
                title: "Decrypt",
                onPressed: () async {
                  var decrypted = await OpenPGP.decrypt(
                      _encrypted, widget.keyPair!.privateKey, passphrase);
                  setState(() {
                    _decrypted = decrypted;
                  });
                })
          ],
        ),
      ),
    );
  }
}
