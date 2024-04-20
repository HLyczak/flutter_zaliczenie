import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_zaliczenie/chat_page.dart';
import 'package:flutter_zaliczenie/favorite_list.dart';
import 'package:flutter_zaliczenie/favorite_user_list_page.dart';
import 'package:flutter_zaliczenie/post.dart';
import 'package:flutter_zaliczenie/user_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// app starting point
void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swapper'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteUserListPage(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body: const Center(child: UsersList()),
    );
  }
}

// homepage class
class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

// homepage state
class _UsersListState extends State<UsersList> {
  // variable to call and store future list of posts
  Future<List<User>> usersFuture = getUsers();

  // function to fetch data from api and return future list of posts
  static Future<List<User>> getUsers() async {
    var url = Uri.parse("https://randomuser.me/api/?results=200");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body)['results'];
    return body.map((e) => User.fromJson(e)).toList();
  }

  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<User>>(
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final users = snapshot.data!;
              return buildUser(users);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildUser(List<User> users) {
    // ListView Builder to show data in a list
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  users.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${user.first} dismissed')));
              },
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(user),
                      ),
                    );
                  },
                  title: Text(
                    '${user.first!} ${user.last!}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400), // niezmienne
                  ),
                  subtitle: Text(user.location!),
                  dense: true,
                  visualDensity:
                      const VisualDensity(vertical: 4), // zwiększa wysokość
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(300), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(35), // Image radius
                      child: Image.network(
                        user.picture!,
                        fit: BoxFit.cover,
                        height: 0,
                      ),
                    ),
                  )));
        });
  }
}
