import ballerina/http;
import ballerina/os;

configurable string ServiceURL = os:getEnv("CHOREO_DELIVARYSERVICE_SERVICEURL");
configurable string ChoreoAPIKey = os:getEnv("CHOREO_DELIVARYSERVICE_CHOREOAPIKEY");

configurable string? wso2CloudProxyHost = ();
configurable int? wso2CloudProxyPort = ();
http:ProxyConfig? wso2CloudProxyConfig = wso2CloudProxyHost is string && wso2CloudProxyPort is int ? {host: <string>wso2CloudProxyHost, port: <int>wso2CloudProxyPort} : ();

configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecrect = ?;
