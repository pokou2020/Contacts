import 'package:appcontact/editContact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
        routes: {
        EditContact.routeName: (ctx) => EditContact(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final controller = TextEditingController();

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes contacts")
      ),
      body:  StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Erreur ! ${snapshot.error}  ');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(builUser).toList(),
                 
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),);
              }

            }
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EditContact.routeName);

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
    Widget builUser(User user) => ListTile(
        title: Text(user.nom),
        subtitle: Text('${user.contact} '),
        leading: Icon(
          Icons.edit,
        ),
        trailing: Icon(Icons.delete),
      );
  Stream<List<User>> readUsers() => FirebaseFirestore.instance.collection("users")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future createUser({required String nom,}) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();

    final user = User (
       id:docUser.id,
      nom: nom,
      contact:2018,
      );

    final json= user.toJson();

   await docUser.set(json);
  }

  

}




