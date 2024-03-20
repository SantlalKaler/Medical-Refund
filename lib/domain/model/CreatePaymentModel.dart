import 'dart:convert';
CreatePaymentModel createPaymentModelFromJson(String str) => CreatePaymentModel.fromJson(json.decode(str));
String createPaymentModelToJson(CreatePaymentModel data) => json.encode(data.toJson());
class CreatePaymentModel {
  CreatePaymentModel({
      String? status, 
      String? message, 
      bool? payment,
      Result? result,}){
    _status = status;
    _message = message;
    _payment = payment;
    _result = result;
}

  CreatePaymentModel.fromJson(dynamic json) {
    _status = json['status'];
    _payment = json['payment'];
    _message = json['message'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  bool? _payment;
  Result? _result;
CreatePaymentModel copyWith({  String? status,
  String? message,
  bool? payment,
  Result? result,
}) => CreatePaymentModel(  status: status ?? _status,
  message: message ?? _message,
  payment: payment ?? _payment,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  bool? get payment => _payment;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['payment'] = _payment;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? cfOrderId,
      String? createdAt, 
      CustomerDetails? customerDetails, 
      String? entity, 
      num? orderAmount, 
      String? orderCurrency, 
      String? orderExpiryTime, 
      String? orderId, 
      OrderMeta? orderMeta, 
      dynamic orderNote, 
      List<dynamic>? orderSplits, 
      String? orderStatus, 
      dynamic orderTags, 
      String? paymentSessionId, 
      Payments? payments, 
      Refunds? refunds, 
      Settlements? settlements, 
      dynamic terminalData,}){
    _cfOrderId = cfOrderId;
    _createdAt = createdAt;
    _customerDetails = customerDetails;
    _entity = entity;
    _orderAmount = orderAmount;
    _orderCurrency = orderCurrency;
    _orderExpiryTime = orderExpiryTime;
    _orderId = orderId;
    _orderMeta = orderMeta;
    _orderNote = orderNote;
    _orderSplits = orderSplits;
    _orderStatus = orderStatus;
    _orderTags = orderTags;
    _paymentSessionId = paymentSessionId;
    _payments = payments;
    _refunds = refunds;
    _settlements = settlements;
    _terminalData = terminalData;
}

  Result.fromJson(dynamic json) {
    _cfOrderId = json['cf_order_id'].toString();
    _createdAt = json['created_at'];
    _customerDetails = json['customer_details'] != null ? CustomerDetails.fromJson(json['customer_details']) : null;
    _entity = json['entity'];
    _orderAmount = json['order_amount'];
    _orderCurrency = json['order_currency'];
    _orderExpiryTime = json['order_expiry_time'];
    _orderId = json['order_id'];
    _orderMeta = json['order_meta'] != null ? OrderMeta.fromJson(json['order_meta']) : null;
    _orderNote = json['order_note'];
    if (json['order_splits'] != null) {
      _orderSplits = [];
      json['order_splits'].forEach((v) {
        _orderSplits?.add(json['order_splits']);
      });
    }
    _orderStatus = json['order_status'];
    _orderTags = json['order_tags'];
    _paymentSessionId = json['payment_session_id'];
    _payments = json['payments'] != null ? Payments.fromJson(json['payments']) : null;
    _refunds = json['refunds'] != null ? Refunds.fromJson(json['refunds']) : null;
    _settlements = json['settlements'] != null ? Settlements.fromJson(json['settlements']) : null;
    _terminalData = json['terminal_data'];
  }
  String? _cfOrderId;
  String? _createdAt;
  CustomerDetails? _customerDetails;
  String? _entity;
  num? _orderAmount;
  String? _orderCurrency;
  String? _orderExpiryTime;
  String? _orderId;
  OrderMeta? _orderMeta;
  dynamic _orderNote;
  List<dynamic>? _orderSplits;
  String? _orderStatus;
  dynamic _orderTags;
  String? _paymentSessionId;
  Payments? _payments;
  Refunds? _refunds;
  Settlements? _settlements;
  dynamic _terminalData;
Result copyWith({  String? cfOrderId,
  String? createdAt,
  CustomerDetails? customerDetails,
  String? entity,
  num? orderAmount,
  String? orderCurrency,
  String? orderExpiryTime,
  String? orderId,
  OrderMeta? orderMeta,
  dynamic orderNote,
  List<dynamic>? orderSplits,
  String? orderStatus,
  dynamic orderTags,
  String? paymentSessionId,
  Payments? payments,
  Refunds? refunds,
  Settlements? settlements,
  dynamic terminalData,
}) => Result(  cfOrderId: cfOrderId ?? _cfOrderId,
  createdAt: createdAt ?? _createdAt,
  customerDetails: customerDetails ?? _customerDetails,
  entity: entity ?? _entity,
  orderAmount: orderAmount ?? _orderAmount,
  orderCurrency: orderCurrency ?? _orderCurrency,
  orderExpiryTime: orderExpiryTime ?? _orderExpiryTime,
  orderId: orderId ?? _orderId,
  orderMeta: orderMeta ?? _orderMeta,
  orderNote: orderNote ?? _orderNote,
  orderSplits: orderSplits ?? _orderSplits,
  orderStatus: orderStatus ?? _orderStatus,
  orderTags: orderTags ?? _orderTags,
  paymentSessionId: paymentSessionId ?? _paymentSessionId,
  payments: payments ?? _payments,
  refunds: refunds ?? _refunds,
  settlements: settlements ?? _settlements,
  terminalData: terminalData ?? _terminalData,
);
  String? get cfOrderId => _cfOrderId;
  String? get createdAt => _createdAt;
  CustomerDetails? get customerDetails => _customerDetails;
  String? get entity => _entity;
  num? get orderAmount => _orderAmount;
  String? get orderCurrency => _orderCurrency;
  String? get orderExpiryTime => _orderExpiryTime;
  String? get orderId => _orderId;
  OrderMeta? get orderMeta => _orderMeta;
  dynamic get orderNote => _orderNote;
  List<dynamic>? get orderSplits => _orderSplits;
  String? get orderStatus => _orderStatus;
  dynamic get orderTags => _orderTags;
  String? get paymentSessionId => _paymentSessionId;
  Payments? get payments => _payments;
  Refunds? get refunds => _refunds;
  Settlements? get settlements => _settlements;
  dynamic get terminalData => _terminalData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cf_order_id'] = _cfOrderId;
    map['created_at'] = _createdAt;
    if (_customerDetails != null) {
      map['customer_details'] = _customerDetails?.toJson();
    }
    map['entity'] = _entity;
    map['order_amount'] = _orderAmount;
    map['order_currency'] = _orderCurrency;
    map['order_expiry_time'] = _orderExpiryTime;
    map['order_id'] = _orderId;
    if (_orderMeta != null) {
      map['order_meta'] = _orderMeta?.toJson();
    }
    map['order_note'] = _orderNote;
    if (_orderSplits != null) {
      map['order_splits'] = _orderSplits?.map((v) => v.toJson()).toList();
    }
    map['order_status'] = _orderStatus;
    map['order_tags'] = _orderTags;
    map['payment_session_id'] = _paymentSessionId;
    if (_payments != null) {
      map['payments'] = _payments?.toJson();
    }
    if (_refunds != null) {
      map['refunds'] = _refunds?.toJson();
    }
    if (_settlements != null) {
      map['settlements'] = _settlements?.toJson();
    }
    map['terminal_data'] = _terminalData;
    return map;
  }

}

