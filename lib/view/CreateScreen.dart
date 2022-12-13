import 'dart:developer';
import 'package:api_prec/api/repo/CreateTaskRepo.dart';
import 'package:api_prec/view/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../api/model/req_model/task_req_model.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController descController = TextEditingController();
  String? isSelected = "Done";
  TaskReqModel reqModel = TaskReqModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " * ";
                    } else {
                      return null;
                    }
                  },
                  controller: descController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                DropdownButton<String>(
                  value: isSelected,
                  items: ["Done", "Pending"].map(
                    (e) {
                      return DropdownMenuItem<String>(child: Text(e), value: e);
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      isSelected = value;
                    });
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        reqModel.description = descController.text;

                        reqModel.status =
                            isSelected == "Done" ? "true" : "false";

                        log("====>${reqModel.toJson()}");

                        String msg = await CreateTask.createtaskrepo(
                            reqbody: reqModel.toJson());
                        if (msg == "task created") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                const SnackBar(
                                  elevation: double.maxFinite,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.up,
                                  duration: Duration(seconds: 1),
                                  content: Text("Task Created"),
                                ),
                              )
                              .closed
                              .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("Task was Not Created")));
                        }
                      }
                    },
                    child: const Text("Create Task"))
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future<bool>? CreateTask({required Map<String, dynamic> reqBody}) async {
//   Map<String, String> header = {'x-access-token': SharedPrefutils.getToken()};
//   http.Response response = await http.post(
//       Uri.parse("http://tasks-demo.herokuapp.com/api/tasks"),
//       headers: header,
//       body: reqBody);
//
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }
}
