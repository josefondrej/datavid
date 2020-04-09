CREATE TYPE SEX AS ENUM (
    'male',
    'female'
    );

CREATE TYPE DIAGNOSTIC_TOOL AS ENUM (
    'PCR',
    'serology',
    'clinical'
    );

CREATE TYPE OUTCOME_OF_PATIENT AS ENUM (
    'cured',
    'died'
    );

CREATE TABLE patients (
    uuid                      BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    first_name                VARCHAR,
    family_name               VARCHAR,
    identifier                VARCHAR,
    age                       INT,
    sex                       SEX,
    date_first_symptoms       TIMESTAMP,
    disease_confirmation_type DIAGNOSTIC_TOOL,
    disease_confirmation_date TIMESTAMP,
    outcome_of_patient        OUTCOME_OF_PATIENT
);

CREATE TABLE comorbidities (
    uuid        BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    comorbidity VARCHAR
);

CREATE TABLE medications (
    uuid       BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    medication VARCHAR
);

CREATE TABLE epidemilogical_anamnesis (
    uuid      BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    anamnesis VARCHAR
);

CREATE TABLE symptoms (
    uuid    BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    symptom VARCHAR
);

CREATE TABLE complications (
    uuid         BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    complication VARCHAR
);

CREATE TABLE therapies (
    uuid    BIGSERIAL UNIQUE NOT NULL PRIMARY KEY,
    therapy VARCHAR
);

CREATE TYPE SEVERITY AS ENUM (
    'mild',
    'normal',
    'severe'
    );

CREATE TABLE patient_comorbidity (
    patient_uuid     BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    comorbidity_uuid BIGINT REFERENCES comorbidities(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    severity         SEVERITY,
    PRIMARY KEY (patient_uuid, comorbidity_uuid)
);

CREATE TABLE patient_medication (
    patient_uuid    BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    medication_uuid BIGINT REFERENCES medications(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (patient_uuid, medication_uuid)
);

CREATE TABLE patient_epidemilogical_anamnesis (
    patient_uuid                  BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    epidemilogical_anamnesis_uuid BIGINT REFERENCES epidemilogical_anamnesis(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (patient_uuid, epidemilogical_anamnesis_uuid)
);

CREATE TABLE patient_symptom (
    patient_uuid BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    symptom_uuid BIGINT REFERENCES symptoms(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    severity     SEVERITY,
    PRIMARY KEY (patient_uuid, symptom_uuid)
);

CREATE TABLE patient_complication (
    patient_uuid      BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    complication_uuid BIGINT REFERENCES complications(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    severity          SEVERITY,
    PRIMARY KEY (patient_uuid, complication_uuid)
);

CREATE TABLE patient_therapy (
    patient_uuid  BIGINT REFERENCES patients(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    therapy_uuid  BIGINT REFERENCES therapies(uuid) ON UPDATE CASCADE ON DELETE CASCADE,
    therapy_start TIMESTAMP,
    therapy_end   TIMESTAMP,
    PRIMARY KEY (patient_uuid, therapy_uuid)
);