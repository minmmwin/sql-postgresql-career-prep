# Dataset Inspection & Planning

## 1. Store & Organize the Raw File

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
Original NYC 311 export files are very large and are not uploaded to GitHub
A filtered subset dataset was created for SQL learning and performance
The subset dataset was generated from the December 2025 NYC 311 export
The data/raw/ directory in GitHub contains a README file only for documentation purposes
---

## 2. Open the CSV for Inspection

### A. Basic shape
Approximate number of rows: 340000
Approximate number of columns: 12

### B. Key columns to identify
Unique Key
Created Date
Closed Date
Agency
Agency Name
Complaint Type
Descriptor
Status
Borough
Incident Zip
Latitude
Longitude
---

## 3. Data Quality Check
Scan first 3000 rows visually and note:
Unique Key: No NULL
Created Date: consistent, No NULL
Closed Date: consistent, sometimes NULL
Agency: No NULL
Agency Name: No NULL
Complaint Type: No NULL
Descriptor: few N/A, No Access, Other
Status: No NULL
Borough: No NULL
Incident Zip: rare NULL values observed
Latitude: sometimes NULL
Longitude: sometimes NULL
---

## 4. Decide What You Will Import
### A. What’s the core grain?
One row = one 311 service request

### B. What columns are must-have for learning?
Unique Key
Created Date
Closed Date
Agency
Complaint Type
Status
Borough
Incident Zip

---

## 5. Draft a Staging Table

### A. Initial staging table design
Plain text
stg_311_requests
- request_id        (mapped from unique_key)
- created_date
- closed_date
- agency
- complaint_type
- status
- borough
- incident_zip

### B. Initial observations
Dates will require conversion to PostgreSQL timestamp format
Some location fields contain NULL values
Complaint descriptions may require cleaning and standardization
Latitude and longitude can support future geospatial analysis
