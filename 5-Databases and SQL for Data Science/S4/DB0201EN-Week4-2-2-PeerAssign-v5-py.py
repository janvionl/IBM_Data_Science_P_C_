#!/usr/bin/env python
# coding: utf-8

# <a href="https://cognitiveclass.ai"><img src = "https://ibm.box.com/shared/static/ugcqz6ohbvff804xp84y4kqnvvk3bq1g.png" width = 300, align = "center"></a>
# 
# <h1 align=center><font size = 5>Assignment: Notebook for Peer Assignment</font></h1>

# # Introduction
# 
# Using this Python notebook you will:
# 1. Understand 3 Chicago datasets  
# 1. Load the 3 datasets into 3 tables in a Db2 database
# 1. Execute SQL queries to answer assignment questions 

# ## Understand the datasets 
# To complete the assignment problems in this notebook you will be using three datasets that are available on the city of Chicago's Data Portal:
# 1. <a href="https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2">Socioeconomic Indicators in Chicago</a>
# 1. <a href="https://data.cityofchicago.org/Education/Chicago-Public-Schools-Progress-Report-Cards-2011-/9xs2-f89t">Chicago Public Schools</a>
# 1. <a href="https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2">Chicago Crime Data</a>
# 
# ### 1. Socioeconomic Indicators in Chicago
# This dataset contains a selection of six socioeconomic indicators of public health significance and a “hardship index,” for each Chicago community area, for the years 2008 – 2012.
# 
# For this assignment you will use a snapshot of this dataset which can be downloaded from:
# https://ibm.box.com/shared/static/05c3415cbfbtfnr2fx4atenb2sd361ze.csv
# 
# A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at:
# https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2
# 
# 
# 
# ### 2. Chicago Public Schools
# 
# This dataset shows all school level performance data used to create CPS School Report Cards for the 2011-2012 school year. This dataset is provided by the city of Chicago's Data Portal.
# 
# For this assignment you will use a snapshot of this dataset which can be downloaded from:
# https://ibm.box.com/shared/static/f9gjvj1gjmxxzycdhplzt01qtz0s7ew7.csv
# 
# A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at:
# https://data.cityofchicago.org/Education/Chicago-Public-Schools-Progress-Report-Cards-2011-/9xs2-f89t
# 
# 
# 
# 
# ### 3. Chicago Crime Data 
# 
# This dataset reflects reported incidents of crime (with the exception of murders where data exists for each victim) that occurred in the City of Chicago from 2001 to present, minus the most recent seven days. 
# 
# This dataset is quite large - over 1.5GB in size with over 6.5 million rows. For the purposes of this assignment we will use a much smaller sample of this dataset which can be downloaded from:
# https://ibm.box.com/shared/static/svflyugsr9zbqy5bmowgswqemfpm1x7f.csv
# 
# A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at:
# https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2
# 

# ### Download the datasets
# In many cases the dataset to be analyzed is available as a .CSV (comma separated values) file, perhaps on the internet. Click on the links below to download and save the datasets (.CSV files):
# 1. __CENSUS_DATA:__ https://ibm.box.com/shared/static/05c3415cbfbtfnr2fx4atenb2sd361ze.csv
# 1. __CHICAGO_PUBLIC_SCHOOLS__  https://ibm.box.com/shared/static/f9gjvj1gjmxxzycdhplzt01qtz0s7ew7.csv
# 1. __CHICAGO_CRIME_DATA:__ https://ibm.box.com/shared/static/svflyugsr9zbqy5bmowgswqemfpm1x7f.csv
# 
# __NOTE:__ Ensure you have downloaded the datasets using the links above instead of directly from the Chicago Data Portal. The versions linked here are subsets of the original datasets and have some of the column names modified to be more database friendly which will make it easier to complete this assignment.

# ### Store the datasets in database tables
# To analyze the data using SQL, it first needs to be stored in the database.
# 
# While it is easier to read the dataset into a Pandas dataframe and then PERSIST it into the database as we saw in Week 3 Lab 3, it results in mapping to default datatypes which may not be optimal for SQL querying. For example a long textual field may map to a CLOB instead of a VARCHAR. 
# 
# Therefore, __it is highly recommended to manually load the table using the database console LOAD tool, as indicated in Week 2 Lab 1 Part II__. The only difference with that lab is that in Step 5 of the instructions you will need to click on create "(+) New Table" and specify the name of the table you want to create and then click "Next". 
# 
# <img src = "https://ibm.box.com/shared/static/uc4xjh1uxcc78ks1i18v668simioz4es.jpg">
# 
# ##### Now open the Db2 console, open the LOAD tool, Select / Drag the .CSV file for the first dataset, Next create a New Table, and then follow the steps on-screen instructions to load the data. Name the new tables as folows:
# 1. __CENSUS_DATA__
# 1. __CHICAGO_PUBLIC_SCHOOLS__
# 1. __CHICAGO_CRIME_DATA__

