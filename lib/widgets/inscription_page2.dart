import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:async/async.dart';


import '../model/etudiant.dart';
import 'home_page.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  // late ScrollController _controller;


  late String nomBenef = '';
  late String prenomBenef = '';
  late String emailBenef = '';
  late String passwordBenef = '';
  late String photoBenef = '';
  late String bacBenef = '';
  late String filiereBenef = 'INFORMATIQUE';
  late String niveauBenef = 'LP1';
  late String matricule = '';
  late String sexe = 'Masculin';
  late String dateNaissance = '';
  late String lieuNaissance = '';
  late String telEtudiant = '';
  late String telParent = '';
  late String cni = '';

  void initState() {
    super.initState();
    // _controller = ScrollController();
    // _controller.addListener(_listener);
  }

  // @override
  //   void _listener() {
  //   if(_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
  //     print('Je suis en bas !');
  //   }
  //
  //   if(_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
  //     print('Je suis en haut !');
  //   }
  // }
  // @override
  //   void dispose() {
  //   super.dispose();
  //   _controller.removeListener(_listener);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF07996D),
        body: SingleChildScrollView(
          // controller: _controller,
          child: Center(
            child: Column(
                children: [
                  padding(),
                  padding(),
                  padding(),
                  padding(),
                  Image.asset(
                    'images/logo.png',
                    fit: BoxFit.fill,
                  ),
                  padding(),
                  champ("Nom ", TypeTextField.nom, Icons.eleven_mp,TextInputType.name),
                  padding(),
                  champ("Prenom ", TypeTextField.prenom, Icons.eleven_mp,TextInputType.name),
                  padding(),
                  Container(
                    margin: EdgeInsets.only(right: 300.0,bottom: 10.0),
                    child:Text('Sexe',style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white
                    ),),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      child: DropdownButton<String>(
                        value: sexe,
                        // icon: const Icon(Icons.arrow_downward),
                        // iconSize: 24,
                        // elevation: 16,
                        style: const TextStyle(color: Colors.black,fontSize: 20.0),
                        underline: Container(
                          // height: 2,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            sexe = newValue!;
                          });
                        },
                        items: <String>['Masculin','Feminin']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  padding(),
                  champ("Date de naissance ", TypeTextField.dateNaissance,
                      Icons.eleven_mp,TextInputType.datetime),
                  padding(),
                  champ("Lieu de naissance ", TypeTextField.lieuNaissance,
                      Icons.eleven_mp,TextInputType.name),
                  padding(),
                  champ("Email :", TypeTextField.email, Icons.eleven_mp,TextInputType.emailAddress),
                  padding(),
                  champ("Telephone-Etudiant ", TypeTextField.telEtudiant,
                      Icons.eleven_mp,TextInputType.phone),
                  padding(),
                  champ("Telephone-Parent ", TypeTextField.telParent,
                      Icons.eleven_mp,TextInputType.text),
                  padding(),
                  Container(
                    margin: EdgeInsets.only(right: 290.0,bottom: 10.0),
                    child:Text('Filiere',style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white
                    ),),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      child: DropdownButton<String>(
                        value: filiereBenef,
                        // icon: const Icon(Icons.arrow_downward),
                        // iconSize: 24,
                        // elevation: 16,
                        style: const TextStyle(color: Colors.black,fontSize: 20.0),
                        underline: Container(
                          // height: 2,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            filiereBenef = newValue!;
                          });
                        },
                        items: <String>['INFORMATIQUE','TCF']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  padding(),
                  Container(
                    margin: EdgeInsets.only(right: 280.0,bottom: 10.0),
                    child:Text('Niveau',style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white
                    ),),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      child: DropdownButton<String>(
                        value: niveauBenef,
                        // icon: const Icon(Icons.arrow_downward),
                        // iconSize: 24,
                        // elevation: 16,
                        style: const TextStyle(color: Colors.black,fontSize: 20.0),
                        underline: Container(
                          // height: 2,
                          // color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            niveauBenef = newValue!;
                          });
                        },
                        items: <String>['LP1','LP2','LP3','M1','M2']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  padding(),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Text('Fichier Cni :',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),),
                          IconButton(
                              icon: Icon(Icons.photo_library),
                              onPressed: (() => getCni(ImageSource.gallery))),
                          (cni == '')?Container():Text('fichier ajouté')
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: Row(
                    children: [
                      Text('Fichier Bac :',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),),
                      IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: (() => getImage(ImageSource.gallery))),
                      (bacBenef == '')?Container():Text('fichier ajouté')
                    ],
                  )),
                  champ("mot de passe ", TypeTextField.mdp, Icons.eleven_mp,TextInputType.visiblePassword),
                  padding(),
                  Container(
                    margin: EdgeInsets.only(right: 200.0,bottom: 10.0),
                    child:Text('Insérer photo',style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white
                    ),),
                  ),
                  padding(),
                  (photoBenef == '')
                      ? Container(
                      width: 150.0,
                      height: 150.0,
                    child: ContianerImage(Image.asset(
                      'images/no_image.jpg',
                      fit: BoxFit.fill,
                    ))
                  )
                      : ContianerImage(Image.file(File(photoBenef))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera_enhance),
                          onPressed: (() => getPhoto(ImageSource.camera))),
                      IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: (() => getPhoto(ImageSource.gallery)))
                    ],
                  ),
                  OutlinedButton(
                      onPressed: () => {
                            sendData(
                                context,
                                nomBenef,
                                prenomBenef,
                                passwordBenef,
                                emailBenef,
                                filiereBenef,
                                niveauBenef,
                                dateNaissance,
                                sexe,
                                lieuNaissance,
                                telEtudiant,
                                telParent,
                                File(cni),
                                File(bacBenef),
                                File(photoBenef)),
                            print("pass" + passwordBenef)
                          },
                      child: new Text(
                        'Valider',
                        style: new TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                  // Stack(
                  //   alignment: AlignmentDirectional.topStart,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.only(bottom: 35),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           for(int i = 0; i<3; i++)
                  //             if( i == 1 )
                  //               AnimatedContainer(
                  //                 duration: Duration(milliseconds: 150),
                  //                 margin: const EdgeInsets.symmetric(horizontal: 10),
                  //                 height: true ? 12 : 8,
                  //                 width: true ? 12 : 8,
                  //                 decoration: BoxDecoration(
                  //                   color: true ? Theme.of(context).primaryColor : Colors.grey,
                  //                   borderRadius: BorderRadius.all(Radius.circular(12)),
                  //                 ),
                  //               )
                  //             else
                  //               AnimatedContainer(
                  //                 duration: Duration(milliseconds: 150),
                  //                 margin: const EdgeInsets.symmetric(horizontal: 10),
                  //                 height: false ? 12 : 8,
                  //                 width: false ? 12 : 8,
                  //                 decoration: BoxDecoration(
                  //                   color: false ? Theme.of(context).primaryColor : Colors.grey,
                  //                   borderRadius: BorderRadius.all(Radius.circular(12)),
                  //                 ),
                  //               )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
            ),
          ),
        ));
  }

  champ(String titre, TypeTextField type, IconData iconn, TextInputType inputType) {
    return Center(
      // Icon(iconn),
      child :SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          // width: 300.0,
          child : Column(
            children: [
              Container(
                width: 400.0,
                margin: EdgeInsets.only(right: 50.0,bottom: 10.0),
                child:Text(titre,style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white
                ),),
              ),
              Form(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36)),
                    child: TextField(
                      keyboardType: inputType,
                      decoration: InputDecoration(
                        hintText: titre,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (value) async {
                        switch (type) {
                          case TypeTextField.email:
                            emailBenef = value;
                            break;
                          case TypeTextField.mdp:
                            passwordBenef = value;
                            break;
                          case TypeTextField.nom:
                            nomBenef = value;
                            break;
                          case TypeTextField.prenom:
                            prenomBenef = value;
                            break;
                          case TypeTextField.filiere:
                            filiereBenef = value;
                            break;
                          case TypeTextField.telParent:
                            telParent = value;
                            break;
                          case TypeTextField.telEtudiant:
                            telEtudiant = value;
                            break;
                          case TypeTextField.niveau:
                            niveauBenef = value;
                            break;
                        }
                      },
                    )),
              )
            ],
          )),
    );
  }



  Future getPhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    var nouvelleIMage = await _picker.pickImage(source: source);
    setState(() {
      photoBenef = nouvelleIMage!.path;
    });

    // upload(File(photoBenef));

    // // Save and Rename file to A
    //     // String dir = (await getApplicationDocumentsDirectory()).path;
    //     // String newPath = path.join(dir,'photo_'+nomBenef);
    //     // File f = await File(nouvelleIMage.path).copy(newPath);pp directory
    // photoBenef = f.toString();
    // print(photoBenef);
  }

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    print(_picker);
    var nouvelleIMage = await _picker.pickImage(source: source);
    print(nouvelleIMage);

    // upload(File(photoBenef));

