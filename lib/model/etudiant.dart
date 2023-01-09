class Etudiant {
  // late String id;
  // late String type;
   int id;
   String username;
   String prenomBenef;
   String password;
   String photo;
   String email;
   String bac_benef;
   String statut_benef;
   String filiereBenef;
   String niveauBenef;
   String matricule;
   String sexe;
   String dateNaissance;
   String lieuNaissance;
   String telEtudiant;
   String telParent;
   String cni;

  Etudiant({
    required this.id,
    required this.username,
    required this.prenomBenef,
    required this.password,
    required this.photo,
    required this.email,
    required this.bac_benef,
    required this.statut_benef,
    required this.filiereBenef,
    required this.niveauBenef,
    required this.matricule,
    required this.sexe,
    required this.dateNaissance,
    required this.lieuNaissance,
    required this.telEtudiant,
    required this.telParent,
    required this.cni
  });
  factory Etudiant.fromJson(Map <String,dynamic> json){
    return Etudiant(
      id :json['id'],
      prenomBenef: json['prenom'],
      username : json['username'],
      password :json['password'],
      photo : json['photo'],
      email: json['email'],
      bac_benef: json['bacBenef'],
      statut_benef: json['statutBenef'],
        filiereBenef: json['filiere'],
        niveauBenef: json['niveau'],
        matricule: json['matricule'],
      sexe: json['sexe'],
      dateNaissance: json['dateNaissance'],
      lieuNaissance: json['lieuNaissance'],
      telEtudiant: json['telEtudiant'],
      telParent: json['telParent'],
      cni: json['cni']
    );
  }

}