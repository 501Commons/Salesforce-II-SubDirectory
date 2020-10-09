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
                subList = [SELECT ID,FirstName,LastName,ii_Stars_Id__c,ii_Languages__c,MailingLatitude,MailingLongitude,
                ii_County__c,C501_Imagine_WA_County__c,C501_Profile_Pic__c,C501_Record_Type_Name__c,ii_Sub_Pool_Status__c,
                MailingCity,ii_Primary_Language__c
                FROM Contact WHERE ii_Sub_Pool_Status__c='Approved' AND C501_Record_Type_Name__c='Contact'];
                    /* for(Contact sl:sublist){
                        Contact newcon = new Contact();
                        newcon.FirstName=sl.FirstName;
                        newcon.LastName=sl.LastName;
                        newcon.ii_Stars_Id__c=sl.ii_Stars_Id__c;
                        newcon.ii_Languages__c=sl.ii_Languages__c;
                        newcon.MailingLatitude=sl.MailingLatitude;
                        newcon.MailingLongitude=sl.MailingLongitude;
                        newcon.ii_County__c=sl.ii_County__c;
                        newcon.C501_Profile_Pic__c=sl.C501_Profile_Pic__c;
                        newcon.ii_Sub_Pool_Status__c=sl.ii_Sub_Pool_Status__c;
                        newcon.MailingCity=sl.MailingCity;
                        if(String.isBlank(sl.ii_Stars_Id__c)){newcon.ii_Stars_Id__c='ii_Stars_Id__c';}
                        if(String.isBlank(sl.ii_Languages__c)){newcon.ii_Languages__c='ii_Languages__c';}
                        if(sl.MailingLatitude==null){newcon.MailingLatitude=0;}
                        if(sl.MailingLongitude==null){newcon.MailingLongitude=0;}
                        if(String.isBlank(sl.ii_County__c)){newcon.ii_County__c=sl.C501_Imagine_WA_County__c;}
                        if(String.isBlank(newcon.ii_County__c)){newcon.ii_County__c='ii_County__c';}
                        if(String.isBlank(sl.C501_Profile_Pic__c)){newcon.C501_Profile_Pic__c='C501_Profile_Pic__c';}
                        if(String.isBlank(sl.ii_Sub_Pool_Status__c)){newcon.ii_Sub_Pool_Status__c='ii_Sub_Pool_Status__c';}
                        if(String.isBlank(sl.MailingCity)){newcon.MailingCity='MailingCity';}
                        subListUpdate.add(newcon); */




                        JSONGenerator gen = JSON.createGenerator(true);
                        gen.writeStartArray();
                for(Contact sl:sublist){
                    String Language = sl.ii_Languages__c;
                    if(Language==null){
                        Language='Language';
                    }
                    String Language2 = sl.ii_Primary_Language__c;
                    if(Language2==null){
                        Language2='Language';
                    }
                    String City2 = sl.MailingCity;
                    if(City2==null){
                        City2='City';
                    }
                    String County = sl.ii_County__c;
                    if(County==null){
                        County='County';
                    }
                    String County2 = sl.ii_County__c;
                    if(County2==null){
                        County2='County';
                    }

                    
                    gen.writeStartObject();
                    gen.writeStringField('firstname', sl.FirstName);
                    gen.writeStringField('lastname', sl.LastName);
                    //gen.writeStringField('starsID', f.ii_Stars_Id__c);
                    gen.writeStringField('starsID', sl.ii_Stars_Id__c);
                    gen.writeStringField('Language', Language);
                    gen.writeStringField('Language2', Language2);
                    gen.writeStringField('City', sl.MailingCity);
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
                facList = [SELECT ID,FirstName,LastName,ii_Stars_Id__c,ii_Languages__c,
                C501_Imagine_WA_County__c,C501_Profile_Pic__c,C501_Record_Type_Name__c,ii_Sub_Pool_Status__c,ii_FamLink_Id__c,
                ii_Facility_Name__c,ii_Substitute_Pool_Status__c,ii_Primary_Language__c,MailingCity,ii_County__c
                FROM Contact WHERE ii_Substitute_Pool_Status__c='Approved' AND C501_Record_Type_Name__c='Facility'];
                
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartArray();
                for(Contact f:facList){
                    String Language = f.ii_Languages__c;
                    if(Language==null){
                        Language='Language';
                    }
                    String Language2 = f.ii_Primary_Language__c;
                    if(Language2==null){
                        Language2='Language';
                    }
                    String City2 = f.MailingCity;
                    if(City2==null){
                        City2='City';
                    }
                    String County2 = f.ii_County__c;
                    if(County2==null){
                        County2='County';
                    }

                    
                    gen.writeStartObject();
                    gen.writeStringField('firstname', f.FirstName);
                    gen.writeStringField('lastname', f.LastName);
                    //gen.writeStringField('starsID', f.ii_Stars_Id__c);
                    gen.writeStringField('famLinkID', f.ii_FamLink_Id__c);
                    gen.writeStringField('Language', Language);
                    gen.writeStringField('Language2', Language2);
                    gen.writeStringField('City', f.MailingCity);
                    gen.writeStringField('City2', City2);
                    gen.writeStringField('County', f.ii_County__c);
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