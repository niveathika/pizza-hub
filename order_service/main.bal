import order_service.delivaryservice;

import ballerina/http;
import ballerina/random;
import ballerinax/googleapis.gmail;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /pizza on httpDefaultListener {
    resource function post orders(@http:Payload OrderRequest payload) returns OrderResponse|error|http:BadRequest {
        do {
            string orderId = "ORD-" + (check random:createIntInRange(0, 1000)).toString();
            KitchenResponse kitchenResponse = check kitchenService->/orders.post({
                orderId: orderId,
                items: payload.items
            });
            delivaryservice:DeliveryEtaResponse deliveryResponse = check delivaryService->/quotes.get(address = payload.address, orderId = "orderId");

            string deliveryPartner = deliveryResponse.deliveryPartner;
            int deliveryEta = deliveryResponse.etaMinutes;
            string emailBody = string `Hi ${payload.customerName},

Your pizza order has been placed!

Order ID   : ${orderId}
Status     : ${kitchenResponse.status}
Ready in   : ${kitchenResponse.etaMinutes} minutes
Delivery by: ${deliveryPartner} (~${deliveryEta} min)

Thank you for your order!`;

            gmail:MessageRequest emailMessage = {
                to: [payload.email],
                subject: string `Order Confirmation - ${orderId}`,
                bodyInText: emailBody
            };
            _ = check gmail->/users/["me"]/messages/send.post(emailMessage);

            OrderResponse orderResponse = {
                orderId: orderId,
                status: kitchenResponse.status,
                estimatedReadyTime: kitchenResponse.etaMinutes,
                deliveryPartner: deliveryPartner,
                deliveryEtaMinutes: deliveryEta
            };
            return orderResponse;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
