# **Dataset Inspection & Planning**

### **1\. Store & Organize the Raw File**
Project structure used locally:
```text
etl_real_world_data/
│
├── data/
│   ├── raw/
│   │   └── 311_Dec_2025_subset.csv
│   │
│   └── cleaned/
│
├── python/
│
├── sql/
│
└── README.md
```
### Dataset Notes
- Original NYC 311 export files are very large and are not uploaded to GitHub
- A filtered subset dataset was created for SQL learning and performance
- The subset dataset was generated from the December 2025 NYC 311 export
- The data/raw/ directory in GitHub contains a README file only for documentation purposes

### **2\. Open the CSV for Inspection**

### **A. Basic shape** 

Approximate number of rows? 340000  
Approximate number of columns? 45

### **B. Key columns to identify**

Unique Key  
Created Date  
Closed Date  
Agency  
Agency Name  
Problem (formerly Complaint Type)  
Problem Detail (formerly Descriptor)  
Status  
Borough  
Incident Zip  
Latitude  
Longitude

### **3\. Data Quality Check**

Scan first 3000 rows visually and note:  
Unique Key: No NULL  
Created Date: consistent, No NULL  
Closed Date: consistent, Sometimes NULL   
Agency: No NULL  
Agency Name: No NULL  
Problem (formely Complaint Type): No NULL, No N/A  
Problem Detail (formely Descriptor): few N/A, No Access, Other  
Status: No NULL  
Borough: No NULL  
Incident Zip: rare NULL values (observed 1)  
Latitude: sometimes NULL  
Longitude: sometimes NULL

### **4\. Decide What You Will Import**

### **A. What’s the core gain?**

One row \= one 311 service request

### **B. What columns are must-have for learning?**

Unique Key  
Created Date  
Closed Date  
Agency  
Problem (formely Complaint Type)  
Status  
Borough  
Incident Zip

### **5\. Draft a Staging Table**

### **A. Initial staging table design**

stg\_311\_requests  
\- request\_id (mapped from unique\_key)  
\- created\_date  
\- closed\_date  
\- agency  
\- complaint\_type  
\- status  
\- borough  
\- incident\_zip
