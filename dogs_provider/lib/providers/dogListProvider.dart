import 'package:dio/dio.dart';
import 'package:dogs_provider/models/dog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DogListProvider extends ChangeNotifier {
  List<Dog> _dogList = [];

  List<Dog> get dogList => _dogList;

  void getDogs() async {
    _dogList.clear();
    var dio = Dio();
    Response response;
    try {
      response = await dio.get("https://dog.ceo/api/breeds/list/all");
      var data = response.data["message"];
      _dogList = await setDogList(data);
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

    //print(_dogList.length);
    notifyListeners();
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
    //print(imgUrl);
    return imgUrl;
  }
}
