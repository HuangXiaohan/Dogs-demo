import 'package:dogs_bloc/models/dog.dart';
import 'package:dogs_bloc/resources/dogListBlocProvider.dart';
import 'package:flutter/material.dart';

class DogList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DogList();
}

class _DogList extends State<DogList> {
  _DogList() : super();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Dog>>(
        stream: DogListBlocProvider.of(context).dogList,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                var subBreeds = '';
                for (int i = 0;
                    i < snapshot.data[index].subBreeds.length - 1;
                    i++) {
                  subBreeds += snapshot.data[index].subBreeds[i] + "  ";
                }
                return GestureDetector(
                  onTap: () {
                    _showFullModal(context, snapshot.data[index], subBreeds);
                  },
                  child: Card(
                    child: Container(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].imageUrl),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 14,
                            child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data[index].breed.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(subBreeds,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  _showFullModal(context, Dog dog, var subBreeds) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: dog.breed,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                dog.breed.toUpperCase(),
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20),
              ),
              elevation: 0.0),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xfff8f8f8),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(dog.imageUrl), fit: BoxFit.fill)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(dog.breed.toUpperCase(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                        "SubBreeds:  ${subBreeds == "" ? '-' : subBreeds}",
                        style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        );
      },
    );
  }
}
