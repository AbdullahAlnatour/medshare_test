import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> cartItems = [
    CartItem(
      name: 'Oxycontin 10mg',
      quantity: 2,
      image: Icons.medication,
    ),
    CartItem(
      name: 'Amoxicillin 500mg',
      quantity: 1,
      image: Icons.medication_liquid,
    ),
    CartItem(
      name: 'Medical Gloves',
      quantity: 3,
      image: Icons.medical_services,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Cart",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? _buildEmptyCart()
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Cart items
                        ...cartItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return _buildCartItem(item, index);
                        }),
                      ],
                    ),
                  ),
          ),
          // Donate button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  // Handle donation
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF1F5A6E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF34AFB7).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.image,
              color: const Color(0xFF34AFB7),
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Quantity: ${item.quantity}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFF34AFB7),
                onPressed: () {
                  setState(() {
                    if (item.quantity > 1) {
                      item.quantity--;
                    } else {
                      cartItems.removeAt(index);
                    }
                  });
                },
              ),
              Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFF34AFB7),
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

}

class CartItem {
  String name;
  int quantity;
  IconData image;

  CartItem({
    required this.name,
    required this.quantity,
    required this.image,
  });
}

