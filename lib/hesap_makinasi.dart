import 'package:flutter/material.dart';

class HesapMakinasi extends StatefulWidget {
  const HesapMakinasi({super.key});

  @override
  State<HesapMakinasi> createState() => _HesapMakinasiState();
}

class _HesapMakinasiState extends State<HesapMakinasi> {
  String output = '';
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        output = '';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        if (output.isNotEmpty) {
          num1 = double.tryParse(output) ?? 0;
          operator = buttonText;
          output += buttonText; // Operatörü ekrana ekle
        }
      } else if (buttonText == '=') {
        if (operator.isNotEmpty) {
          List<String> parts = output.split(RegExp(r'[+\-*/]'));
          if (parts.length == 2) {
            num2 = double.tryParse(parts.last) ?? 0;
            switch (operator) {
              case '+':
                output = (num1 + num2).toString();
                break;
              case '-':
                output = (num1 - num2).toString();
                break;
              case '*':
                output = (num1 * num2).toString();
                break;
              case '/':
                output = (num2 != 0) ? (num1 / num2).toString() : 'Hata';
                break;
            }
            operator = ''; // İşlem sonrası operatörü sıfırla
          }
        }
      } else {
        output += buttonText; // Sayıları ekrana ekle
      }
    });
  }

  Widget buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.125, // Buton yüksekliği
        child: OutlinedButton(
          onPressed: () => buttonPressed(buttonText),
          style: OutlinedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800], // Varsayılan buton rengi
            foregroundColor: Colors.white, // Buton üzerindeki metin rengi
          ),
          child: Text(buttonText, style: TextStyle(fontSize: 36)), // Buton metin boyutu
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar rengi
        toolbarHeight: 0, // AppBar yüksekliğini sıfırla
      ),
      backgroundColor: Colors.black, // Arka plan rengi
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            alignment: Alignment.centerRight,
            child: Text(
              output,
              style: TextStyle(fontSize: 48, color: Colors.white), // Ekrandaki metin rengi
            ),
          ),
          Spacer(), // Boş alan oluşturur
          Column(
            children: [
              Row(children: [
                 buildButton('C'),
                 buildButton('AC'),
                 buildButton('%'),
                 buildButton('/', color: Colors.orange)
                ]),
              Row(children: [
                 buildButton('7'), 
                 buildButton('8'), 
                 buildButton('9'), 
                 buildButton('*', color: Colors.orange)
                ]),
              Row(children: [
                buildButton('4'), 
                buildButton('5'), 
                buildButton('6'), 
                buildButton('-', color: Colors.orange)
                ]),
              Row(children: [
                buildButton('1'), 
                buildButton('2'), 
                buildButton('3'), 
                buildButton('+', color: Colors.orange)
                ]),
                Row(children: [
                buildButton('0'), 
                buildButton(','), 
                buildButton('=', color: Colors.orange)
                ]),
            ],
          ),
        ],
      ),
    );
  }
}
