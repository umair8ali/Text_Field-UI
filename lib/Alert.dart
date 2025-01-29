import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailError = '';
  String passwordError = '';

  void _validateEmail() {
    String email = emailController.text;
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    setState(() {
      if (email.isEmpty) {
        emailError = 'Please Enter an Email.';
      } else if (!regex.hasMatch(email)) {
        emailError = 'Invalid Email Format';
      } else {
        emailError = ''; //Clear Error if Email is Valid.
      }
    });
  }
  
  void _validatePassword() {
    String password = passwordController.text;

    setState(() {
      if (password.isEmpty) {
        passwordError = 'Please Enter the Password';
      } else if (password.length < 6) {
        passwordError = 'Password must be atleast 6 characters';
      } else {
        passwordError = ''; //Clear Error if Password is Valid.
      }
    });
  }

  //Functions to show the alert dialog.
  void _showDetails() {
    _validateEmail();
    _validatePassword();

    // if(email.isEmpty){
    //   return ;      //Do nothing if email is empty.
    // }

    // if(password.isEmpty){
    //   return ;      //Do nothing if password is empty.
    // }

    // if (email.isEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('Error!'),
    //           content: const Text('Please Enter an Email.'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('Ok')),
    //           ],
    //         );
    //       });
    // }

    // else if (password.isEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('Error!'),
    //           content: const Text('Please Enter the Password.'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('Ok')),
    //           ],
    //         );
    //       });
    // }
    if (emailError.isEmpty && passwordError.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Details Entered'),
              content: Text(
                  'Email: ${emailController.text}\nPassword: ${passwordController.text}'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      emailController.clear();
                      passwordController.clear();
                    },
                    child: const Text('Ok')),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter the Email.',
                border: const OutlineInputBorder(),
                errorText: emailError.isNotEmpty ? emailError : null, //Show Error Under Field.
              ),
              onChanged: (value) {
                _validateEmail();
              },
            ),

            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter the Password.',
                border: const OutlineInputBorder(),
                errorText: passwordError.isNotEmpty ? passwordError : null, //Show Error Under Field.
              ),
              onChanged: (value){
                _validatePassword();
              },
            ),

            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _showDetails();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
