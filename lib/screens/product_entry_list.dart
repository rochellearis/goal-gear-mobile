import 'package:flutter/material.dart';
import 'package:goal_gear/models/product_entry.dart';
import 'package:goal_gear/widgets/left_drawer.dart';
import 'package:goal_gear/screens/product_detail.dart';
import 'package:goal_gear/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool onlyMine;

  const ProductEntryListPage({super.key, this.onlyMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late bool _onlyMine;

  @override
  void initState() {
    super.initState();
    _onlyMine = widget.onlyMine; // gunakan nilai dari konstruktor
  }

  Future<List<ProductEntry>> fetchProduct(CookieRequest request, {bool onlyMine = false}) async {
    final baseUrl = 'http://localhost:8000/json/';
    final url = onlyMine ? '$baseUrl?filter=my' : baseUrl;

    final response = await request.get(url);
    var data = response;

    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_onlyMine ? 'My Products' : 'Product Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: fetchProduct(request, onlyMine: _onlyMine),
        builder: (context, AsyncSnapshot<List<ProductEntry>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                _onlyMine
                  ? 'You have no products yet.'
                  : 'There are no products in Goal Gear yet.',
                style: const TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => ProductEntryCard(
                product: snapshot.data![index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product: snapshot.data![index],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}