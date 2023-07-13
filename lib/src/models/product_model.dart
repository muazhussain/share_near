class Product {
  final String title;
  final String description;
  final int rentCost;
  final int productPrice;
  final double rating;
  final String owner;
  final double latitude;
  final double longitude;
  final int rentDuration;
  final List<String>? images;
  String? currentRenter;

  Product({
    required this.title,
    required this.description,
    required this.rentCost,
    required this.productPrice,
    required this.rating,
    required this.owner,
    required this.latitude,
    required this.longitude,
    required this.rentDuration,
    required this.images,
    this.currentRenter,
  });

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'rentCost': rentCost,
      'productPrice': productPrice,
      'rating': rating,
      'owner': owner,
      'latitude': latitude,
      'longitude': longitude,
      'rentDuration': rentDuration,
      'images': images,
    };
  }

  // factory Product.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return Product(
  //     title: data['title'],
  //     description: data['description'],
  //     rentCost: data['rentCost'],
  //     productPrice: data['productPrice'],
  //     rating: data['rating'],
  //     owner: data['owner'],
  //     images: data['images'],
  //   );
  // }
}

List<Product> demoProducts = [
  Product(
    title: 'Wireless Controller for PS4™',
    description: 'This is brand new camera from Sony.',
    rentCost: 2000,
    productPrice: 50000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'https://firebasestorage.googleapis.com/v0/b/flutter-muaz.appspot.com/o/productImage%2FMy%20Camera_1?alt=media&token=43b57aff-19fa-4b6a-8231-639be95d6ff5',
      'https://firebasestorage.googleapis.com/v0/b/flutter-muaz.appspot.com/o/productImage%2FMy%20Camera_2?alt=media&token=0cdb9bea-d887-497a-b830-8c4cfba39cf9',
      'https://firebasestorage.googleapis.com/v0/b/flutter-muaz.appspot.com/o/productImage%2FMy%20Camera_3?alt=media&token=84a2fff5-e4de-4735-99d5-fa8c62039dc1',
      'https://firebasestorage.googleapis.com/v0/b/flutter-muaz.appspot.com/o/productImage%2FMy%20Camera_4?alt=media&token=a779e81c-3371-47c8-90b3-d65d62c635a3',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
  Product(
    title: 'Sony DX10',
    description: 'This is brand new camera from Sony.',
    rentCost: 200000,
    productPrice: 500000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
  Product(
    title: 'Wireless Controller for PS4™',
    description:
        '(PlayStation 5) The latest Sony PlayStation introduced in November 2020. Powered by an eight-core AMD Zen 2 CPU and custom AMD Radeon GPU, the PS5 is offered in two models: with and without a 4K Blu-ray drive. Supporting a 120Hz video refresh, the PS5 is considerably more powerful than the PS4 and PS4 Pro. Rather than GDDR5 memory, GDDR6 is supported with capacity doubled from 8 to 16GB. Storage is an NVMe 825GB SSD rather than a hard drive, and expandable NVMe storage is supported',
    rentCost: 200000,
    productPrice: 5000000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
  Product(
    title: 'Wireless Controller for PS4™',
    description:
        '(PlayStation 5) The latest Sony PlayStation introduced in November 2020. Powered by an eight-core AMD Zen 2 CPU and custom AMD Radeon GPU, the PS5 is offered in two models: with and without a 4K Blu-ray drive. Supporting a 120Hz video refresh, the PS5 is considerably more powerful than the PS4 and PS4 Pro. Rather than GDDR5 memory, GDDR6 is supported with capacity doubled from 8 to 16GB. Storage is an NVMe 825GB SSD rather than a hard drive, and expandable NVMe storage is supported',
    rentCost: 200000,
    productPrice: 5000000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
  Product(
    title: 'Wireless Controller for PS4™',
    description:
        '(PlayStation 5) The latest Sony PlayStation introduced in November 2020. Powered by an eight-core AMD Zen 2 CPU and custom AMD Radeon GPU, the PS5 is offered in two models: with and without a 4K Blu-ray drive. Supporting a 120Hz video refresh, the PS5 is considerably more powerful than the PS4 and PS4 Pro. Rather than GDDR5 memory, GDDR6 is supported with capacity doubled from 8 to 16GB. Storage is an NVMe 825GB SSD rather than a hard drive, and expandable NVMe storage is supported',
    rentCost: 200000,
    productPrice: 5000000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
  Product(
    title: 'Wireless Controller for PS4™',
    description:
        '(PlayStation 5) The latest Sony PlayStation introduced in November 2020. Powered by an eight-core AMD Zen 2 CPU and custom AMD Radeon GPU, the PS5 is offered in two models: with and without a 4K Blu-ray drive. Supporting a 120Hz video refresh, the PS5 is considerably more powerful than the PS4 and PS4 Pro. Rather than GDDR5 memory, GDDR6 is supported with capacity doubled from 8 to 16GB. Storage is an NVMe 825GB SSD rather than a hard drive, and expandable NVMe storage is supported',
    rentCost: 200000,
    productPrice: 5000000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    latitude: 0,
    longitude: 0,
    rentDuration: 2,
  ),
];
