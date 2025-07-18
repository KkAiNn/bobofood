import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/common/model/notification.dart';
import 'package:bobofood/common/model/product.dart';

class MockData {
  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Pepperoni Cheese Pizza',
      price: 12.99,
      image: 'assets/home/food_detail.png',
      banner: ['assets/home/food_detail.png', 'assets/home/food_detail.png'],
      description:
          'A delicious pizza topped with pepperoni, cheese, and tomato sauce.',
      star: 4.5,
      kcal: 300,
      cookTime: 10,
    ),
    ProductModel(
      id: '2',
      name: 'Classic Burger',
      price: 12.75,
      image: 'assets/home/food4.png',
      banner: ['assets/home/food2.png', 'assets/home/food2.png'],
      description:
          'A delicious burger topped with cheese, lettuce, tomato, and onion.',
      star: 4.5,
      kcal: 350,
      cookTime: 10,
    ),
    ProductModel(
      id: '3',
      name: 'Donut Box',
      price: 13.45,
      image: 'assets/home/food3.png',
      banner: ['assets/home/food3.png', 'assets/home/food3.png'],
      description:
          'A delicious donut box topped with chocolate, sprinkles, and frosting.',
      star: 4.5,
      kcal: 200,
      cookTime: 10,
    ),
    ProductModel(
      id: '4',
      name: 'Pepperoni Cheese Pizza',
      price: 12.99,
      image: 'assets/home/food_detail.png',
      banner: ['assets/home/food_detail.png', 'assets/home/food_detail.png'],
      description:
          'A delicious pizza topped with pepperoni, cheese, and tomato sauce.',
      star: 4.5,
      kcal: 300,
      cookTime: 10,
    ),
    ProductModel(
      id: '5',
      name: 'Classic Burger',
      price: 12.75,
      image: 'assets/home/food4.png',
      banner: ['assets/home/food2.png', 'assets/home/food2.png'],
      description:
          'A delicious burger topped with cheese, lettuce, tomato, and onion.',
      star: 4.5,
      kcal: 350,
      cookTime: 10,
    ),
    ProductModel(
      id: '6',
      name: 'Donut Box',
      price: 13.45,
      image: 'assets/home/food3.png',
      banner: ['assets/home/food3.png', 'assets/home/food3.png'],
      description:
          'A delicious donut box topped with chocolate, sprinkles, and frosting.',
      star: 4.5,
      kcal: 200,
      cookTime: 10,
    )
  ];

  static List<NotificationModel> notifications = [
    NotificationModel(
      title: "Order Out for Delivery!",
      description:
          "Your food is on the move! Track your order for real-time updates.",
      time: "2025-07-17 10:00:00",
    ),
    NotificationModel(
      title: "Your Order is Confirmed!",
      description:
          "Thanks for ordering! Your delicious meal is being prepared and will be on its way soon.",
      time: "2025-07-16 10:00:00",
    )
  ];

  static List<AddressModel> address = [
    AddressModel(
      id: '1',
      city: 'New York',
      state: 'NY',
      zipCode: '10001',
      addressLabel: 'Home',
      deliveryInstructions: 'Delivery instructions',
      name: 'John Doe',
      phoneCode: '+1',
      phone: '1234567890',
      street: '123 Main St',
      country: 'USA',
    ),
    AddressModel(
      id: '2',
      city: 'Los Angeles',
      state: 'CA',
      zipCode: '90001',
      addressLabel: 'Work',
      deliveryInstructions: 'Delivery instructions',
      name: 'Jane Doe',
      phoneCode: '+1',
      phone: '1234567890',
      street: '123 Main St',
      country: 'USA',
      isDefault: true,
    ),
    AddressModel(
      id: '3',
      city: 'Chicago',
      state: 'IL',
      zipCode: '60601',
      addressLabel: 'School',
      deliveryInstructions: 'Delivery instructions',
      name: 'John Doe',
      phoneCode: '+1',
      phone: '1234567890',
      street: '123 Main St',
      country: 'USA',
    ),
    AddressModel(
      id: '4',
      city: 'Chicago',
      state: 'IL',
      zipCode: '60601',
      addressLabel: 'Office',
      deliveryInstructions: 'Delivery instructions',
      name: 'John Doe',
      phoneCode: '+1',
      phone: '1234567890',
      street: '123 Main St',
      country: 'USA',
    ),
  ];
}
