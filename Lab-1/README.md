# Setting up your first DSX notebook

## Introduction:

[<img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/images/DSX.png" height="150"/>](http://datascience.ibm.com/) [<img src="https://github.com/jpatter/LMCO/blob/master/Lab-1/images/DB2Warehouse.png" height="150"/>](https://www.ibm.com/analytics/us/en/technology/cloud-data-services/dashdb/) [<img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/images/jupyter.png" height="150"/>](http://jupyter.org/index.html)

In this lab, you will use IBM's Data Science Experience (DSX) to create a Jupyter IPython notebook to connect to and query a DB2 Warehouse instance running in IBM Bluemix.

## Objectives:

Upon completing the lab, you will know how to:

1. Create a Jupyter IPython notebook from a URL
1. Establish a connection to DB2 Warehouse on Cloud
1. Use a dataframe to read and manipulate tables
1. Use Spark to explore and analyze the dataset
1. Write the modified dataset back to DB2 Warehouse on Cloud
1. Close the database connection

## Instructions:

### Step 1.  Log into your [DSX](http://datascience.ibm.com/) account, then click Projects in the top menu bar then select the project you created at the beginning of this proof of technology.

> <img src="https://raw.githubusercontent.com/jpatter/Proof-of-Technology/master/DSX/Lab-1/images/DSX-open-project.png"/>

### Step 2.  Click the `Add to project > Notebook` link in the top right of your project pane.

> <img src="https://raw.githubusercontent.com/jpatter/DSX/master/Lab-1/images/DSX-add-notebook.png"/>

### Step 3.  Create the notebook.

> <img src="https://raw.githubusercontent.com/jpatter/DSX/master/Lab-1/images/DSX-create-notebook-from-url.png"/>

1. Click the `From URL` tab under `Create Notebook`.
1. Give the notebook a name in the `Name` field, for example `Connect and Interact with DB2 Warehouse` and optionally you can give it a description.
1. In the Notebook URL field, use `https://github.com/jpatter/DSX/blob/master/Lab-1/databaseConnectAndInteract.ipynb`.
1. Ensure that there is a `Spark Service` selected, then click the `Create Notebook` button on the bottom right of the screen.

### Step 4.  Follow the instructions in the notebook.

> <img src="https://raw.githubusercontent.com/jpatter/DSX/master/Lab-1/images/DSX-edit-notebook-begin.png"/>
