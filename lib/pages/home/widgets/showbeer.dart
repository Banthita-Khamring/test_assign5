import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_assign5/models/beer.dart';

class Mywidget extends StatefulWidget {
  const Mywidget({super.key});

  @override
  State<Mywidget> createState() => _MywidgetState();
}

class _MywidgetState extends State<Mywidget> {
  List? _beer;

  void _getBeer() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response = await dio.get('https://api.sampleapis.com/beers/ale');

    List list = jsonDecode(response.data.toString());
    setState(
      () {
        _beer = list.map((item) => Beer.fromJson(item)).toList();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getBeer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _beer == null
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: _beer!.length,
                  itemBuilder: (context, index) {
                    var recipe = _beer![index];
                    return ListTile(
                      title: Text('${recipe.name ?? ''}'),
                      subtitle: Text('price: ${recipe.price ?? ''}'),
                      trailing: recipe.image == ''
                          ? null
                          : Image.network(
                              recipe.image ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                      onTap: () {
                        print('index $index');
                        print('You Click country name: ${recipe.name}');
                        _showInfo(index);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showInfo(index) async {
    var beers = _beer![index];
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          '${beers.name ?? ''}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 118, 6, 146),
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.network(
                beers.image ?? '',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment, color: Colors.green),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'price: ${beers.price ?? ''}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.comment_outlined, color: Colors.blue),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Reviews: ${beers.reviews ?? ''}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Average: ${beers.average.toStringAsFixed(4) ?? ''}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
