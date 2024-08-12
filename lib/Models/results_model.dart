import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsModel {
  late String result;
  late String time;


  ResultsModel({
    required this.result,
    required this.time,

  });

  ResultsModel.fromSnapshot(QueryDocumentSnapshot<Map<dynamic,dynamic>> snapshot)
      : result=snapshot['result'],
        time=snapshot['time'];


  ResultsModel.fromJson(Map<dynamic, dynamic> json) {
    result = json["result"];
    time = json["time"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['time'] = time;

    return data;
  }

  ResultsModel clone() {
    return ResultsModel(result: result, time: time,);
  }
}
