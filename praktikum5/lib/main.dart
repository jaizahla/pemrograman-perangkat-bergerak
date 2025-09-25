import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() => runApp(BelajarImage());

class BelajarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Belajar menampilkan gambar')),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset('assets/images/croissant.jpeg', height: 100, width: 100),
              Image.network(
                'https://tse3.mm.bing.net/th/id/OIP.Ic62KfR0s-d4q9Fn_Xy6dAHaHa?pid=Api&P=0&h=180',
                height: 100,
                width: 100,
              ),
             CachedNetworkImage(
              imageUrl: "https://tse4.mm.bing.net/th/id/OIP.nlUGqRT3DJbL_4LVpDrG8gHaHa?pid=Api&P=0&h=180",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Text('Koneksi'),
             height: 100,
              width: 100,
),         
            ],
          ),
        ),
      ),
    );
  }
}