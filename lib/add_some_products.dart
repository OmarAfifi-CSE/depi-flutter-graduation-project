import 'dart:ui';

import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/category_model.dart';
import 'models/product_model.dart';

// Assume ProductModel, ProductColor, ProductVariant are already defined

final List<ProductModel> demoProducts = [
  // 1) T-Shirt – Blue / White
  ProductModel(
    id: 'p01',
    name: 'Men\'s Casual T-Shirt',
    subtitle: 'Comfortable Cotton Tee',
    description: 'Comfortable cotton T-shirt suitable for daily use.',
    category: 'Clothing',
    price: 299.0,
    salePrice: 249.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
    availableColors: [
      ProductColor(
        colorCode: '#1E88E5',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235375/4be8bff7-f9d8-4da9-992d-734ed8d0e633.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927979/5982781e-0c3c-4716-b606-657e5aedc177.jpg?format=webp&width=800',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#1E88E5', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#1E88E5', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#1E88E5', size: 'L', stock: 8, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'M', stock: 9, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'L', stock: 7, id: ''),
    ],
  ),

  // 2) Hoodie – Dark Blue / White
  ProductModel(
    id: 'p02',
    name: 'Padded Hoodie',
    subtitle: 'Warm & Cozy Outerwear',
    description: 'Warm high-quality hoodie, perfect for evening outings.',
    category: 'Clothing',
    price: 599.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235375/4be8bff7-f9d8-4da9-992d-734ed8d0e633.jpg?format=webp&width=800',
    availableColors: [
      ProductColor(
        colorCode: '#1565C0',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235375/4be8bff7-f9d8-4da9-992d-734ed8d0e633.jpg?format=webp&width=800',
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#1565C0', size: 'M', stock: 10, id: ''),
      ProductVariant(color: '#1565C0', size: 'L', stock: 6, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'L', stock: 5, id: ''),
    ],
  ),

  // 3) Jeans
  ProductModel(
    id: 'p03',
    name: 'Men\'s Slim Fit Jeans',
    subtitle: 'Durable Denim',
    description: 'Durable and comfortable slim fit denim jeans.',
    category: 'Clothing',
    price: 749.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
    availableColors: [
      ProductColor(
        colorCode: '#0D47A1',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#000000',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#0D47A1', size: '30', stock: 8, id: ''),
      ProductVariant(color: '#0D47A1', size: '32', stock: 12, id: ''),
      ProductVariant(color: '#000000', size: '32', stock: 5, id: ''),
    ],
  ),

  // 4) Sneakers – White / Blue
  ProductModel(
    id: 'p04',
    name: 'Lightweight Sneakers',
    subtitle: 'Running & Training Shoes',
    description: 'Comfortable sneakers for running and daily workouts.',
    category: 'Footwear',
    price: 899.0,
    salePrice: 799.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
    availableColors: [
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#1E88E5',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#FFFFFF', size: '41', stock: 6, id: ''),
      ProductVariant(color: '#FFFFFF', size: '42', stock: 9, id: ''),
      ProductVariant(color: '#1E88E5', size: '42', stock: 7, id: ''),
    ],
  ),

  // 5) Backpack
  ProductModel(
    id: 'p05',
    name: 'Everyday Backpack',
    subtitle: 'Water-Resistant Large Capacity',
    description: 'Durable water-resistant backpack with large capacity.',
    category: 'Accessories',
    price: 399.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
    variants: [
      ProductVariant(color: '#1976D2', size: 'OneSize', stock: 14, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'OneSize', stock: 10, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#1976D2',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),

  // 6) Cap
  ProductModel(
    id: 'p06',
    name: 'Casual Cap',
    subtitle: 'Adjustable Logo Cap',
    description: 'Adjustable fabric cap with a simple logo.',
    category: 'Accessories',
    price: 129.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235375/4be8bff7-f9d8-4da9-992d-734ed8d0e633.jpg?format=webp&width=800',
    variants: [
      ProductVariant(color: '#1E88E5', size: 'OneSize', stock: 22, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'OneSize', stock: 12, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#1E88E5',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),

  // 7) Summer Dress
  ProductModel(
    id: 'p07',
    name: 'Elegant Summer Dress',
    subtitle: 'Light Casual Dress',
    description: 'Light dress suitable for summer and casual events.',
    category: 'Clothing',
    price: 899.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
    variants: [
      ProductVariant(color: '#FFFFFF', size: 'S', stock: 5, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'M', stock: 7, id: ''),
      ProductVariant(color: '#64B5F6', size: 'M', stock: 4, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#64B5F6',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),

  // 8) Swim Shorts
  ProductModel(
    id: 'p08',
    name: 'Swim Shorts',
    subtitle: 'Beach & Water Activities',
    description: 'Light shorts suitable for the beach and water activities.',
    category: 'Clothing',
    price: 199.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
    variants: [
      ProductVariant(color: '#1E88E5', size: 'M', stock: 18, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'L', stock: 12, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#1E88E5',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),

  // 9) Handbag
  ProductModel(
    id: 'p09',
    name: 'Small Handbag',
    subtitle: 'Elegant Occasion Bag',
    description: 'Elegant handbag for small occasions and outings.',
    category: 'Accessories',
    price: 459.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
    variants: [
      ProductVariant(color: '#FFFFFF', size: 'OneSize', stock: 9, id: ''),
      ProductVariant(color: '#1976D2', size: 'OneSize', stock: 6, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#1976D2',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),

  // 10) Socks Pack
  ProductModel(
    id: 'p10',
    name: 'Sports Socks Pack (3 Pairs)',
    subtitle: 'Stretchy & Comfortable',
    description: 'Pack of 3 stretchy and comfortable sports socks.',
    category: 'Clothing',
    price: 129.0,
    thumbnail:
        'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235375/4be8bff7-f9d8-4da9-992d-734ed8d0e633.jpg?format=webp&width=800',

    variants: [
      ProductVariant(color: '#1E88E5', size: 'OneSize', stock: 30, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'OneSize', stock: 25, id: ''),
    ],
    availableColors: [
      ProductColor(
        colorCode: '#1E88E5',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z0D8834DCC87D458BCCA9Z/45/1755235376/1a642c19-bacc-4c95-bf57-2f87d826f973.jpg?format=webp&width=800',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://f.nooncdn.com/p/pzsku/Z1185D42B4C26270C6C11Z/45/1752927980/18d84622-8f63-456e-a798-6c9e3f54f203.jpg?format=webp&width=800',
        ],
      ),
    ],
  ),
];
Future<void> addDemoCategories() async {
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  final List<CategoryModel> demoCategories = [
    CategoryModel(
      name: 'Clothing',
      image:
          'https://img.freepik.com/free-photo/fashion-clothes-hanger_1203-7544.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Footwear',
      image: 'https://img.freepik.com/free-photo/pair-trainers_144627-3800.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Accessories',
      image:
          'https://img.freepik.com/free-photo/elegant-leather-handbag_1203-7489.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Men\'s Wear',
      image:
          'https://img.freepik.com/free-photo/man-wearing-suit_144627-19132.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Women\'s Wear',
      image:
          'https://img.freepik.com/free-photo/woman-holding-shopping-bags_144627-40565.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Kids\' Wear',
      image:
          'https://img.freepik.com/free-photo/little-boy-girl-posing_144627-51280.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Sportswear',
      image:
          'https://img.freepik.com/free-photo/full-shot-man-training-outdoors_23-2149026265.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Formal Wear',
      image:
          'https://img.freepik.com/free-photo/young-businessman-formal-suit_144627-30793.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Bags',
      image:
          'https://img.freepik.com/free-photo/leather-handbags-display-store_1203-7547.jpg',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      name: 'Jewelry',
      image:
          'https://img.freepik.com/free-photo/golden-jewelry-wooden-display_1203-7561.jpg',
      createdAt: DateTime.now(),
    ),
  ];

  for (final category in demoCategories) {
    await FirebaseFirestore.instance
        .collection("categories")
        .add(category.toJson());
  }
}

Future<void> addAllDemoProducts() async {
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  for (var product in demoProducts) {
    await fireBaseFireStore.addProduct(product);
  }
}