# ### Connect to the database 
# Let us first load the SQL extension and establish a connection with the database

# In[1]:


get_ipython().run_line_magic('load_ext', 'sql')


# In the next cell enter your db2 connection string. Recall you created Service Credentials for your Db2 instance in first lab in Week 3. From the __uri__ field of your Db2 service credentials copy everything after db2:// (except the double quote at the end) and paste it in the cell below after ibm_db_sa://
# 
# <img src ="https://ibm.box.com/shared/static/hzhkvdyinpupm2wfx49lkr71q9swbpec.jpg">

# In[2]:


# Remember the connection string is of the format:
# %sql ibm_db_sa://my-username:my-password@my-hostname:my-port/my-db-name
# Enter the connection string for your Db2 on Cloud database instance below
get_ipython().run_line_magic('sql', 'ibm_db_sa://lpn29123:rpg36611k4%5E5cc68@dashdb-txn-sbox-yp-lon02-01.services.eu-gb.bluemix.net:50000/BLUDB')


# ## Problems
# Now write and execute SQL queries to solve assignment problems
# 
# ### Problem 1
# 
# ##### Find the total number of crimes recorded in the CRIME table

# In[4]:


# Rows in Crime table
get_ipython().run_line_magic('sql', 'SELECT COUNT(*)FROM CRIME;')


# ### Problem 2
# 
# ##### Retrieve first 10 rows from the CRIME table
# 

# In[12]:


get_ipython().run_line_magic('sql', 'SELECT * FROM CRIME LIMIT 10;')


# ### Problem 3
# 
# ##### How many crimes involve an arrest?

# In[8]:


get_ipython().run_line_magic('sql', "SELECT COUNT(*) FROM CRIME WHERE arrest = 'TRUE';")
# 163 crimes


# ### Problem 4
# 
# ##### Which unique types of crimes have been recorded at GAS STATION locations?
# 

# In[13]:


get_ipython().run_line_magic('sql', "SELECT DISTINCT * FROM CRIME WHERE location_description = 'GAS STATION';")


# Hint: Which column lists types of crimes e.g. THEFT?

# ### Problem 5
# 
# ##### In the CENUS_DATA table list all Community Areas whose names start with the letter ‘B’.

# In[14]:


get_ipython().run_line_magic('sql', 'SELECT * FROM INDICATORS LIMIT 10;')


# In[18]:


get_ipython().run_line_magic('sql', "SELECT community_area_name FROM INDICATORS WHERE community_area_name LIKE 'B%';")


# ### Problem 6
# 
# ##### Which schools in Community Areas 10 to 15 are healthy school certified?

# In[23]:


get_ipython().run_line_magic('sql', 'SELECT * FROM SCHOOLS LIMIT 5;')


# In[22]:


get_ipython().run_line_magic('sql', "SELECT name_of_school FROM SCHOOLS WHERE community_area_number in (10, 11, 12, 13, 14, 15) AND healthy_school_certified = 'Yes';")


# ### Problem 7
# 
# ##### What is the average school Safety Score? 

# In[24]:


get_ipython().run_line_magic('sql', 'SELECT AVG(safety_score) as Moyenne FROM SCHOOLS;')


# ### Problem 8
# 
# ##### List the top 5 Community Areas by average College Enrollment [number of students] 

# In[29]:


get_ipython().run_line_magic('sql', 'SELECT community_area_name, AVG(college_enrollment) AS Moyenne FROM SCHOOLS GROUP BY community_area_name ORDER BY AVG(college_enrollment) DESC LIMIT 5;')


# ### Problem 9
# 
# ##### Use a sub-query to determine which Community Area has the least value for school Safety Score? 

# In[30]:


get_ipython().run_line_magic('sql', 'SELECT community_area_name, safety_score FROM SCHOOLS WHERE safety_score = (SELECT MIN(safety_score) FROM SCHOOLS);')


# ### Problem 10
# 
# ##### [Without using an explicit JOIN operator] Find the Per Capita Income of the Community Area which has a school Safety Score of 1.

# In[32]:


get_ipython().run_line_magic('sql', 'SELECT S.community_area_name, S.safety_score, I.per_capita_income FROM SCHOOLS S, INDICATORS I WHERE S.community_area_number = I.community_area_number AND S.safety_score = 1;')


# In[ ]:





# In[ ]:





# Copyright &copy; 2018 [cognitiveclass.ai](cognitiveclass.ai?utm_source=bducopyrightlink&utm_medium=dswb&utm_campaign=bdu). This notebook and its source code are released under the terms of the [MIT License](https://bigdatauniversity.com/mit-license/).
# 
