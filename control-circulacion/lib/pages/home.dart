import 'package:flutter/material.dart';
import 'package:app/services/person_data.dart';
// import 'package:app/main.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controller para obtener el nro de cédula del textfiel
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffF1AF4B), // status bar color
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/background.png'),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Image.asset(
                    'assets/gobierno-nacional.png',
                    height: 120,
                    width: 320,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'PASAPORTE SANITARIO',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text('Municipalidad de Encarnación',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Text(
                    'Ingrese el número de documento para validar los datos de vacunación',
                    style: TextStyle(color: Colors.grey, height: 2),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 35),
              child: ElevatedButton(
                onPressed: () => showInputDialog(context).then((ciValue) {
                  myController.text = ''; //Limpiar textfield
                  ciValue = ciValue.replaceAll(' ', ''); //Remove white spaces
                  RegExp regexp =
                      RegExp(r'^[0-9]*$'); //Para validación de sólo números
                  if (!regexp.hasMatch(ciValue)) {
                    showAlert();
                  } else if (ciValue != false && ciValue != '') {
                    Global.ci = ciValue;
                    Navigator.pushNamed(context, '/loading');
                  }
                }),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                  child: Text(
                    'INGRESAR NÚMERO DE DOCUMENTO',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF1AF4B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ingrese Nro. de Cédula'),
            content: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Ingrese Cédula',
                contentPadding: EdgeInsets.only(left: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              controller: myController,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Color(0xffF1AF4B),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    return Navigator.pop(context, myController.text.toString());
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      color: Color(0xffF1AF4B),
                    ),
                  ))
            ],
          );
        });
  }

// MOSTRAR ALERT DIALOG CUANDO SE INGRESAN MAL LOS DATOS
  showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(Duration(milliseconds: 700), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            title: Center(child: Text('Ingrese sólo números')),
          );
        });
  }
}
