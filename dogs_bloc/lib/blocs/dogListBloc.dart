import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dogs_bloc/models/dog.dart';
import 'package:rxdart/subjects.dart';

class DogListBloc {
  final StreamController<String> _getDogListController =
      StreamController<String>();
  final StreamController<List<Dog>> _dogListController =
      BehaviorSubject<List<Dog>>();

  DogListBloc() {
    _getDogListController.stream.listen(getDogListFunction);
  }

  Stream<List<Dog>> get dogList => _dogListController.stream;

  Sink<String> get getDogList => _getDogListController.sink;

  void getDogListFunction(arg) async {
    List<Dog> dogList = [];
    var dio = Dio();
    Response response;
    try {
      response = await dio.get("https://dog.ceo/api/breeds/list/all");
      var data = response.data["message"];
      dogList = await setDogList(data);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    _dogListController.sink.add(dogList);
  }

  Future<List<Dog>> setDogList(var data) async {
    List<Dog> list = [];
    dynamic breeds = data.keys;
    for (var breed in breeds) {
      String imgUrl = await getImage(breed);
      Dog dog = new Dog(breed, data[breed], imgUrl);
      list.add(dog);
    }

    return list;
  }

  Future<String> getImage(var breed) async {
    var dio = Dio();
    String imgUrl = "";
    Response response;
    var url = "https://dog.ceo/api/breed/" + breed + "/images/random";
    try {
      response = await dio.get(url);
      imgUrl = response.data["message"];
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
    return imgUrl;
  }

  dispose() {
    _dogListController.close();
    _getDogListController.close();
  }
}
