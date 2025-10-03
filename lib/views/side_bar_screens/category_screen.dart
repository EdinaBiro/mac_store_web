import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: 
        const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
        child: Text('Categories', style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),),
        ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Divider(color: Colors.grey),
        ),
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('Category image'),)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText:'Enter Category Name'
                  ),
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: Text('cancel'),
            ),
            ElevatedButton(onPressed: (){}, child: Text('Save',
            ),),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){}, child: Text('Pick image'),),
        ),
        Divider(color: Colors.grey,
        ),
      ],
    );
  }
}