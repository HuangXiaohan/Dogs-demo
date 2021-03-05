import 'package:dio/dio.dart';
import 'package:dogs_provider/models/dog.dart';
import 'package:dogs_provider/providers/dogListProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DogListProvider dogListProvider = new DogListProvider();
  test("Get Dogs", () {
    dogListProvider.getDogs();
    dogListProvider.addListener(() {
      expect(dogListProvider.dogList.length, 94);
    });
  });

  test("Set Dog List", () async {
    var breed = {
      "bulldog": ["boston", "english", "french"]
    };
    List<Dog> dogs = await dogListProvider.setDogList(breed);
    dogListProvider.addListener(() {
      expect(dogs[0].breed, "bulldog");
      expect(dogs[0].subBreeds, ["boston", "english", "french"]);
    });
  });

  test("Get Image", () async {
    var dio = new Dio();
    Response r = await dio.get("https://dog.ceo/api/breed/hound/images");
    List imgList = r.data["message"];
    var imgUrl = await dogListProvider.getImage("hound");
    expect(imgList.contains(imgUrl), true);
  });
}
