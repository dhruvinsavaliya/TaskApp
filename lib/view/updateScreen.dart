import 'package:api_prec/api/repo/UpdateTaskRepo.dart';
import 'package:api_prec/view/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../api/model/req_model/task_req_model.dart';
import '../utils/Shared_prefutils.dart';

class UpadateScreen extends StatefulWidget {
  const UpadateScreen({
    Key? key,
    required this.id,
    required this.description,
    required this.status,
  }) : super(key: key);
  final String? id;
  final String? description;
  final bool? status;

  @override
  State<UpadateScreen> createState() => _UpadateScreenState();
}

class _UpadateScreenState extends State<UpadateScreen> {
  TextEditingController? descController;

  String? id;
  String? description;
  bool? status;
  String? isSelected;

  TaskReqModel resmodel = TaskReqModel();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    id = widget.id;
    isSelected = widget.status == true ? "Done" : "Pending";
    description = widget.description;
    descController = TextEditingController(text: description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " * ";
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
                        resmodel.description = descController!.text;
                        resmodel.status =
                            isSelected == "Done" ? "true" : "false";

                        String msg = await UpdateTask.updtetaskrepo(
                            reqbody: resmodel.toJson(), id: id);
                        if (msg == "task updated") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                const SnackBar(
                                  elevation: double.maxFinite,
                                  backgroundColor: Colors.deepPurpleAccent,
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.up,
                                  duration: Duration(seconds: 1),
                                  content: Text("Task Updated"),
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
                                  content: Text("Task was Not Update")));
                        }
                      }
                    },
                    child: const Text("Update Task"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
