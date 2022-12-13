import 'package:api_prec/api/repo/get_all_task_repo.dart';
import 'package:api_prec/controller/get_task_controller.dart';
import 'package:api_prec/utils/Shared_prefutils.dart';
import 'package:api_prec/view/updateScreen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../api/model/res_model/taskapp_res_model.dart';
import 'CreateScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<GetTaskController>(context, listen: false).getTaskData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      drawer: Drawer(),
      body: Consumer<GetTaskController>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.model == null) {
            return const Center(
              child: Text('Data Not Found'),
            );
          }
          List<TaskappResModel>? model = value.model;

          return Shimmer.fromColors(
            baseColor: Colors.green,
            highlightColor: Colors.blueGrey,
            child: ListView.builder(
              itemCount: model!.length,
              itemBuilder: (context, index) {
                var data = model[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    deleteTask(id: data.id.toString());
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpadateScreen(
                              id: data.id.toString(),
                              description: data.description,
                              status: data.status),
                        ),
                      );
                    },
                    title: Text("${data.description}"),
                    subtitle: Text("${data.status}"),
                  ),
                );
              },
            ),
          );
        },
      ),
      //  body: FutureBuilder<List<TaskappResModel>>(
      //   future: GetAllTaskRepo.getAllTaskRepo(),
      //   builder: (context, AsyncSnapshot<List<TaskappResModel>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return Shimmer.fromColors(
      //         baseColor: Colors.green,
      //         highlightColor: Colors.blueGrey,
      //         child: ListView.builder(
      //           itemCount: snapshot.data!.length,
      //           itemBuilder: (context, index) {
      //             var data = snapshot.data![index];
      //             return Dismissible(
      //               key: UniqueKey(),
      //               onDismissed: (direction) {
      //                 deleteTask(id: data.id.toString());
      //               },
      //               child: ListTile(
      //                 onTap: () {
      //                   Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => UpadateScreen(
      //                           id: data.id.toString(),
      //                           description: data.description,
      //                          status: data.status),
      //                     ),
      //                   );
      //                 },
      //                 title: Text("${data.description}"),
      //                 subtitle: Text("${data.status}"),
      //               ),
      //             );
      //           },
      //         ),
      //       );
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CreateScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future deleteTask({String? id}) async {
    Map<String, String> header = {'x-access-token': SharedPrefutils.getToken()};
    http.Response response = await http.delete(
      Uri.parse("http://tasks-demo.herokuapp.com/api/tasks/$id"),
      headers: header,
    );

    if (response.statusCode == 200) {}
  }
}
