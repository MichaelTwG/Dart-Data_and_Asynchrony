class Order {
  final int orderId;
  final double total;
  final Customer customer;

  Order({required this.orderId, required this.total, required this.customer});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json['orderId'] as int,
    customer: Customer.fromJson(json['customer']),
    total: json['total'] as double,
  );

  Map<String, dynamic> toJson(){
    return {
      'orderId': orderId,
      'customer': customer.toJson(),
      'total': total,
    };
  }
}

class Customer {
  final int id;
  final String name;

  Customer({required this.id, required this.name});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'] as int,
    name: json['name'] as String,  
  );

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
    };
  }
}

void main() {
  Map<String, dynamic> inputData = {
  "orderId": 101,
  "customer": {
    "id": 5,
    "name": "Bob"
    },
  "total": 99.99
  };

  Order order = Order.fromJson(inputData);

  print("orderId: ${order.orderId}\ncustomerId: ${order.customer.id}\ncustomerName: ${order.customer.name}\ntotal: ${order.total}");

  print("Type of order: ${order.runtimeType}\nType of customer: ${order.customer.runtimeType}");

  Map<String, dynamic> outputData = order.toJson();

  print(outputData);
}