// Save and Rename file to App directory
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir, 'bac_' + nomBenef);
    File f = await File(nouvelleIMage!.path).copy(newPath);
    print(f);
    setState(() {
      bacBenef = f.path;
    });
  }
  Future getCni(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    print(_picker);
    var nouvelleIMage = await _picker.pickImage(source: source);
    print(nouvelleIMage);

    // upload(File(photoBenef));

// Save and Rename file to App directory
    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir, 'cni_' + nomBenef);
    File f = await File(nouvelleIMage!.path).copy(newPath);
    print(f);
    setState(() {
      cni = f.path;
    });
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}

ContianerImage(Image image) {
  return Container(
      height: 200.0,
      width: 200.0,
      child: Card(
        elevation: 10.0,
        child: image,
      ));
}

void sendData(
    BuildContext context,
    String nom,
    String prenom,
    String password,
    String email,
    String filiere,
    String niveau,
    String date,
    String sexe,
    String lieuDeNaissance,
    String telEtudiant,
    String telParent,
    File cni,
    File bac,
    File imageFile) async {
  // set up POST request arguments
  // final response1 = await http.get(Uri.parse('http://10.0.2.2:8000/api/etudiants'));
  // List etds = jsonDecode(response1.body);
  // print(etds.length);

  print("user :" + nom);
  print("password :" + password);

  late String api = 'http://10.0.2.2:8000/api/etudiants';
  // late String api = 'http://192.168.1.184:8000/api/etudiants';
  // late String api = 'http://192.168.43.230:8000/api/etudiants';

  final url = Uri.parse(api);
  final headers = {"Content-type": "application/json"};
  final json = """{
      "username": "$nom",
      "password": "$password",
      "prenom":"$prenom",
      "photo": "",
      "email": "$email",
      "bacBenef": "",
      "statutBenef": "en cours",
      "filiere":"$filiere",
      "niveau":"$niveau",
      "matricule":"",
      "sexe":"$sexe",
      "dateNaissance":"0/0/0",
      "lieuNaissance":"$lieuDeNaissance",
      "telEtudiant":"$telEtudiant",
      "telParent":"$telParent",
      "cni":""
      }""";
  // make POST request
  final response = await http.post(url, headers: headers, body: json);
  if (imageFile.path != '') {
    upload(imageFile);
  }
  if (bac.path != '') {
    upload(bac);
  }
  if (cni.path != '') {
    upload(cni);
  }

  // check the status code for the result
  final statusCode = response.statusCode;

  // this API passes back the id of the new item added to the body
  final body = response.body;
  print(body);
  Etudiant etd = Etudiant.fromJson(jsonDecode(body));

  if (statusCode == 200 || statusCode == 201) {
    print("envoyer");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(id: etd.id, statut: etd.statut_benef,niveau: etd.niveauBenef,filiere: etd.filiereBenef,)),
    );
  } else {
    print(statusCode);
  }

  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
}

