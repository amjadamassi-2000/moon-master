class CheckoutRequest {
  CheckoutRequest({
    this.type,
    this.customerName,
    this.cityId,
    this.mobile,
    this.tableNumber,
    this.deliveryMethod,
    this.paymentMethod,
    this.address,
    this.latitude,
    this.longitude,
    this.details,
    this.deliveryTime,
    this.date,
    this.time,
    this.promoCodeName,
  });

  int type;
  String customerName;
  int cityId;
  String mobile;
  String tableNumber;
  int deliveryMethod;
  int paymentMethod;
  String address;
  String latitude;
  String longitude;
  String details;
  String deliveryTime;
  String date;
  String time;
  String promoCodeName;

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      CheckoutRequest(
        type: json["type"],
        customerName: json["customer_name"],
        cityId: json["city_id"],
        mobile: json["mobile"],
        tableNumber: json["table_number"],
        deliveryMethod: json["delivery_method"],
        paymentMethod: json["payment_method"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        details: json["details"],
        deliveryTime: json["delivery_time"],
        promoCodeName: json["promoCode_name"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "customer_name": customerName,
        "city_id": cityId,
        "mobile": mobile,
        "table_number": tableNumber,
        "delivery_method": deliveryMethod,
        "payment_method": paymentMethod,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "details": details,
        "delivery_time": deliveryTime,
        "promoCode_name": promoCodeName,
        "time": time,
        "date": date,
      };
}
