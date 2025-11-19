import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goal_gear/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:goal_gear/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0; // default
    String _description = "";
    String _category = "jersey"; // default
    String _thumbnail = "";
    bool _isFeatured = false; // default
    int _stock = 0; // default
    String _brand = "";

    final List<String> _categories = [
      "jersey",
      "sepatu",
      "bola",
      "merchandise",
      "accessory",
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Add Product Form',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          drawer: const LeftDrawer(), // Tambahkan drawer yang sudah dibuat di sini
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  // === Title ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nama Produk",
                        labelText: "Nama Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Price ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Harga Produk (angka saja)",
                        labelText: "Harga Produk (Rp)",
                        prefixText: "Rp ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          // Jika parsing gagal, tetap set ke 0
                          _price = int.tryParse(value ?? "") ?? 0;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Harga tidak boleh kosong!";
                        }
                        final parsed = int.tryParse(value);
                        if (parsed == null) {
                          return "Harga harus berupa angka!";
                        }
                        if (parsed <= 0) {
                          return "Harga harus lebih besar dari 0!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Description ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Deskripsi Produk",
                        labelText: "Deskripsi Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Deskripsi tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Category ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Kategori",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      initialValue: _category,
                      items: _categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(
                                    cat[0].toUpperCase() + cat.substring(1)),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue!;
                        });
                      },
                    ),
                  ),

                  // === Thumbnail URL ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "URL Thumbnail (opsional)",
                        labelText: "URL Thumbnail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _thumbnail = value!;
                        });
                      },
                    ),
                  ),

                  // === Is Featured ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SwitchListTile(
                      title: const Text("Tandai sebagai Produk Unggulan"),
                      value: _isFeatured,
                      onChanged: (bool value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                    ),
                  ),
                  // === Stock ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Jumlah Stok (angka saja)",
                        labelText: "Stok",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          _stock = int.tryParse(value ?? "") ?? 0;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Stok tidak boleh kosong!";
                        }
                        final parsed = int.tryParse(value);
                        if (parsed == null) {
                          return "Stok harus berupa angka!";
                        }
                        if (parsed < 0) {
                          return "Stok tidak boleh negatif!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Brand ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Brand Produk",
                        labelText: "Brand",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _brand = value ?? "";
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Brand tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Tombol Simpan ===
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.indigo),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Replace the URL with your app's URL
                                    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                                    // If you using chrome,  use URL http://localhost:8000
                                    
                                    final response = await request.postJson(
                                      "http://localhost:8000/create-flutter/",
                                      jsonEncode({
                                        "name": _name,
                                        "price": _price,
                                        "description": _description,
                                        "category": _category,
                                        "thumbnail": _thumbnail,
                                        "is_featured": _isFeatured,
                                        "stock": _stock,
                                        "brand": _brand,
                                      }),
                                    );
                                    if (context.mounted) {
                                      // Terima dua kemungkinan:
                                      // 1) server mengembalikan {"status":"success", ...}
                                      // 2) server mengembalikan object product (mengandung 'id')
                                      if ((response is Map && response['status'] == 'success') ||
                                          (response is Map && (response['id'] != null || (response['product']?['id'] != null)))) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Product successfully saved!"),
                                        ));
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyHomePage()),
                                        );
                                      } else {
                                        // tampilkan pesan error yang lebih informatif jika ada
                                        final serverMsg = response is Map && response['message'] != null
                                            ? response['message']
                                            : 'Something went wrong, please try again.';
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(serverMsg),
                                        ));
                                      }
                                    }
                                  }
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                    ),
                  ),

                ],
              )
            ),
          ),
        );
    }
}