Settlements settlementsFromJson(String str) => Settlements.fromJson(json.decode(str));
String settlementsToJson(Settlements data) => json.encode(data.toJson());
class Settlements {
  Settlements({
      String? url,}){
    _url = url;
}

  Settlements.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
Settlements copyWith({  String? url,
}) => Settlements(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}

Refunds refundsFromJson(String str) => Refunds.fromJson(json.decode(str));
String refundsToJson(Refunds data) => json.encode(data.toJson());
class Refunds {
  Refunds({
      String? url,}){
    _url = url;
}

  Refunds.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
Refunds copyWith({  String? url,
}) => Refunds(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}

Payments paymentsFromJson(String str) => Payments.fromJson(json.decode(str));
String paymentsToJson(Payments data) => json.encode(data.toJson());
class Payments {
  Payments({
      String? url,}){
    _url = url;
}

  Payments.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
Payments copyWith({  String? url,
}) => Payments(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}

OrderMeta orderMetaFromJson(String str) => OrderMeta.fromJson(json.decode(str));
String orderMetaToJson(OrderMeta data) => json.encode(data.toJson());
class OrderMeta {
  OrderMeta({
      dynamic returnUrl, 
      String? notifyUrl, 
      dynamic paymentMethods,}){
    _returnUrl = returnUrl;
    _notifyUrl = notifyUrl;
    _paymentMethods = paymentMethods;
}

  OrderMeta.fromJson(dynamic json) {
    _returnUrl = json['return_url'];
    _notifyUrl = json['notify_url'];
    _paymentMethods = json['payment_methods'];
  }
  dynamic _returnUrl;
  String? _notifyUrl;
  dynamic _paymentMethods;
OrderMeta copyWith({  dynamic returnUrl,
  String? notifyUrl,
  dynamic paymentMethods,
}) => OrderMeta(  returnUrl: returnUrl ?? _returnUrl,
  notifyUrl: notifyUrl ?? _notifyUrl,
  paymentMethods: paymentMethods ?? _paymentMethods,
);
  dynamic get returnUrl => _returnUrl;
  String? get notifyUrl => _notifyUrl;
  dynamic get paymentMethods => _paymentMethods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['return_url'] = _returnUrl;
    map['notify_url'] = _notifyUrl;
    map['payment_methods'] = _paymentMethods;
    return map;
  }

}

CustomerDetails customerDetailsFromJson(String str) => CustomerDetails.fromJson(json.decode(str));
String customerDetailsToJson(CustomerDetails data) => json.encode(data.toJson());
class CustomerDetails {
  CustomerDetails({
      String? customerId, 
      String? customerName, 
      String? customerEmail, 
      String? customerPhone,}){
    _customerId = customerId;
    _customerName = customerName;
    _customerEmail = customerEmail;
    _customerPhone = customerPhone;
}

  CustomerDetails.fromJson(dynamic json) {
    _customerId = json['customer_id'];
    _customerName = json['customer_name'];
    _customerEmail = json['customer_email'];
    _customerPhone = json['customer_phone'];
  }
  String? _customerId;
  String? _customerName;
  String? _customerEmail;
  String? _customerPhone;
CustomerDetails copyWith({  String? customerId,
  String? customerName,
  String? customerEmail,
  String? customerPhone,
}) => CustomerDetails(  customerId: customerId ?? _customerId,
  customerName: customerName ?? _customerName,
  customerEmail: customerEmail ?? _customerEmail,
  customerPhone: customerPhone ?? _customerPhone,
);
  String? get customerId => _customerId;
  String? get customerName => _customerName;
  String? get customerEmail => _customerEmail;
  String? get customerPhone => _customerPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = _customerId;
    map['customer_name'] = _customerName;
    map['customer_email'] = _customerEmail;
    map['customer_phone'] = _customerPhone;
    return map;
  }

}