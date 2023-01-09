import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:intl/intl.dart';



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
  final format = DateFormat("dd/MM/yyyy");


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
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      print(_currentPage);
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
        backgroundColor: Color(0xFF07996D),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),

                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),

                const SizedBox(height: 25),

                Text(
                  'Laissez nous vous aidez à créer votre compte 😋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  'Nom',
                  TypeTextField.nom,
                  Icons.eleven_mp,
                  TextInputType.name,
                  false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Prenom',
                  TypeTextField.prenom,
                  Icons.eleven_mp,
                  TextInputType.name,
                  false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Email',
                  TypeTextField.email,
                  Icons.eleven_mp,
                  TextInputType.emailAddress,
                  false,
                ),

                const SizedBox(height: 10),

                // Container(
                //   margin: EdgeInsets.only(right: 300.0, bottom: 10.0),
                //   child: Text(
                //     'Sexe',
                //     style: TextStyle(
                //       fontSize:
                //     ),
                //   ),
                // )
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: sexe,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    underline: Container(

                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        sexe = newValue!;
                      });
                    },
                    items: <String>['Masculin','Feminin'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  // Icon(iconn),
                  child :SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      // width: 300.0,
                      child : Column(
                        children: [
                          Container(
                            width: 400.0,
                            margin: EdgeInsets.only(right: 50.0,bottom: 10.0),
                            child:Text('Date de naissance',style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white
                            ),),
                          ),
                          Container(
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child :DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                          )],
                      )),
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Lieu de naissance',
                  TypeTextField.lieuNaissance,
                  Icons.eleven_mp,
                  TextInputType.name,
                  false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Tel',
                  TypeTextField.telEtudiant,
                  Icons.eleven_mp,
                  TextInputType.phone,
                  false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Télephone du parent',
                  TypeTextField.telParent,
                  Icons.eleven_mp,
                  TextInputType.text,
                  false,
                ),

                const SizedBox(height: 10),

                Container(
                    width: MediaQuery.of(context).size.width-50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: filiereBenef,
                      // icon: const Icon(Icons.arrow_downward),
                      // iconSize: 24,
                      // elevation: 16,
                      style: const TextStyle(color: Colors.grey,fontSize: 20.0),
                      underline: Container(
                        // height: 2,
                        // color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          filiereBenef = newValue!;
                        });
                      },
                      items: <String>['INFORMATIQUE','TCF','RHCOM', 'COMPTABILITE','LOGISTIQUE','RHPUB','MANAGEMENT']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                ),

                const SizedBox(height: 10),

                Container(
                    width: MediaQuery.of(context).size.width-50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: niveauBenef,
                      // icon: const Icon(Icons.arrow_downward),
                      // iconSize: 24,
                      // elevation: 16,
                      style: const TextStyle(color: Colors.grey,fontSize: 20.0),
                      underline: Container(
                        // height: 2,
                        // color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          niveauBenef = newValue!;
                        });
                      },
                      items: <String>['LP1','LP2','BTS1','BTS2','LP3','M1','M2']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                ),

                const SizedBox(height: 10),

                MyTextField(
                  'Mot de passe',
                  TypeTextField.mdp,
                  Icons.eleven_mp,
                  TextInputType.visiblePassword,
                  true,
                ),

                const SizedBox(height: 10),

                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Text(
                          'Votre CNI : ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: (() => getCni(ImageSource.gallery))),
                      (cni == '')?Container():Text('Cni ajouté')
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Text(
                          'Votre BAC : ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: (() => getImage(ImageSource.gallery))
                      ),
                      (bacBenef == '')?Container():Text('Bac ajouté')
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  margin: const EdgeInsets.only(right: 200.0, bottom: 10.0),
                  child: const Text(
                    'Une photo de vous',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),
                  ),
                ),
                (photoBenef == '')
                ? Container(
                  width: 150,
                  height: 150,
                  child: ContianerImage(
                    Image.asset(
                      'images/no_image.jpg',
                      fit: BoxFit.fill,
                    )
                  ),
                ) : ContianerImage(Image.file(File(photoBenef))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.camera_enhance),
                      onPressed: (() => getPhoto(ImageSource.camera)),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library),
                      onPressed: (() => getPhoto(ImageSource.gallery)),
                    )
                  ],
                ),

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: () => sendData(
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
                    File(photoBenef),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Inscription',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Déja inscrit ?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => {
                          Navigator.pop(context),
                        },
                        child: const Text(
                          'Connectez vous 😇',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }

  // champ(String titre, TypeTextField type, IconData iconn, TextInputType inputType) {
  //   return Center(
  //     // Icon(iconn),
  //     child :SizedBox(
  //         width: MediaQuery.of(context).size.width - 50,
  //         // width: 300.0,
  //         child : Column(
  //           children: [
  //             Container(
  //               width: 400.0,
  //               margin: EdgeInsets.only(right: 50.0,bottom: 10.0),
  //               child:Text(titre,style: TextStyle(
  //                   fontSize: 25.0,
  //                   color: Colors.white
  //               ),),
  //             ),
  //             Form(
  //               child: Container(
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(36)),
  //                   child: TextField(
  //                     keyboardType: inputType,
  //                     decoration: InputDecoration(
  //                       hintText: titre,
  //                       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(32.0)),
  //                     ),
  //                     onChanged: (value) async {
  //                       switch (type) {
  //                         case TypeTextField.email:
  //                           setState(() {
  //                             emailBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.mdp:
  //                           setState(() {
  //                             passwordBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.nom:
  //                           setState(() {
  //                             nomBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.prenom:
  //                           setState(() {
  //                             prenomBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.filiere:
  //                           setState(() {
  //                             filiereBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.telParent:
  //                           setState(() {
  //                             telParent = value;
  //                           });
  //                           break;
  //                         case TypeTextField.telEtudiant:
  //                           setState(() {
  //                             telEtudiant = value;
  //                           });
  //                           break;
  //                         case TypeTextField.niveau:
  //                           setState(() {
  //                             niveauBenef = value;
  //                           });
  //                           break;
  //                         case TypeTextField.lieuNaissance:
  //                           setState(() {
  //                             lieuNaissance = value;
  //                           });
  //                           break;
  //                       }
  //                     },
  //                   )),
  //             )
  //           ],
  //         )),
  //   );
  // }

  MyTextField( String titre, TypeTextField type, IconData iconn, TextInputType inputType, bool obscureText) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: titre,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        onChanged: (value) async {
          switch (type) {
            case TypeTextField.email:
             setState(() {
               emailBenef = value;
             });
              break;
            case TypeTextField.mdp:
              setState(() {
                passwordBenef = value;
              });
              break;
            case TypeTextField.nom:
              setState(() {
                nomBenef = value;
              });
              break;
            case TypeTextField.prenom:
              setState(() {
                prenomBenef = value;
              });
              break;
            case TypeTextField.filiere:
              setState(() {
                filiereBenef = value;
              });
              break;
            case TypeTextField.telParent:
              setState(() {
                telParent = value;
              });
              break;
            case TypeTextField.telEtudiant:
              setState(() {
                telEtudiant = value;
              });
              break;
            case TypeTextField.niveau:
              setState(() {
                niveauBenef = value;
              });
              break;
            case TypeTextField.lieuNaissance:
              setState(() {
                lieuNaissance = value;
              });
              break;
          }
        },
      ),
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
  return const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0));
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
  // late String api = 'http://192.168.43.130:8000/api/etudiants';

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
  // late String api = 'http://192.168.43.130:8000/api';
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
