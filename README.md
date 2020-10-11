# Salesforce-II-SubDirectory

Add a brief description of this project here, in Markdown format.
It will be shown on the main page of the project's GitHub repository.

## Development

Following Fields need domain when updating from CM to SC

1) Always sync from Shift Coverage which has the managed package
2) Replace All c501_cm__ with nothing/blank then deploy to Class Management

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `cci org browser dev` to open the org in your browser.