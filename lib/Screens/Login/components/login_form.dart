// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_service_fetin/Screens/Menu/navigation_screen.dart';
import 'package:food_service_fetin/Screens/Menu/menu_screen.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Menu/admin/admin_navigation.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  String userType = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); // Inicialize o Firebase aqui
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Nenhum Usuário encontrando com esse e-mail");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryLightColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Seu e-mail",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: _obscureText,
              cursorColor: kPrimaryLightColor,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hintText: "Sua senha",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                User? user = await loginUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
                print(user);

                try {
                  String searchField = "email";
                  String? fieldValue = user?.email;

                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection("users")
                      .where(searchField, isEqualTo: fieldValue)
                      .get();

                  if (querySnapshot.size > 0) {
                    QueryDocumentSnapshot docSnapshot = querySnapshot.docs[0];
                    Map<String, dynamic> dados = docSnapshot.data() as Map<String, dynamic>;
                    String name = dados['firstName'];
                    userType = dados['userType'];

                    // Agora você tem os dados do usuário específico
                    print("Nome do usuário: $name");
                  } else {
                    print("Usuário não encontrado.");
                  }
                } catch (e) {
                  print('Erro ao obter documentos: $e');
                }

                if (user != null) {
                  if(userType == 'admin'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AdminNavigationMenu();
                        },
                      ),
                    );
                  }
                  if(userType == 'cliente'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NavigationMenu();
                        },
                      ),
                    );
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xFF880000)),
              ),
              child: Text(
                "ENTRAR".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
