# Visualize supply chain data and create a user interface in R using RStudio and Shiny

## Introduction:

[<img src="https://github.com/jpatter/LMCO/blob/master/Lab-1/images/DB2Warehouse.png" height="150"/>](https://www.ibm.com/analytics/us/en/technology/cloud-data-services/dashdb/) [<img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/images/RStudio2.png"/>](https://www.rstudio.com/) [<img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/images/shiny.png"/>](https://shiny.rstudio.com/)

In this lab, you will learn some of the fundamentals of using RStudio and Shiny in DSX to work and interact with data in DB2 Warehouse and then to create a fully operational "reactive" web application that you can enhance further.

## Objectives:

Upon completing the lab, you will know how to:

1. Create an RStudio project from a Git repository
1. Establish a connection to DB2 Warehouse
1. Query, explore and visualize data in an R notebook
1. Use ggplot2 to create bar plots of several of the columns in an R dataframe
1. Close the database connection
1. Leverage shiny to create and run a web application
1. Interact with the shiny web web application by runnng it externally

## Instructions:

### Step 1.  Log into your [http://datascience.ibm.com/](http://datascience.ibm.com/) account, then click Tools in the top menu bar and select RStudio.

> <img src="https://raw.githubusercontent.com/jpatter/Proof-of-Technology/master/DSX/Lab-3/images/RStudio-select.png"/>

### Step 2.  Create a new project by clicking on `File` > `New Project`.

> <img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/Lab-3/images/RStudio-new-project.png"/>

### Step 3.  Select `Version Control`.
> <img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/Lab-3/images/RStudio-new-version-control-project.png"/>

### Step 4.  Select `Git`.
> <img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/Lab-3/images/RStudio-select-git-project.png"/>

### Step 5.  Fill in git repository details using the URL `https://github.com/cerebralace/LMDSX` and press `Create Project`.
> <img src="https://s10.postimg.org/ddev7g1ih/Lab_2_Git_Repo.png"/>

After the project gets created, you'll see a screen similar to the following:

> <img src="https://s10.postimg.org/ml73o5vq1/RStudio-_Project-_Created.png"/>

### Step 6.  In the files pane in the lower right of the RStudio IDE, click `Lab-2`.
> <img src="https://s10.postimg.org/81zymq009/Lab_2_Files_Pane.png"/>

### Step 7.  Click the `connection.R` file and fill in your DB2 Warehouse connection details.   You can find these from one of the previous labs. Save the file.
> <img src="https://s10.postimg.org/cnw2v2t95/connection.R_screenshot.png"/>

### Step 8.  Click the `dashConnectAndInteractInR.R` file in the files pane in the lower right of the RStudio IDE and run the cells in sequence from top to bottom in the notebook using the `Run current chunk` (green triangle) button in the top right of each cell.
> <img src="https://s10.postimg.org/3sv8kkrm1/dash_Connect_And_Interactin_R_Screenshot.png"/>

Consider this notebook your *data playground*.  This is the place where you can test out new ideas, connect and fuse various data sets and try out different visualizations.  If you're happy with something in your notebook, then go ahead and make it available to interact with in your app.

### Step 9.  Click the `app.R` file in the files pane in the lower right of the RStudio IDE
> <img src="https://s10.postimg.org/bllwcjpvd/app.R_screenshot.png"/>

### Step 10.  Click the `Run App` (green triangle) in the top right of the main panel to run the app.  The app should appear in the Viewer pane in the bottom right corner of the IDE.  If it does not, select the little black downward pointing triangle and set to Run in Viewer Pane.
> <img src="https://s10.postimg.org/gx0sx8h2x/Run_App_in_Viewer_Pane_screenshot.png"/>

### Step 11.  Click the little black downward pointing triangle next to the  `Run App` (green triangle) in the top right of the main panel to run the app in another browser window (Run External).
> <img src="https://raw.githubusercontent.com/Davin-IBM/Proof-of-Technology/master/DSX/Lab-3/images/RStudio-lab3-app-external.png"/>

### Step 12.  Interact with your app and consider ways it can be improved.
> <img src="https://s10.postimg.org/ps1n7snvt/DSX_Po_T_Lab_2.png"/>

Notice how your app reacts as you interact with it.  Try out the search in the upper right corner.  Try the filters above the various columns.  Click on the items in the pie graph legend as well as the various wedges in the pie.   

### Step 13.  [Get Inspired!](https://shiny.rstudio.com/gallery/)

You now have an end-to-end skeleton application that uses supply chain data, DB2 Warehouse, and DSX that you can now flesh out into something truly useful in a short amount of time without having to write a lot of code.
