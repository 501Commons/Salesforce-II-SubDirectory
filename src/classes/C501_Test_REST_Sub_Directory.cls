@isTest
public with sharing class C501_Test_REST_Sub_Directory {

    

    static testmethod void testHttpGetFac() {
        // prepare test-data
        insert C501_Test_Utility.createTestContact(null, 'Facility',20);
        //As Per Best Practice it is important to instantiate the Rest Context
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/v1/sub-directory/fac.json'; //Request URL
        req.httpMethod = 'GET';
    
        RestContext.request = req;
        RestContext.response= res;
    
        Test.startTest();
            C501_REST_Sub_Directory.doGet();
            //String actual = null;//HttpClass.updateCustomObject();
        Test.stopTest();
    
        
    }
    static testmethod void testHttpGetSub() {
        // prepare test-data
        insert C501_Test_Utility.createTestContact(null, 'Contact',90);
        //As Per Best Practice it is important to instantiate the Rest Context
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/v1/sub-directory/sub.json'; //Request URL
        req.httpMethod = 'GET';
    
        RestContext.request = req;
        RestContext.response= res;
    
        Test.startTest();
            C501_REST_Sub_Directory.doGet();
            //String actual = null;//HttpClass.updateCustomObject();
        Test.stopTest();
    
        
    }
}