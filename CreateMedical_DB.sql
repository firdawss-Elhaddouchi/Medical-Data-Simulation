CREATE DATABASE Medical_db;
USE Medical_db;

CREATE TABLE Medical_db.doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    specialization VARCHAR(255),
    contact_info VARCHAR(255),
    hospital_affiliation VARCHAR(255),
    access_code VARCHAR(255),
    email VARCHAR(255),
    cin INT
);

CREATE TABLE Medical_db.patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender VARCHAR(10),
    date_of_birth DATE,
    email VARCHAR(255),
    address TEXT,
    registration_date DATETIME,
    Medical_History TEXT,
    Chronic_Diseases TEXT
);

CREATE TABLE Medical_db.Diagnoses (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis_name VARCHAR(255),
    doctor_id INT,
    diagnosis_date DATETIME,
    diagnosis_notes TEXT
);

CREATE TABLE Medical_db.Symptoms (
    symptom_id INT PRIMARY KEY,
    patient_id INT,
    symptom_name VARCHAR(255),
    severity VARCHAR(50),
    start_date DATE,
    duration_days INT
);

CREATE TABLE Medical_db.Treatments (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis_id INT,
    treatment_name VARCHAR(255),
    medication_name VARCHAR(255),
    dosage VARCHAR(255),
    treatment_start_date DATE,
    treatment_end_date DATE,
    doctor_id INT,
    treatment_notes TEXT
);

CREATE TABLE Medical_db.Disease_Progression (
    progress_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis_id INT,
    progress_date DATETIME,
    symptom_status VARCHAR(255),
    treatment_effectiveness VARCHAR(255),
    recovery_status VARCHAR(255),
    notes TEXT
);

CREATE TABLE Medical_db.Healing_Ratios (
    healing_id INT PRIMARY KEY,
    diagnosis_id INT,
    treatment_id INT,
    total_cases INT,
    recovered_cases INT,
    death_cases INT,
    recovery_rate FLOAT,
    mortality_rate FLOAT
);

CREATE TABLE Medical_db.Disease (
    disease_id INT PRIMARY KEY,
    disease_name VARCHAR(255),
    Fever VARCHAR(50),
    Cough VARCHAR(50),
    Fatigue VARCHAR(50),
    Difficulty_Breathing VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    Blood_Pressure VARCHAR(50),
    Cholesterol_Level VARCHAR(50),
    Outcome_Variable VARCHAR(255)
);


