// import 'dart:io';
// import 'dart:typed_data';
// import 'package:app/services/person_data.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert' as convert;
// import 'package:image/image.dart' as img;

// class Camera extends StatefulWidget {
//   const Camera({Key? key}) : super(key: key);

//   @override
//   _CameraState createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   bool error = false;
//   Map data = {};
//   Future<void> faceRecognition() async {
//     try {
//       String url = 'http://192.168.100.73:8080/';
//       http.Response response = await http.post(
//         Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: convert.jsonEncode(<String, String>{
//           'image1': Global.ciBase64,
//           'image2': Global.cameraBase64,
//         }),
//       );
//       print('STATUS CODE ${response.statusCode}');
//       if (response.statusCode == 200) {
//         setState(() {
//           data = convert.jsonDecode(response.body);
//         });
//       } else {
//         error = true;
//       }
//     } catch (e) {
//       print('ERRORRRR');
//       print(e);
//       error = true;
//     }
//   }

//   void doFaceRecognition() async {
//     await faceRecognition();

//     if (data['image2.jpg']['image1.jpg'] < 0.800) {
//       showAlert('Coinciden');
//     } else {
//       showAlert('NO Coinciden');
//     }
//   }

//   File? image;
//   Future<Uint8List>? waitImage;
//   Uint8List? displayImage;
//   Future pickImage() async {
//     try {
//       XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (image == null) {
//         Navigator.pop(context);
//         return;
//       }
//       displayImage = await image.readAsBytes();
//       print('displayImage = await image.readAsBytes()');
//       File imageTemporary = File(image.path);
//       final image1 = img.decodeImage(File(image.path).readAsBytesSync())!;
//       final thumgnail = img.copyResize(image1, width: 80);
//       imageTemporary.writeAsBytes(img.encodePng(thumgnail));
//       setState(() {
//         this.image = imageTemporary;
//         print('this.image = imageTemporary;');
//       });
//     } on PlatformException catch (e) {
//       print(e);
//     }
//   }

//   void startImage() async {
//     await pickImage();
//     print('despues de pickimage');
//     final path = this.image!.path;
//     final bytes = await File(path).readAsBytes();
//     Global.cameraBase64 = convert.base64Encode(bytes);
//     print('doFaceRecognition');
//     doFaceRecognition();
//   }

//   @override
//   void initState() {
//     super.initState();
//     startImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: showImage(),
//     );
//   }

//   showImage() {
//     if (displayImage != null) {
//       return Container(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Center(
//                 child: Image.memory(
//                   displayImage!,
//                   width: 400,
//                   height: 500,
//                 ),
//               ),
//               Text(
//                 '\n$data',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }

//   showAlert(String message) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           Future.delayed(Duration(milliseconds: 700), () {
//             Navigator.pop(context);
//           });
//           if (message == 'Coinciden') {
//             return Container(
//               child: AlertDialog(
//                 backgroundColor: Colors.green,
//                 title: Center(
//                     child: Text(
//                   message,
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                 )),
//               ),
//             );
//           } else {
//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0))),
//               child: AlertDialog(
//                 backgroundColor: Colors.red,
//                 title: Center(
//                     child: Text(
//                   message,
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                 )),
//               ),
//             );
//           }
//         });
//   }
// }


// /*
// FutureBuilder<void>(
//         future: waitImage,
//         builder: (context, snapshot) {
//           // if (snapshot.connectionState == ConnectionState.done) {
//           if (displayImage != null) {
//             return Container(
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     Center(
//                       child: Image.memory(
//                         displayImage!,
//                         width: 400,
//                         height: 500,
//                       ),
//                     ),
//                     Text(
//                       '\n$data',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//  */