class User {
   String id;
  final String nom;
  final int contact;

  User({
     this.id = '',
    required this.nom,
    required this.contact,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
      
        'contact': contact,
      };
       static User fromJson(Map<String, dynamic> json) => User(
     id: json['id'],
      nom: json['nom'],
      contact: json['contact']);
}