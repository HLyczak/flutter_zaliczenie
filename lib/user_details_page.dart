import 'package:flutter/material.dart';
import 'package:flutter_zaliczenie/favorite_list.dart';
import 'package:flutter_zaliczenie/post.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final favorite_list = Provider.of<FavoriteList>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          title: const Text('Swapper'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          backgroundColor: Colors.purple,
        ),
        body: Center(
            child: Container(
          height: 580,
          width: 340,
          child: Stack(
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    user.picture ?? "",
                    fit: BoxFit.fitWidth,
                    width: 400,
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                child: Container(
                  width: 340,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.first ?? " ",
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          user.location ?? " ",
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          user.email ?? " ",
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          user.phone ?? " ",
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          color: favorite_list.isFavorite(user)
                              ? Colors.red
                              : Colors.grey,
                          onPressed: () {
                            favorite_list.add(user);

                            // Do something when the button is pressed
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
