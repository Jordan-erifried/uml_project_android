import 'package:flutter/material.dart';


class EmploiDuTemps extends StatelessWidget {
  const EmploiDuTemps({Key? key,required this.niveau,required this.filiere}) : super(key: key);
  final String niveau;
  final String filiere;

  @override
  Widget build(BuildContext context) {
    print(niveau);
    return Scaffold(
      body:
      (niveau == 'LP1' && filiere=='INFORMATIQUE' )?
      Container(
        width: 700.0,
        child : Image.asset(
          'images/LP1_INFO.png',
          fit:BoxFit.fill
      )
    ):(niveau == 'LP2'&& filiere=='INFORMATIQUE')?Container(
        width: 700.0,
        child : Image.asset(
            'images/LP2_INFO.png',
            fit:BoxFit.fill
      )):(niveau == 'LP3' && filiere=='INFORMATIQUE')?Container(
        width: 700.0,
        child : Image.asset(
            'images/LP3 INFO.png',
            fit:BoxFit.fill
        )):(niveau == 'M1' && filiere=='INFORMATIQUE')?Container(
        width: 700.0,
        child : Image.asset(
            'images/M1 INFO.png',
            fit:BoxFit.fill
        )):(niveau == 'M2' && filiere=='INFORMATIQUE')?Container(
        width: 700.0,
        child : Image.asset(
            'images/M2 INFO.png',
            fit:BoxFit.fill
        )):(niveau == 'LP1' && filiere=='TCF')?Container(
        width: 700.0,
        child : Image.asset(
            'images/LP1 TCF.png',
            fit:BoxFit.fill
        )):(niveau == 'LP2' && filiere=='TCF')?Container(
        width: 700.0,
        child : Image.asset(
            'images/LP2 TCF.png',
            fit:BoxFit.fill
        )):(niveau == 'LP3' && filiere=='TCF')?Container(
        width: 700.0,
        child : Image.asset(
            'images/LP3 TCF.png',
            fit:BoxFit.fill
        )):(niveau == 'M1' && filiere=='TCF')?Container(
        width: 700.0,
        child : Image.asset(
            'images/M1 TCF.png',
            fit:BoxFit.fill
        )):(niveau == 'M2' && filiere=='TCF')?Container(
        width: 700.0,
        child : Image.asset(
            'images/M2 TCF.png',
            fit:BoxFit.fill
        )):Container(
      child: Text(
        'Emploi du temps non disponible'
      ),
    ));
  }
}
