import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField() {
    weightcontroller.text = "";
    heightcontroller.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weigth = double.parse(weightcontroller.text);
      double heigth = double.parse(heightcontroller.text) / 100;
      double imc = weigth / (heigth * heigth);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso. (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal. (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso. (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I. (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III. (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _appBar();
  }

  Widget _appBar() {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(onPressed: _resetField, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: _body());
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Form(
        key: formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _icon(),
              _textoPeso(),
              _textoAltura(),
              _button(),
              _texto()
            ]),
      ),
    );
  }

  Widget _icon() {
    return Icon(
      Icons.person_outline,
      size: 120.0,
      color: Colors.green,
    );
  }

  Widget _textoPeso() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Peso (kg)", labelStyle: TextStyle(color: Colors.green)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 20.0),
      controller: weightcontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Insira seu peso";
        } else {
          return null;
        }
      },
    );
  }

  Widget _textoAltura() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "Altura (cm)",
            labelStyle: TextStyle(color: Colors.green)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green, fontSize: 20.0),
        controller: heightcontroller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Insira sua altura";
          } else {
            return null;
          }
        });
  }

  Widget _button() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
      child: Container(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                calculate();
              }
            },
            child: Text('Calcular',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
            style: ElevatedButton.styleFrom(primary: Colors.green),
          )),
    );
  }

  Widget _texto() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 20.0),
    );
  }
}
