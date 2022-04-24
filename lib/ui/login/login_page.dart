import 'package:flutter/material.dart';
import 'package:flutter_exam/ui/gallery/pages/gallery_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loginForm());
  }

  _loginForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('LOGIN'),
            const SizedBox(height: 30,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Text('Username'),
                 TextFormField(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Enter a username';
                     }
                     return null;
                   },
                 ),
               ],
             ),
            const SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('Password'),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }
                  return null;
                },
              ),
            ],),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    return const GalleryPage();
                  }));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
