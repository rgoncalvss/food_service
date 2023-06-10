import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_service_fetin/Screens/Welcome/welcome_screen.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String passwordConfirm;
  late String firstName;
  late String lastName;
  late String address;
  bool _obscureText = true;
  bool emailAlreadyExists = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  email = value;
                  emailAlreadyExists = false; // Resetar a flag de e-mail existente
                });
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Seu e-mail",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          if (emailAlreadyExists) ...[
            const Text(
              "O e-mail já está cadastrado.",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8.0),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              onChanged: (value) {
                firstName = value;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Seu nome",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              onChanged: (value) {
                lastName = value;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Seu sobrenome",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              onChanged: (value) {
                address = value;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Seu endereço",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_on),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              onChanged: (value) {
                password = value;
              },
              textInputAction: TextInputAction.done,
              obscureText: _obscureText,
              cursorColor: kPrimaryColor,
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
          TextFormField(
            onChanged: (value) {
              passwordConfirm = value;
            },
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
            cursorColor: kPrimaryColor,
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
              hintText: "Repita sua senha",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          ElevatedButton(
            onPressed: () async {
              try {
                if (password == passwordConfirm) {
                  var signInMethods =
                  await _auth.fetchSignInMethodsForEmail(email);
                  if (signInMethods.isEmpty) {
                    final newUser =
                    await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      await _auth.currentUser?.updateProfile(
                          displayName: "$firstName $lastName");
                      await _auth.currentUser?.reload();
                      // Salvar o endereço do usuário no Firestore
                      // ...

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const WelcomeScreen();
                        }),
                      );
                    }
                  } else {
                    setState(() {
                      emailAlreadyExists = true;
                    });
                  }
                } else {
                  // Senhas não coincidem
                  Fluttertoast.showToast(
                    msg: "Senhas não coincidem",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text("Cadastrar".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
