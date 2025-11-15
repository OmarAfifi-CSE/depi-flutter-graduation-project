import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';

// Assume ProductModel, ProductColor, ProductVariant are already defined

final List<ProductModel> demoProducts = [
  ProductModel(
    id: 'p01',
    name: 'Textured Camp Collar Shirt with Short Sleeves',
    subtitle: 'Textured Cotton Shirt',
    description: 'Textured cotton shirt perfect for casual outings.',
    categoryName: 'Men',
    price: 99,
    salePrice: 45,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624201/images/7009624201_1.jpg?v=1',
    availableColors: [
      ProductColor(
        colorCode: '#000000',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624201/images/7009624201_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624201/images/7009624201_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624201/images/7009624201_3.jpg?v=1',
        ],
      ),
      ProductColor(
        colorCode: '#E4E8EB',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624202/images/7009624202_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624202/images/7009624202_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624202/images/7009624202_3.jpg?v=1',
        ],
      ),
      ProductColor(
        colorCode: '#CBC5B6',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624214/images/7009624214_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624214/images/7009624214_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7009624214/images/7009624214_3.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#000000', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#000000', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#000000', size: 'L', stock: 8, id: ''),
      ProductVariant(color: '#E4E8EB', size: 'M', stock: 9, id: ''),
      ProductVariant(color: '#E4E8EB', size: 'L', stock: 7, id: ''),
      ProductVariant(color: '#CBC5B6', size: 'XL', stock: 9, id: ''),
    ],
  ),
  ProductModel(
    id: 'p0111',
    name: 'Light Wash Mid Rise Straight Fit Jeans',
    subtitle: 'Light Wash Denim',
    description: 'Light wash denim jeans with a straight fit.',
    categoryName: 'Men',
    price: 98,
    salePrice: 78,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7008053103/images/7008053103_1.jpg?v=3',
    availableColors: [
      ProductColor(
        colorCode: '#7A909F',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7008053103/images/7008053103_1.jpg?v=3',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7008053103/images/7008053103_2.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7008053103/images/7008053103_3.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7008053103/images/7008053103_4.jpg?v=2',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#7A909F', size: '30', stock: 15, id: ''),
      ProductVariant(color: '#7A909F', size: '32', stock: 25, id: ''),
      ProductVariant(color: '#7A909F', size: '34', stock: 8, id: ''),
      ProductVariant(color: '#7A909F', size: '36', stock: 9, id: ''),
    ],
  ),
  ProductModel(
    id: 'p0112',
    name: 'Premium Knit Polo',
    subtitle: 'Refined Casual Shirt',
    description: 'Premium knit polo shirt for a refined casual look.',
    categoryName: 'Men',
    price: 59,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096613/images/7007096613_1.jpg?v=3',
    availableColors: [
      ProductColor(
        colorCode: '#476343',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096613/images/7007096613_1.jpg?v=3',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096613/images/7007096613_2.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096613/images/7007096613_3.jpg?v=2',
        ],
      ),
      ProductColor(
        colorCode: '#FFFFFF',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096636/images/7007096636_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096636/images/7007096636_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7007096636/images/7007096636_3.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#476343', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#476343', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#476343', size: 'L', stock: 8, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'M', stock: 9, id: ''),
      ProductVariant(color: '#FFFFFF', size: 'L', stock: 7, id: ''),
    ],
  ),
  ProductModel(
    id: 'p0113',
    name: 'Men Grey Relaxed Fit Side Tape Joggers',
    subtitle: 'Comfortable Cotton Joggers',
    description:
        'Comfortable cotton joggers perfect for lounging and casual wear.',
    categoryName: 'Men',
    price: 61,
    salePrice: 36,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7012839514/images/7012839514_1.jpg?v=1',
    availableColors: [
      ProductColor(
        colorCode: '#898A93',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7012839514/images/7012839514_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7012839514/images/7012839514_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7012839514/images/7012839514_3.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7012839514/images/7012839514_4.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#898A93', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#898A93', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#898A93', size: 'L', stock: 8, id: ''),
      ProductVariant(color: '#898A93', size: 'XL', stock: 9, id: ''),
    ],
  ),
  ProductModel(
    id: 'p0114',
    name: 'Relaxed Fit Dropped Shoulder Sweatshirt',
    subtitle: 'Cozy Cotton Sweatshirt',
    description: 'Cozy cotton sweatshirt perfect for casual wear and lounging.',
    categoryName: 'Men',
    price: 119,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7010338801/images/7010338801_1.jpg?v=3',
    availableColors: [
      ProductColor(
        colorCode: '#232525',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7010338801/images/7010338801_1.jpg?v=3',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7010338801/images/7010338801_2.jpg?v=3',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7010338801/images/7010338801_3.jpg?v=3',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#232525', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#232525', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#232525', size: 'L', stock: 8, id: ''),
      ProductVariant(color: '#232525', size: 'XL', stock: 9, id: ''),
    ],
  ),
  ProductModel(
    id: 'p0115',
    name: 'Abstract Print Casual Shirt for Men',
    subtitle: 'Casual Printed Shirt',
    description:
        'Casual shirt with abstract print, perfect for stylish outings.',
    categoryName: 'Men',
    price: 91,
    salePrice: 50,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7013326903/images/7013326903_1.jpg?v=1',
    availableColors: [
      ProductColor(
        colorCode: '#CEC2CA',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7013326903/images/7013326903_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7013326903/images/7013326903_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7013326903/images/7013326903_3.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#CEC2CA', size: 'S', stock: 15, id: ''),
      ProductVariant(color: '#CEC2CA', size: 'M', stock: 25, id: ''),
      ProductVariant(color: '#CEC2CA', size: 'L', stock: 8, id: ''),
    ],
  ),
  // Accessories
  ProductModel(
    id: 'pA1',
    name: 'Travel Solid Zip Closure Backpack',
    subtitle: 'Durable Everyday Backpack',
    description:
        'A sleek, durable backpack with a dedicated laptop compartment and multiple zip pockets for organization. Perfect for work or travel.',
    categoryName: 'Accessories',
    price: 105,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7023555301/images/7023555301_1.jpg?v=1',
    availableColors: [
      ProductColor(
        colorCode: '#000000',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7023555301/images/7023555301_1.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7023555301/images/7023555301_2.jpg?v=1',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7023555301/images/7023555301_3.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#000000', size: 'One Size', stock: 50, id: ''),
    ],
  ),
  ProductModel(
    id: 'pA2',
    name: 'Men Navigator Aviator Sunglasses',
    subtitle: 'UV Protected Sunglasses',
    description:
        'Timeless wayfarer design with 100% UV protection, perfect for any sunny day. Features a durable polycarbonate frame.',
    categoryName: 'Accessories',
    price: 277,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7022606001/images/7022606001_1.jpg?v=1',
    availableColors: [
      ProductColor(
        colorCode: '#000000',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7022606001/images/7022606001_1.jpg?v=1',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#000000', size: 'One Size', stock: 30, id: ''),
    ],
  ),
  ProductModel(
    id: 'pA3',
    name: 'Solid Belt with Auto Lock Buckle Closure',
    subtitle: 'Classic Leather Belt',
    description:
        'A classic accessory, this genuine leather belt features a subtle texture and a timeless metal buckle.',
    categoryName: 'Accessories',
    price: 85,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7024109201/images/7024109201_1.jpg?v=2',
    availableColors: [
      ProductColor(
        colorCode: '#000000',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7024109201/images/7024109201_1.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7024109201/images/7024109201_2.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7024109201/images/7024109201_3.jpg?v=2',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#000000', size: '32', stock: 20, id: ''),
      ProductVariant(color: '#000000', size: '34', stock: 18, id: ''),
      ProductVariant(color: '#000000', size: '36', stock: 15, id: ''),
    ],
  ),
  ProductModel(
    id: 'pA4',
    name: 'Metallic 2-Piece Watch Ring Set',
    subtitle: 'Watch and Ring Set',
    description:
        'A stylish set featuring a sleek metallic watch with a matching ring, perfect for any occasion.',
    categoryName: 'Accessories',
    price: 37,
    salePrice: 22,
    thumbnail:
        'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7020765732/images/7020765732_1.jpg?v=2',
    availableColors: [
      ProductColor(
        colorCode: '#D8D4CE',
        images: [
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7020765732/images/7020765732_1.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7020765732/images/7020765732_3.jpg?v=2',
          'https://images.stylishop.com/cdn-cgi/image/format=auto/media/catalog/product/7020765732/images/7020765732_5.jpg?v=2',
        ],
      ),
    ],
    variants: [
      ProductVariant(color: '#D8D4CE', size: 'One Size', stock: 25, id: ''),
    ],
  ),
];

Future<void> addAllDemoProducts() async {
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  for (var product in demoProducts) {
    await fireBaseFireStore.addProduct(product);
  }
}
