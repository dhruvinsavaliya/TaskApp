import 'dart:convert';

import 'package:api_prec/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../utils/Shared_prefutils.dart';
import 'Home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title: const Text("Login"),
           centerTitle: true,
         ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty)
                      {
                        return "*";
                      }
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: 5.h,),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty)
                      {
                        return "*";
                      }
                  },
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: 4.h,),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
                }, child: const Text("User Don't have account Sign Up here")),
                SizedBox(height: 4.h,),
                ElevatedButton(
                    onPressed: () async{
                      FocusScope.of(context).unfocus();
                     if(formkey.currentState!.validate())
                       {

                         String msg = await isLogin(password: passController.text,username: usernameController.text);
                         if(msg == "Login Successful")
                           {
                             ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(duration: const Duration(seconds: 1),content: Text(msg),),).closed.then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),)));
                           }
                         else{
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(duration: const Duration(seconds: 1),content: Text(msg),),);
                         }
                       }

                }, child: const Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future isLogin({required String username, required String password})async
  {
    Map<String,dynamic>  reqBody =  {
      "username": username,
      "password": password
    };

    http.Response response =  await http.post(Uri.parse("http://tasks-demo.herokuapp.com/api/auth/signin"),body: reqBody);

    var result = jsonDecode(response.body);

    if(response.statusCode == 200)
      {
        await SharedPrefutils.setLogin("isLogin");
        await SharedPrefutils.setToken(result["accessToken"]);
        return "Login Successful";
      }
   else if(response.statusCode == 401){
    return result["message"];
   }else{
      return result["message"];
    }
  }
}
