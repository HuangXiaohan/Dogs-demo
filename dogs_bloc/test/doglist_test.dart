import 'package:dio/dio.dart';
import 'package:dogs_bloc/blocs/dogListBloc.dart';
import 'package:dogs_bloc/models/dog.dart';
import 'package:test/test.dart';

void main() {
  DogListBloc dogListBloc = new DogListBloc();

  test("GetDogListFunction", () {
    dogListBloc.getDogListFunction("");
    dogListBloc.dogList.listen((data) {
      expect(data.length, 94);
    });
  });

  test("SetDogList", () async {
    var breed = {
      "bulldog": ["boston", "english", "french"]
    };
    List<Dog> dogs = await dogListBloc.setDogList(breed);
    expect(dogs[0].breed, "bulldog");
    expect(dogs[0].subBreeds, ["boston", "english", "french"]);
  });

  test("GetImage", () async {
    var dio = new Dio();
    Response r = await dio.get("https://dog.ceo/api/breed/hound/images");
    List imgList = r.data["message"];
    var imgUrl = await dogListBloc.getImage("hound");
    expect(imgList.contains(imgUrl), true);
  });
}
