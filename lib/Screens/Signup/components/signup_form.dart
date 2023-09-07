import 'package:cloud_firestore/cloud_firestore.dart';
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
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String passwordConfirm = '';
  String firstName = '';
  String lastName = '';
  String address = '';
  String userType = '';
  bool _obscureText = true;
  bool emailAlreadyExists = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildFormField(
            label: "Seu e-mail",
            hintText: "Seu e-mail",
            icon: Icons.person,
            onChanged: (value) {
              setState(() {
                email = value;
                emailAlreadyExists = false; // Reset the flag for existing email
              });
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          if (emailAlreadyExists)
            const Text(
              "O e-mail já está cadastrado.",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          _buildFormField(
            label: "Seu nome",
            hintText: "Seu nome",
            icon: Icons.person,
            onChanged: (value) {
              firstName = value;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          _buildFormField(
            label: "Seu sobrenome",
            hintText: "Seu sobrenome",
            icon: Icons.person,
            onChanged: (value) {
              lastName = value;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          _buildFormField(
            label: "Seu endereço",
            hintText: "Seu endereço",
            icon: Icons.location_on,
            onChanged: (value) {
              address = value;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          _buildFormField(
            label: "Sua senha",
            hintText: "Sua senha",
            icon: Icons.lock,
            onChanged: (value) {
              password = value;
            },
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
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
          ),
          _buildFormField(
            label: "Repita sua senha",
            hintText: "Repita sua senha",
            icon: Icons.lock,
            onChanged: (value) {
              passwordConfirm = value;
            },
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Admin"),
                    value: 'admin',
                    groupValue: userType,
                    onChanged: (value) {
                      setState(() {
                        userType = value.toString();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Cliente"),
                    value: 'cliente',
                    groupValue: userType,
                    onChanged: (value) {
                      setState(() {
                        userType = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          ElevatedButton(
            onPressed: () => _handleSignUpButtonPressed(),
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

  Widget _buildFormField({
    required String label,
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Icon(icon),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  void _handleSignUpButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      if (password == passwordConfirm) {
        var signInMethods = await _auth.fetchSignInMethodsForEmail(email);
        if (signInMethods.isEmpty) {
          try {
            final newUser = await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            if (newUser != null) {
              await _auth.currentUser?.updateProfile(
                displayName: "$firstName $lastName",
              );
              await _auth.currentUser?.reload();

              Map<String, dynamic> user = {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'address': address,
                'userType': userType,
              };
              await db.collection("users").add(user);

              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }
          } catch (e) {
            print(e);
          }
        } else {
          setState(() {
            emailAlreadyExists = true;
          });
        }
      } else {
        // Passwords do not match
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
    }
  }
}

