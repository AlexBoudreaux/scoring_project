import 'package:flutter/material.dart';

import 'src/categories_listing.dart';
import 'src/api.dart';
import 'src/category.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final CategoriesApi api = CategoriesApi();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories([bool showSpinner = false]) {
    if (showSpinner) {
      setState(() {
        loading = true;
      });
    }

    widget.api.getCategories().then((data) {
      setState(() {
        categories = data;
        loading = false;
      });
    });
  }

  void _addCategory(/*String category, String weight*/) async {

    final createdCategory = await widget.api.createCategory('category', 'weight');
    setState(() {
      categories.add(createdCategory);
    });

    _loadCategories(true);
  }
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue[900],
          leadingWidth: 140,
          leading: Container(
              padding: EdgeInsets.only(left: 30.0, top: 3.0, bottom: 3.0),
              child: Image.asset(
                'ibm_PNG19658.png',
                fit: BoxFit.fitHeight,
              )),
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 45.0),
              child: ElevatedButton(
                  child: Text("Add Category", style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.white, width: 2.0)))),
                  onPressed: () => _addCategory(/*category, weight*/)),
            )
          ]
      ),
      body: loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : CategoriesListing(
          categories: categories,
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _loadCategories(true);
            },
            tooltip: 'Refresh list',
            backgroundColor: Colors.blue[900],
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addCategory,
            tooltip: 'Add new contact',
            backgroundColor: Colors.blue[900],
            child: Icon(Icons.add),
          ),])
    );
  }
}
