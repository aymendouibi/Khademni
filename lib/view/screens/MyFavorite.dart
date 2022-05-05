import 'package:flutter/material.dart';
import 'package:memoire/constant/firebase.dart';

class MyFavorite extends StatelessWidget {
  const MyFavorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final favorite = firebaseFirestore
        .collection('user')
        .doc(auth.currentUser.uid)
        .collection('favorite');

    return StreamBuilder(
      stream: favorite.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data.docs[index];
              return SizedBox(
                width: size.width,
                height: 120,
                child: Card(
                    child: Row(
                  children: [
                    Image.network(
                      data['image'],
                      width: size.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                    Text(data['title'])
                  ],
                )),
              );
            },
          );
        }
      },
    );
  }
}
