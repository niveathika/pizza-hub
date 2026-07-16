import order_service.delivaryservice;

import ballerina/http;
import ballerinax/googleapis.gmail;

final http:Client kitchenService = check new ("https://e8f34e4e-e9bb-4799-b725-7173d271fa62-dev.e1-us-east-azure.choreoapis.dev/tcs-additional/kitchenservice/v1.0");

final delivaryservice:Client delivaryService = check new (apiKeyConfig = {choreoAPIKey: ChoreoAPIKey}, config = {proxy: wso2CloudProxyConfig, timeout: 60}, serviceUrl = ServiceURL);
final gmail:Client gmail = check new ({
    auth: {
        refreshToken: refreshToken,
        clientId: clientId,
        clientSecret: clientSecrect
    }
});
