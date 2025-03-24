import pandas as pd
import mysql.connector


file_path = "medicalRecords_DB.xlsx"
xls = pd.ExcelFile(file_path)


sheets_to_tables = {
    "doctors": ["doctor_id", "first_name", "last_name", "specialization","contact_info","hospital_affiliation","access_code", "email","cin"],
    "patients": ["patient_id", "first_name", "last_name", "gender", "date_of_birth", "email", "address","registration_date","Medical_History","Chronic_Diseases"],
    "Diagnoses": ["diagnosis_id","patient_id","diagnosis_name","doctor_id","diagnosis_date","diagnosis_notes"],
    "Symptoms": ["symptom_id","patient_id","symptom_name","severity","start_date","duration_days"],
    "Treatments": ["treatment_id","patient_id","diagnosis_id","treatment_name","medication_name","dosage","treatment_start_date","treatment_end_date","doctor_id","treatment_notes"],
    "Disease_Progression": ["progress_id","patient_id","diagnosis_id","progress_date","symptom_status","treatment_effectiveness","recovery_status","notes"],
    "Healing_Ratios": ["healing_id","diagnosis_id","treatment_id","total_cases","recovered_cases","death_cases","recovery_rate","mortality_rate"],
    "Disease":["disease_id","disease_name","Fever","Cough","Fatigue","Difficulty_Breathing","Age","Gender","Blood_Pressure","Cholesterol_Level","Outcome_Variable"]
}

  
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="firdawss1111mysql",
    database="Medical_db"
)
cursor = conn.cursor()
for sheet, correct_order in sheets_to_tables.items():
    try:
       # Read paper data
        df = pd.read_excel(xls, sheet_name=sheet)
        df.columns = df.columns.str.strip()
        print(f"Columns in {sheet}:", df.columns)
        df.rename(columns={"old_column_name": "new_column_name"}, inplace=True)
        
        # Ensure that all columns exist
        df = df[correct_order]  

        # Address blank values (convert NaN to NULL when you enter in MySQL)
        
        df.fillna(value="NULL", inplace=True)

        # Processing listing query
        columns = ", ".join(df.columns)
        placeholders = ", ".join(["%s"] * len(df.columns))
        update_clause = ", ".join([f"{col} = VALUES({col})" for col in df.columns if col != df.columns[0]])
        sql = f"INSERT INTO {sheet} ({columns}) VALUES ({placeholders}) ON DUPLICATE KEY UPDATE {update_clause}"
        
       # Data insertion
        for row in df.itertuples(index=False, name=None):
            cursor.execute(sql, row)

        conn.commit()
        print(f"✅Data from '{sheet}' imported successfully into MySQL!")

    except Exception as e:
        print(f"❌Error processing '{sheet}': {e}")


cursor.close()
conn.close()
