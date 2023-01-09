import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/etudiant.dart';
import 'connexion_page.dart';
import 'emploi_du_temps.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.id,
      required this.statut,
      required this.niveau,
      required this.filiere})
      : super(key: key);
  final int id;
  final String statut;
  final String niveau;
  final String filiere;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Etudiant> etudiant;
  late String codeRecu;
  late String statut;
  late String api = 'http://10.0.2.2:8000/api/etudiants';

  // late String api = 'http://192.168.1.184:8000/api/etudiants';
  // late String api = 'http://192.168.43.130:8000/api/etudiants';
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    etudiant = getData();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.statut == "acceptable" || widget.statut == "actif")
        ? Scaffold(
            // backgroundColor: Colors.green,
            body: SingleChildScrollView(
                child: Container(
                    child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TextButton(onPressed: () => {getData()}, child: Text('oklm')),
              Center(
                child: FutureBuilder<Etudiant>(
                  future: etudiant,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var etd = snapshot.data;
                      return (etd!.statut_benef == "acceptable" ||
                              widget.statut == "actif")
                          ? Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                padding(),
                                padding(),
                                Container(
                                    width: 400.0,
                                    height: 150.0,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'http://10.0.2.2:8000/' + etd.photo,
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 60.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      padding(),
                                      textPage('Nom : ' + etd.username),
                                      padding(),
                                      textPage('Prénom : ' + etd.prenomBenef),
                                      padding(),
                                      textPage('Matricule : ' + etd.matricule),
                                      padding(),
                                      textPage('Filière : ' + etd.filiereBenef),
                                      padding(),
                                      textPage('Niveau : ' + etd.niveauBenef),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      (etd.statut_benef != "actif")
                                          ? ElevatedButton(
                                              onPressed: () =>
                                                  {ValiderInscription()},
                                              child: Text(
                                                  'Valider mon inscription'),
                                              style: buttonsStyle(),
                                            )
                                          : Container(),
                                      (etd.statut_benef == "actif")
                                          ? ElevatedButton(
                                              onPressed: () => {Scolarite()},
                                              child: Text('Scolarité'),
                                              style: buttonsStyle(),
                                            )
                                          : Container(),
                                      (etd.statut_benef == "actif")
                                          ? ElevatedButton(
                                              onPressed: () => {EmploiDuTemp()},
                                              child: Text('Emploi du temps'),
                                              style: buttonsStyle(),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ))
                          : (etd.statut_benef == "en cours")
                              ? StatuEnCours()
                              : Text('chargement');
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ))))
        : (widget.statut == "en cours")
            ? StatuEnCours()
            : Erreur();
  }

  Future<Etudiant> getData() async {
    if (widget.id != null) {
      final response =
          await http.get(Uri.parse(api + '/' + widget.id.toString()));
      if (response.statusCode == 200) {
        Etudiant etd = Etudiant.fromJson(jsonDecode(response.body));
        return etd;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load etudiant data');
      }
    } else {
      throw Exception('not id');
    }
  }

  StatuEnCours() {
    return Scaffold(
        backgroundColor: Colors.green,
        body: SingleChildScrollView(
            child: SizedBox(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TextButton(onPressed: () => {getData()}, child: Text('oklm')),
            Container(
              child: FutureBuilder<Etudiant>(
                future: etudiant,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var etd = snapshot.data;
                    return SizedBox(
                        child: Center(
                            child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 200.0)),
                        const Text(
                          "Merci de repasser plus tard ",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Votre dossier est en cour d'évaluation",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Repassez dans 48h, pour accéder à votre compte, si vous n'y arriver pas vous avez été refuser.",
                          textAlign: TextAlign.center,
                          textScaleFactor: 2.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 80.0)),
                        ElevatedButton(
                          onPressed: () => {PageConnexion()},
                          child: const Text(
                            'Retour',
                            textScaleFactor: 1.5,
                          ),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.green),
                            fixedSize: MaterialStateProperty.all(
                                Size.fromWidth(100.0)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.greenAccent),
                            elevation: MaterialStateProperty.all(10.0),
                          ),
                        )
                      ],
                    )));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ))));
  }

  Erreur() {
    return Scaffold(
        backgroundColor: Colors.green,
        body: SizedBox(
            child: Center(
                child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 40.0)),
            const Text(
              "Erreur",
              textAlign: TextAlign.center,
              textScaleFactor: 3.2,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            const Text(
              "Dommage, une erreur c'est produite si elle persiste veuillez contacter l'école.",
              textAlign: TextAlign.center,
              textScaleFactor: 2.2,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 100.0)),
            ElevatedButton(
              onPressed: () => {PageConnexion()},
              child: const Text(
                'Retour',
                textScaleFactor: 1.5,
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.green),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(100.0)),
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                elevation: MaterialStateProperty.all(10.0),
              ),
            )
          ],
        ))));
  }

  void PageConnexion() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Connexion()),
    );
  }

  buttonsStyle() {
    return ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.green),
      fixedSize: MaterialStateProperty.all(
          Size.fromWidth(MediaQuery.of(context).size.width / 1.4)),
      backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      elevation: MaterialStateProperty.all(10.0),
    );
  }

  textPage(String txt) {
    return Text(
      txt,
      style: const TextStyle(color: Colors.green, fontSize: 20.0),
    );
  }

  Future<void> ValiderInscription() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Valider votre inscription'),
            children: <Widget>[
              Champ('Code Reçu de Celpaid'),
              SimpleDialogOption(
                onPressed: () => {
                  if (codeRecu == 'AX405')
                    {
                      codeRecu = "",
                      statut = "actif",
                      NotifRecu("Reussi", Colors.green, "Inscription validé"),
                      sendDonne(statut),
                    }
                  else
                    {
                      NotifRecu(
                          "Erreur", Colors.red, "Erreur vérifier le code"),
                      Navigator.pop(context)
                    }
                },
                child: const Text('Inscription'),
              ),
            ],
          );
        });
  }

  Champ(String titre) {
    return Center(
      // Icon(iconn),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          // width: 300.0,
          child: Form(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: titre,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onChanged: (value) async {
                    codeRecu = value;
                  },
                )),
          )),
    );
  }

  void NotifRecu(String label, Color couleur, String cont) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          textColor: couleur,
          label: label,
          onPressed: () {
            // Code to execute.
          },
        ),
        content: Text(cont),
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

  void sendDonne(String statut) async {
    final url = Uri.parse(api + "/" + widget.id.toString());
    final headers = {"Content-type": "application/json"};
    final json = '{"statutBenef": "$statut"}';
    // make POST request
    final response = await http.put(url, headers: headers, body: json);
    // check the status code for the result
    final statusCode = response.statusCode;

    // this API passes back the id of the new item added to the body
    final body = response.body;
    print(body);
    Etudiant etd = Etudiant.fromJson(jsonDecode(body));

    if (statusCode == 200 || statusCode == 201) {
      print("envoyer");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  id: etd.id,
                  statut: etd.statut_benef,
                  niveau: etd.niveauBenef,
                  filiere: etd.filiereBenef,
                )),
      );
    } else {
      print(statusCode);
    }
  }

  Future<void> Scolarite() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Scolarité : 1.600.000'),
            children: <Widget>[
              Table(
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [textTableau("Date"), textTableau("Montant")],
                    )),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [textTableau("12/12/2021"), Text("600000")],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textTableau("Reste : "),
                        Text(
                          "1000000",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )),
                  ])
                ],
              ),
            ],
          );
        });
  }

  textTableau(String contenu) {
    return Text(
      contenu,
      style: TextStyle(fontSize: 15.0),
    );
  }

  EmploiDuTemp() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmploiDuTemps(
                niveau: widget.niveau,
                filiere: widget.filiere,
              )),
    );
  }
}

padding() {
  return const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0));
}