upload(File imageFile) async {
  // open a bytestream
  var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  late String api = 'http://10.0.2.2:8000/api';
  // late String api = 'http://192.168.43.230:8000/api';
  // late String api = 'http://192.168.1.184:8000/api';
  // string to uri
  var uri = Uri.parse(api+"/media_objects");

  // create multipart request
  var request = http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = http.MultipartFile('file', stream, length,
      filename: path.basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  // print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    // print(value);
  });
}

enum TypeTextField {
  nom,
  prenom,
  email,
  mdp,
  photo,
  bac,
  filiere,
  niveau,
  matricule,
  sexe,
  dateNaissance,
  lieuNaissance,
  telEtudiant,
  telParent,
  cni
}

// child: Column(
// children: [
// padding(),
// champ("Nom :", TypeTextField.nom, Icons.eleven_mp,TextInputType.name),
// padding(),
// champ("Prenom :", TypeTextField.prenom, Icons.eleven_mp,TextInputType.name),
// padding(),
// Container(
// width: MediaQuery.of(context).size.width-50,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(36)),
// child: DropdownButton<String>(
// value: sexe,
// // icon: const Icon(Icons.arrow_downward),
// // iconSize: 24,
// // elevation: 16,
// style: const TextStyle(color: Colors.black,fontSize: 20.0),
// underline: Container(
// // height: 2,
// // color: Colors.deepPurpleAccent,
// ),
// onChanged: (String? newValue) {
// setState(() {
// sexe = newValue!;
// });
// },
// items: <String>['Masculin','Feminin']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// )
// ),
// padding(),
// champ("Date de naissance :", TypeTextField.dateNaissance,
// Icons.eleven_mp,TextInputType.datetime),
// padding(),
// champ("Lieu de naissance :", TypeTextField.lieuNaissance,
// Icons.eleven_mp,TextInputType.name),
// padding(),
// champ("Email :", TypeTextField.email, Icons.eleven_mp,TextInputType.emailAddress),
// padding(),
// champ("Telephone-Etudiant :", TypeTextField.telEtudiant,
// Icons.eleven_mp,TextInputType.phone),
// padding(),
// champ("Telephone-Parent :", TypeTextField.telParent,
// Icons.eleven_mp,TextInputType.none),
// padding(),
// Container(
// width: MediaQuery.of(context).size.width-50,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(36)),
// child: DropdownButton<String>(
// value: filiereBenef,
// // icon: const Icon(Icons.arrow_downward),
// // iconSize: 24,
// // elevation: 16,
// style: const TextStyle(color: Colors.black,fontSize: 20.0),
// underline: Container(
// // height: 2,
// // color: Colors.deepPurpleAccent,
// ),
// onChanged: (String? newValue) {
// setState(() {
// filiereBenef = newValue!;
// });
// },
// items: <String>['INFORMATIQUE','RHCOM']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// )
// ),
// padding(),
// Container(
// width: MediaQuery.of(context).size.width-50,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(36)),
// child: DropdownButton<String>(
// value: niveauBenef,
// // icon: const Icon(Icons.arrow_downward),
// // iconSize: 24,
// // elevation: 16,
// style: const TextStyle(color: Colors.black,fontSize: 20.0),
// underline: Container(
// // height: 2,
// // color: Colors.deepPurpleAccent,
// ),
// onChanged: (String? newValue) {
// setState(() {
// niveauBenef = newValue!;
// });
// },
// items: <String>['BTS1','BTS2','L1','L2','L3','M1','M2']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// )
// ),
// padding(),
// Container(
// margin: EdgeInsets.only(left: 30.0),
// child: Row(
// children: [
// Text('Cni :'),
// IconButton(
// icon: Icon(Icons.photo_library),
// onPressed: (() => getCni(ImageSource.gallery))),
// (cni == '')?Container():Text('fichier ajouté')
// ],
// )),
// Container(
// margin: EdgeInsets.only(left: 30.0),
// child: Row(
// children: [
// Text('Bac :'),
// IconButton(
// icon: Icon(Icons.photo_library),
// onPressed: (() => getImage(ImageSource.gallery))),
// (bacBenef == '')?Container():Text('fichier ajouté')
// ],
// )),
// champ("mot de passe :", TypeTextField.mdp, Icons.eleven_mp,TextInputType.visiblePassword),
// padding(),
// (photoBenef == '')
// ? ContianerImage(Image.asset(
// 'images/no_image.jpg',
// fit: BoxFit.fill,
// ))
// : ContianerImage(Image.file(File(photoBenef))),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// IconButton(
// icon: Icon(Icons.camera_enhance),
// onPressed: (() => getPhoto(ImageSource.camera))),
// IconButton(
// icon: Icon(Icons.photo_library),
// onPressed: (() => getPhoto(ImageSource.gallery)))
// ],
// ),
// TextButton(
// onPressed: () => {
// sendData(
// context,
// nomBenef,
// prenomBenef,
// passwordBenef,
// emailBenef,
// filiereBenef,
// niveauBenef,
// dateNaissance,
// sexe,
// lieuNaissance,
// telEtudiant,
// telParent,
// File(cni),
// File(bacBenef),
// File(photoBenef)),
// print("pass" + passwordBenef)
// },
// child: new Text(
// 'Valider',
// style: new TextStyle(color: Colors.green, fontSize: 20.0),
// )),
// Stack(
// alignment: AlignmentDirectional.topStart,
// children: <Widget>[
// Container(
// margin: const EdgeInsets.only(bottom: 35),
// child: Row(
// mainAxisSize: MainAxisSize.min,
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// for(int i = 0; i<3; i++)
// if( i == 2 )
// AnimatedContainer(
// duration: Duration(milliseconds: 150),
// margin: const EdgeInsets.symmetric(horizontal: 10),
// height: true ? 12 : 8,
// width: true ? 12 : 8,
// decoration: BoxDecoration(
// color: true ? Theme.of(context).primaryColor : Colors.grey,
// borderRadius: BorderRadius.all(Radius.circular(12)),
// ),
// )
// else
// AnimatedContainer(
// duration: Duration(milliseconds: 150),
// margin: const EdgeInsets.symmetric(horizontal: 10),
// height: false ? 12 : 8,
// width: false ? 12 : 8,
// decoration: BoxDecoration(
// color: false ? Theme.of(context).primaryColor : Colors.grey,
// borderRadius: BorderRadius.all(Radius.circular(12)),
// ),
// )
// ],
// ),
// )
// ],
// ),
// ],
// ),