-- ============================================================================
-- ORACLE DATABASE DDL SCRIPT: HEALTHONE MEDICAL DATABASE SYSTEM
-- Generated for Oracle SQL Developer Data Modeler (Import -> DDL File)
-- Includes: 3NF Normalization, Supertype/Subtype (Single Table),
--           Exclusive Arc, Recursive Relationship, and Historical Data
-- ============================================================================

CREATE TABLE INSURANCE_COMPANIES (
    insurance_id   NUMBER(10)    NOT NULL,
    company_name   VARCHAR2(100) NOT NULL,
    contact_phone  VARCHAR2(25),
    CONSTRAINT pk_insurance_companies PRIMARY KEY (insurance_id)
);

CREATE TABLE DOCTORS (
    doctor_id       NUMBER(10)    NOT NULL,
    first_name      VARCHAR2(50)  NOT NULL,
    last_name       VARCHAR2(50)  NOT NULL,
    specialty       VARCHAR2(100) NOT NULL,
    phone_number    VARCHAR2(25)  NOT NULL,
    office_address  VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_doctors PRIMARY KEY (doctor_id)
);

CREATE TABLE HOSPITALS (
    hospital_id       NUMBER(10)    NOT NULL,
    hospital_name     VARCHAR2(150) NOT NULL,
    location_address  VARCHAR2(255) NOT NULL,
    contact_phone     VARCHAR2(25)  NOT NULL,
    CONSTRAINT pk_hospitals PRIMARY KEY (hospital_id)
);

CREATE TABLE PATIENTS (
    patient_id               NUMBER(10)    NOT NULL,
    first_name               VARCHAR2(50)  NOT NULL,
    last_name                VARCHAR2(50)  NOT NULL,
    address                  VARCHAR2(255) NOT NULL,
    phone_number             VARCHAR2(25)  NOT NULL,
    email                    VARCHAR2(100),
    insurance_policy_number  VARCHAR2(50)  NOT NULL,
    insurance_id             NUMBER(10)    NOT NULL,
    primary_doctor_id        NUMBER(10)    NOT NULL,
    holder_patient_id        NUMBER(10),
    CONSTRAINT pk_patients PRIMARY KEY (patient_id),
    CONSTRAINT uk_patients_policy UNIQUE (insurance_policy_number),
    CONSTRAINT fk_patients_insurance FOREIGN KEY (insurance_id)
        REFERENCES INSURANCE_COMPANIES (insurance_id),
    CONSTRAINT fk_patients_pcp FOREIGN KEY (primary_doctor_id)
        REFERENCES DOCTORS (doctor_id),
    CONSTRAINT fk_patients_holder FOREIGN KEY (holder_patient_id)
        REFERENCES PATIENTS (patient_id)
);

CREATE TABLE DOCTOR_AFFILIATIONS (
    affiliation_id  NUMBER(10)    NOT NULL,
    doctor_id       NUMBER(10)    NOT NULL,
    hospital_id     NUMBER(10)    NOT NULL,
    start_date      DATE          NOT NULL,
    role_title      VARCHAR2(100),
    CONSTRAINT pk_doctor_affiliations PRIMARY KEY (affiliation_id),
    CONSTRAINT fk_affil_doctor FOREIGN KEY (doctor_id)
        REFERENCES DOCTORS (doctor_id),
    CONSTRAINT fk_affil_hospital FOREIGN KEY (hospital_id)
        REFERENCES HOSPITALS (hospital_id)
);

CREATE TABLE OFFICE_VISITS (
    visit_id           NUMBER(10)    NOT NULL,
    patient_id         NUMBER(10)    NOT NULL,
    doctor_id          NUMBER(10)    NOT NULL,
    visit_date         DATE          NOT NULL,
    visit_type         VARCHAR2(20)  NOT NULL,
    claim_status       VARCHAR2(30),
    initial_diagnosis  VARCHAR2(255),
    diagnosis_status   VARCHAR2(100),
    blood_pressure     VARCHAR2(20),
    height             NUMBER(5,2),
    weight             NUMBER(5,2),
    CONSTRAINT pk_office_visits PRIMARY KEY (visit_id),
    CONSTRAINT ck_visit_type CHECK (visit_type IN ('NEW_ISSUE', 'FOLLOW_UP', 'ROUTINE_CHECKUP')),
    CONSTRAINT fk_visits_patient FOREIGN KEY (patient_id)
        REFERENCES PATIENTS (patient_id),
    CONSTRAINT fk_visits_doctor FOREIGN KEY (doctor_id)
        REFERENCES DOCTORS (doctor_id)
);

CREATE TABLE DRUGS (
    drug_id       NUMBER(10)     NOT NULL,
    drug_name     VARCHAR2(100)  NOT NULL,
    purpose       VARCHAR2(255)  NOT NULL,
    side_effects  VARCHAR2(500),
    CONSTRAINT pk_drugs PRIMARY KEY (drug_id)
);

CREATE TABLE PRESCRIPTIONS (
    prescription_id    NUMBER(10)     NOT NULL,
    patient_id         NUMBER(10)     NOT NULL,
    doctor_id          NUMBER(10)     NOT NULL,
    drug_id            NUMBER(10)     NOT NULL,
    date_prescribed    DATE           NOT NULL,
    dosage             VARCHAR2(100)  NOT NULL,
    duration           VARCHAR2(50)   NOT NULL,
    rx_type            VARCHAR2(20)   NOT NULL,
    number_of_refills  NUMBER(3),
    refill_size        VARCHAR2(50),
    non_refill_notes   VARCHAR2(255),
    CONSTRAINT pk_prescriptions PRIMARY KEY (prescription_id),
    CONSTRAINT ck_rx_arc CHECK (
        (rx_type = 'REFILLABLE' AND number_of_refills IS NOT NULL AND refill_size IS NOT NULL AND non_refill_notes IS NULL)
        OR
        (rx_type = 'NON_REFILLABLE' AND number_of_refills IS NULL AND refill_size IS NULL)
    ),
    CONSTRAINT fk_rx_patient FOREIGN KEY (patient_id)
        REFERENCES PATIENTS (patient_id),
    CONSTRAINT fk_rx_doctor FOREIGN KEY (doctor_id)
        REFERENCES DOCTORS (doctor_id),
    CONSTRAINT fk_rx_drug FOREIGN KEY (drug_id)
        REFERENCES DRUGS (drug_id)
);

CREATE TABLE PCP_HISTORIES (
    history_id   NUMBER(10)  NOT NULL,
    patient_id   NUMBER(10)  NOT NULL,
    doctor_id    NUMBER(10)  NOT NULL,
    start_date   DATE        NOT NULL,
    end_date     DATE,
    CONSTRAINT pk_pcp_histories PRIMARY KEY (history_id),
    CONSTRAINT fk_pcp_hist_patient FOREIGN KEY (patient_id)
        REFERENCES PATIENTS (patient_id),
    CONSTRAINT fk_pcp_hist_doctor FOREIGN KEY (doctor_id)
        REFERENCES DOCTORS (doctor_id)
);
