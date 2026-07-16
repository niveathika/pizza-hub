import ballerina/http;
import ballerina/random;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /pizza on httpDefaultListener {
    resource function post orders(@http:Payload OrderRequest payload) returns OrderResponse|error|http:BadRequest {
        do {
            string orderId = "ORD-" + (check random:createIntInRange(0, 1000)).toString();
            OrderResponse orderResponse = {
                orderId: orderId,
                status: "PENDING",
                estimatedReadyTime: 0,
                deliveryPartner: "",
                deliveryEtaMinutes: 0
            };
            return orderResponse;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
