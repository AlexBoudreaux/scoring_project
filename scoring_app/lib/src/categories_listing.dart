import 'package:flutter/material.dart';

import 'package:scoring_app/homePage.dart';
import 'category.dart';

class CategoriesListing extends StatelessWidget {
  final List<Category> categories;

  CategoriesListing({required this.categories});

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 20, left: 30),
          child: Text(
            'Weight       Category',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        new Expanded(
          child: new Container(
            margin: EdgeInsets.only(
              left: 20.0,
              right: 40.0,
              top: 10.0,
            ),
            child: categories.isEmpty
                ? Center(
                    child: Text('No categories found'),
                  )
                : new ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      return new Card(
                        child: new ExpansionTile(
                          title: new Text(
                            categories[i].categoryName,
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          leading: new Text(
                            categories[i].weight,
                            style: new TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            new Column(
                              children: _buildExpandableContent(categories[i]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  _buildExpandableContent(Category category) {
    List<Widget> columnContent = [];

    columnContent.add(
      new ListTile(
        tileColor: Colors.grey[100],
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                "Responses",
                style: new TextStyle(fontSize: 10.0, color: Colors.grey[700]),
              ),
              SizedBox(
                width: 800,
              ),
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: new IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
              new Text(
                "Score",
                style: new TextStyle(fontSize: 10.0, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );

    category.responses.forEach((response, weight) {
      columnContent.add(
        new ListTile(
          title: new Text(
            response,
            style: new TextStyle(fontSize: 18.0),
          ),
          leading: new Icon(Icons.arrow_right),
          trailing: new Text(
            weight,
            style: new TextStyle(fontSize: 18.0, color: Colors.grey[700]),
          ),
        ),
      );
    });

    return columnContent;
  }
}
