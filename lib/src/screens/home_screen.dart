import 'package:ecommerce/src/data/models/item_model.dart';
import 'package:ecommerce/src/data/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseRepo firebaseRepo;

  @override
  void initState() {
    firebaseRepo = FirebaseRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/addItemPage');
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder<List<ItemModel>>(
          future: firebaseRepo.getAllItems(),
          builder: (context, snapshot) => itemList(snapshot),
        ),
      ),
    );
  }

  Widget itemList(AsyncSnapshot<List<ItemModel>> snapshot) {
    return snapshot.hasData
        ? LiquidPullToRefresh(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => item(snapshot.data![index]),
            ),
            onRefresh: () async {
              setState(() {});
            },
            animSpeedFactor: 5.0,
            springAnimationDurationInMilliseconds: 400,
            height: 80,
            color: Colors.deepPurple,
            showChildOpacityTransition: false,
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget item(ItemModel data) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        subtitle: Text(data.price),
        leading: CircleAvatar(
          child: Image.network(
            data.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
