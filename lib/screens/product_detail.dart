import 'package:flutter/material.dart';
import 'package:goal_gear/models/product_entry.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  // Simple currency formatter (thousand separators) without intl
  String _formatCurrency(int value) {
    var s = value.toString();
    var result = <String>[];
    for (var i = s.length; i > 0; i -= 3) {
      var start = i - 3;
      if (start < 0) start = 0;
      result.insert(0, s.substring(start, i));
    }
    return result.join('.');
  }

  Widget _buildRatingStars(int rating) {
    final clamped = rating.clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < clamped) {
          return const Icon(Icons.star, size: 18);
        } else {
          return const Icon(Icons.star_border, size: 18);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final priceLabel = 'IDR ${_formatCurrency(product.price)}';
    final stockLabel = product.stock > 0 ? '${product.stock} in stock' : 'Out of stock';
    final owner = product.userUsername ?? 'Unknown seller';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image (with same proxy approach)
            if (product.thumbnail.isNotEmpty)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 260,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 56)),
                ),
              )
            else
              Container(
                height: 260,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image_not_supported, size: 56)),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured badge
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Category + Brand + Price row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        product.brand,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      const Spacer(),
                      Text(
                        priceLabel,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Stock + Rating + Owner
                  Row(
                    children: [
                      Icon(Icons.storage, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        stockLabel,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      _buildRatingStars(product.rating),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.rating})',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            owner,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // Full description
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16.0, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: product.stock > 0
                              ? () {
                                  // placeholder: implement actual "add to cart / buy" logic
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added "${product.name}" to cart (placeholder)')),
                                  );
                                }
                              : null,
                          child: const Text('Buy'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // placeholder: implement contact seller or open detailUrl
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Contacting seller: $owner (placeholder)')),
                            );
                          },
                          child: const Text('Contact Seller'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Owner-only delete button (visual only)
                  if (product.isOwner)
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: const Text('Are you sure you want to delete this product?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
                                    TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
                                  ],
                                ),
                              ) ??
                              false;

                          if (confirmed) {
                            // Dapatkan request dari Provider
                            final request = context.read<CookieRequest>();
                            
                            // Tentukan URL (sesuaikan dengan environment Anda)
                            // Gunakan 10.0.2.2 untuk Emulator Android, localhost untuk Web/iOS Simulator
                            String url = 'http://10.0.2.2:8000/delete-flutter/${product.id}/';

                            try {
                              // Lakukan Request ke Django
                              final response = await request.postJson(
                                url,
                                jsonEncode({}), // Body kosong tidak masalah untuk delete by ID di URL
                              );

                              if (context.mounted) {
                                if (response['status'] == 'success') {
                                  // Jika berhasil, beri notifikasi dan kembali ke halaman sebelumnya
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Product successfully deleted!")),
                                  );
                                  Navigator.of(context).pop(); // Kembali ke list product
                                } else {
                                  // Jika gagal dari sisi server
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Failed to delete: ${response['message']}")),
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            }
                          }
                        },
                        child: const Text('Delete product'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}