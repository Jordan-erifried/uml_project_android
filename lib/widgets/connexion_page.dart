import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/etudiant.dart';
import 'home_page.dart';
import 'inscription_page.dart';

class Connexion extends StatefulWidget {


  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  late String username = '';
  late String password;
  late String api = 'http://10.0.2.2:8000/api/etudiants';
      // late String api = 'http://192.168.43.130:8000/api/etudiants';

  @override
  Widget build(BuildContext context) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
    return Scaffold(
        backgroundColor: Color(0xFF07996D),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Center(
                    child: Column(
                      children: [
                        // const SizedBox(height: 50),

                        Image.asset(
                          'images/logo.png',
                          fit: BoxFit.fill,
                        ),

                        const SizedBox(height: 50),

                        Text(
                          'Bienvenue je vous prie de vous connecter 😇',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          child: Column(
                            children: [
                              MyTextField(
                                  'Email',
                                  TypeTextField.email,
                                  TextInputType.emailAddress,
                                  false,
                              ),

                              const SizedBox(height: 15),

                              MyTextField(
                                  'Mot de passe',
                                  TypeTextField.password,
                                  TextInputType.visiblePassword,
                                  true,
                              ),

                              const SizedBox(height: 10),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Mot de passe oublié ?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              GestureDetector(
                                onTap: () => {appelApi()} /*page Accueil*/,
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
                                      'Connexion',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        padding(),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pas encore inscrit ?',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => {PageInscription()},
                                child: const Text(
                                  'Inscrivez vous maintenant',
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
                    )),
              ),
            ),
          ),
        ));
  }

  void PageInscription() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InscriptionPage()),
    );
  }

  void Erreur() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          textColor: Colors.red,
          label: 'Erreur',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: const Text('Erreur de connexion'),
        duration: const Duration(milliseconds: 1500),
        // width:280.0,// Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void PageAccueil(int id, String statut, String niveau, String filiere) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(id: id, statut: statut,niveau: niveau,filiere: filiere,),
        ));
  }

  void appelApi() async {
    print('ok');
    final response =
        await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      print('1ok');
      // print(jsonDecode(response.body)["hydra:member"]);
      var etds = jsonDecode(response.body);
      // var etds = jsonDecode(response.body)["hydra:member"];
      bool connection = false;
      // print(etds);
      for (var etudiant in etds) {
        Etudiant etd = Etudiant.fromJson(etudiant);
        if (username == etd.email && password == etd.password) {
          connection = true;
          PageAccueil(etd.id, etd.statut_benef,etd.niveauBenef,etd.filiereBenef);
        }
      }
      if (!connection) {
        Erreur();
      }
    } else {
      print('Erreur');
    }
  }



  MyTextField( String titre, TypeTextField type, TextInputType inputType, bool obscureText) {

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
              username = value;
              break;
            case TypeTextField.password:
              password = value;
              break;
          }
        },
      ),
    );
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
enum TypeTextField {
email,
  password
}