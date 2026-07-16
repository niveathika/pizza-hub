
public type Item record {|
    string pizza;
    string size;
    int quantity;
|};

public type OrderRequest record {|
    string customerId;
    string customerName;
    string phone;
    string address;
    string email;
    Item[] items;
|};

public type OrderResponse record {|
    string orderId;
    string status;
    int estimatedReadyTime;
    string deliveryPartner;
    int deliveryEtaMinutes;
|};
