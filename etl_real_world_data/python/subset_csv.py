import pandas as pd

src = r"C:\Users\Administrator\Documents\OneDrive\Data Analysis 2026\sql-postgresql-career-prep\03_etl_real_world_data\data\raw\311_Service_Requests_from_December_2025.csv"
dst = r"C:\Users\Administrator\Documents\OneDrive\Data Analysis 2026\sql-postgresql-career-prep\03_etl_real_world_data\data\raw\311_Dec_2025_subset.csv"

df = pd.read_csv(src, dtype=str, low_memory=False)

print(df.columns.tolist())  # run once to see the exact header names

keep = [
    "Unique Key",
    "Created Date",
    "Closed Date",
    "Agency",
    "Agency Name",
    "Problem (formerly Complaint Type)",
    "Problem Detail (formerly Descriptor)",
    "Status",
    "Borough",
    "Incident Zip",
    "Latitude",
    "Longitude",
]

df2 = df[keep].copy()
df2.to_csv(dst, index=False)
print("Wrote:", dst, "rows:", len(df2))
