# Salesforce-II-SubDirectory

Add a brief description of this project here, in Markdown format.
It will be shown on the main page of the project's GitHub repository.

## Development

Following Fields need domain when updating from CM to SC

*****Campaign*****
custom_Start_DateTime__c with c501_cm__custom_Start_DateTime__c
C501_Outreach_WA_Counties__c
Language__c
Training_Name__c
Class_Type__c
City__c

*****Contact*****
replace all ii_ with c501_cm__ii_

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `cci org browser dev` to open the org in your browser.