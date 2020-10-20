/*************************************

1) Login to WorkBench REST Explorer
https://workbench.developerforce.com/restExplorer.php

2) Select GET then Paste /services/v1/sub-directory/sub.json/

External URL via Sites: https://imagineinstitutecloud.secure.force.com/services/apexrest/v1/sub-directory/sub.json

NOTE: I'm not sure if this is the recommended way to access a REST Class to have to go thru sites.  I guess that is required if you want guest access otherwise if you want to authenticate you can go
    directly to https://imagineinstituteserivce.my.salesfoce.com/services/apexrest/v1/sub-directory/sub.json and use REST Authentication

*********************************************/

@RestResource(urlMapping='/v1/sub-directory/*')
global class C501_REST_Sub_Directory {
    @HttpGet
    global static void doGet() {
        Imagine_Settings__c ic = Imagine_Settings__c.getOrgDefaults();
        String okIP=ic.Remote_REST_Allowed_IP_s__c;
        if(Test.isRunningTest()){
            okIP='';
        }
        RestRequest req = RestContext.request;
        String queryType = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        RestResponse response = RestContext.response;
        
        String rAddress='';
        if(!Test.isRunningTest()){
            rAddress=req.remoteAddress;
        }
        if(okIP.contains(rAddress)||Test.isRunningTest()){
            if(queryType=='sub.json'){
                List<Contact> subList;
                List<Contact> subListUpdate=new List<Contact>();
                subList = [SELECT ID,FirstName,LastName,c501_cm__ii_Stars_Id__c,Languages_Spoken__c,MailingLatitude,MailingLongitude,
                c501_cm__ii_County__c,c501_cm__C501_Imagine_WA_County__c,c501_cm__C501_Record_Type_Name__c,c501_cm__ii_Sub_Pool_Status__c,
                MailingCity,c501_cm__ii_Primary_Language__c
                FROM Contact WHERE Sub_Pool_Status_Rollup__c='Approved' AND c501_cm__C501_Record_Type_Name__c='Contact'];
                    /* for(Contact sl:sublist){
                        Contact newcon = new Contact();
                        newcon.FirstName=sl.FirstName;
                        newcon.LastName=sl.LastName;
                        newcon.c501_cm__ii_Stars_Id__c=sl.c501_cm__ii_Stars_Id__c;
                        newcon.Languages_Spoken__c=sl.Languages_Spoken__c;
                        newcon.MailingLatitude=sl.MailingLatitude;
                        newcon.MailingLongitude=sl.MailingLongitude;
                        newcon.c501_cm__ii_County__c=sl.c501_cm__ii_County__c;
                        newcon.c501_cm__ii_Sub_Pool_Status__c=sl.c501_cm__ii_Sub_Pool_Status__c;
                        newcon.MailingCity=sl.MailingCity;
                        if(String.isBlank(sl.c501_cm__ii_Stars_Id__c)){newcon.c501_cm__ii_Stars_Id__c='c501_cm__ii_Stars_Id__c';}
                        if(String.isBlank(sl.Languages_Spoken__c)){newcon.Languages_Spoken__c='Languages_Spoken__c';}
                        if(sl.MailingLatitude==null){newcon.MailingLatitude=0;}
                        if(sl.MailingLongitude==null){newcon.MailingLongitude=0;}
                        if(String.isBlank(sl.c501_cm__ii_County__c)){newcon.c501_cm__ii_County__c=sl.c501_cm__C501_Imagine_WA_County__c;}
                        if(String.isBlank(newcon.c501_cm__ii_County__c)){newcon.c501_cm__ii_County__c='c501_cm__ii_County__c';}
                        if(String.isBlank(sl.c501_cm__ii_Sub_Pool_Status__c)){newcon.c501_cm__ii_Sub_Pool_Status__c='c501_cm__ii_Sub_Pool_Status__c';}
                        if(String.isBlank(sl.MailingCity)){newcon.MailingCity='MailingCity';}
                        subListUpdate.add(newcon); */




                        JSONGenerator gen = JSON.createGenerator(true);
                        gen.writeStartArray();
                for(Contact sl:sublist){
                    String Language = sl.Languages_Spoken__c;
                    if(Language==null){
                        Language='Language';
                    }
                    String Language2 = sl.c501_cm__ii_Primary_Language__c;
                    if(Language2==null){
                        Language2='Language';
                    }
                    String City2 = sl.MailingCity;
                    if(City2==null){
                        City2='City';
                    }
                    String County = sl.c501_cm__ii_County__c;
                    if(County==null){
                        County='County';
                    }
                    String County2 = sl.c501_cm__ii_County__c;
                    if(County2==null){
                        County2='County';
                    }
                    String StarsID = sl.c501_cm__ii_Stars_Id__c;
                    if(StarsID==null){
                        StarsID='StarsID';
                    }
                    String MailingCity = sl.MailingCity;
                    if(MailingCity==null){
                        MailingCity='MailingCity';
                    }

                    
                    gen.writeStartObject();
                    gen.writeStringField('firstname', sl.FirstName);
                    gen.writeStringField('lastname', sl.LastName);
                    //gen.writeStringField('starsID', f.c501_cm__ii_Stars_Id__c);
                    gen.writeStringField('starsID', StarsID);
                    gen.writeStringField('Language', Language);
                    gen.writeStringField('Language2', Language2);
                    gen.writeStringField('City', MailingCity);
                    gen.writeStringField('City2', City2);
                    gen.writeStringField('County', County);
                    gen.writeStringField('County2', County2);
                    gen.writeEndObject();


                    }   
                    gen.writeEndArray();
                    response.responseBody = Blob.valueOf(gen.getAsString());
                //response.responseBody = Blob.valueOf(JSON.serializePretty(subListUpdate));
            }
            if(queryType=='fac.json'){
                List<Contact> facList;
                facList = [SELECT ID,FirstName,LastName,c501_cm__ii_Stars_Id__c,Languages_Spoken__c,
                c501_cm__C501_Imagine_WA_County__c,c501_cm__C501_Record_Type_Name__c,c501_cm__ii_Sub_Pool_Status__c,c501_cm__ii_FamLink_Id__c,
                c501_cm__ii_Facility_Name__c,c501_cm__ii_Substitute_Pool_Status__c,c501_cm__ii_Primary_Language__c,MailingCity,c501_cm__ii_County__c
                FROM Contact WHERE c501_cm__ii_Substitute_Pool_Status__c='Approved' AND c501_cm__C501_Record_Type_Name__c='Facility'];
                
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartArray();
                for(Contact f:facList){
                    String Language = f.Languages_Spoken__c;
                    if(Language==null){
                        Language='Language';
                    }
                    String Language2 = f.c501_cm__ii_Primary_Language__c;
                    if(Language2==null){
                        Language2='Language';
                    }
                    String City2 = f.MailingCity;
                    if(City2==null){
                        City2='City';
                    }
                    String County2 = f.c501_cm__ii_County__c;
                    if(County2==null){
                        County2='County';
                    }
                    String FName = f.FirstName;
                    if(FName==null){
                        FName='FirstName';
                    }
                    String LName = f.LastName;
                    if(LName==null){
                        LName='LastName';
                    }
                    String FamLinkID = f.c501_cm__ii_FamLink_Id__c;
                    if(FamLinkID==null){
                        FamLinkID='FamLinkID';
                    }
                    String MailCity = f.MailingCity;
                    if(MailCity==null){
                        MailCity='City1';
                    }
                    String County = f.c501_cm__ii_County__c;
                    if(County==null){
                        County='County1';
                    }

                    
                    gen.writeStartObject();
                    gen.writeStringField('firstname', FName);
                    gen.writeStringField('lastname', LName);
                    //gen.writeStringField('starsID', f.c501_cm__ii_Stars_Id__c);
                    gen.writeStringField('famLinkID', FamLinkID);
                    gen.writeStringField('Language', Language);
                    gen.writeStringField('Language2', Language2);
                    gen.writeStringField('City', MailCity);
                    gen.writeStringField('City2', City2);
                    gen.writeStringField('County', County);
                    gen.writeStringField('County2', County2);
                    gen.writeEndObject();

                    
                    

                    
                }
                gen.writeEndArray();
                
                response.responseBody = Blob.valueOf(gen.getAsString());
            }
            


        } else {
            response.responseBody = Blob.valueOf('Not Authorized');
        }
    }
    


}