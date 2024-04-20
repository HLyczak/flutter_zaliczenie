import 'package:flutter/material.dart';
import 'package:flutter_zaliczenie/chat_page.dart';
import 'package:flutter_zaliczenie/favorite_list.dart';
import 'package:provider/provider.dart';

class FavouriteUserListPage extends StatelessWidget {
  FavouriteUserListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final favorite_list = Provider.of<FavoriteList>(context);

    return Scaffold(
        //appbar i body
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          title: const Text('Swapper '),
          backgroundColor: Colors.purple,
        ),
        body: Expanded(
            child: GridView(
          padding: const EdgeInsets.all(40),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ...favorite_list.users.map((user) => InkWell(
                  //ink efekt specjalny po kliku mapowanie userow na list4e widgetow inkwell
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(user),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        user.picture ?? '',
                      ),
                      Text("${user.first ?? ''} ${user.last ?? ''}")
                    ],
                  ),
                ))
          ],
        )));
  }
}
