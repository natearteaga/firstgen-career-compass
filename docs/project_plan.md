# Project Plan

This plan focuses on creating a credible proposal and small proof of concept before the September 16, 2026 RU1st Fall Conference application deadline.

## MVP Goal

Build a working vertical slice of FirstGen Career Compass that shows how public occupation data can be used to compare analytics-role skill expectations with a student's self-reported skills and produce a transparent 30-, 60-, or 90-day development plan.

## Phase 1: Foundation

Target dates: August 29 to August 31

- Create the GitHub repository
- Add starter documentation
- Define the MVP problem statement
- Select 2 to 3 target analytics roles
- Choose the first public data source
- Draft the SQL schema
- Document assumptions and limitations

Deliverable:

- Repository structure, README, project plan, methodology draft, limitations draft, and schema draft

## Phase 2: Data Source Setup

Target dates: September 1 to September 3

- Identify the O*NET occupation codes for target roles
- Download or ingest relevant O*NET tables
- Store raw files in `data/raw/`
- Create cleaned reference files in `data/processed/`
- Document data fields and source notes

Deliverable:

- Reproducible O*NET ingestion and cleaning workflow

## Phase 3: SQL Model and Analysis

Target dates: September 4 to September 6

- Finalize schema tables
- Load cleaned data into a local database
- Write SQL queries for top skills by role
- Write SQL queries comparing skill expectations across roles
- Create sample query outputs for dashboard use

Deliverable:

- SQL schema, analysis queries, and dashboard-ready result tables

## Phase 4: Skill Gap Logic

Target dates: September 7 to September 9

- Create a sample student skill profile
- Compare student skills to target role skills
- Rank skill gaps by importance and missing proficiency
- Map priority skills to selected Rutgers or public resources
- Produce an example 30-, 60-, or 90-day plan

Deliverable:

- Transparent skill-gap comparison and sample recommendation output

## Phase 5: Dashboard Prototype

Target dates: September 10 to September 12

- Design dashboard views for role comparison, top skills, skill gaps, and resource recommendations
- Build a basic Power BI dashboard or dashboard prototype
- Export screenshots for documentation and conference proposal use

Deliverable:

- Basic visual prototype showing the analytical story

## Phase 6: Proposal Package

Target dates: September 13 to September 15

- Polish README
- Complete methodology and limitations documentation
- Write proposal summary
- Prepare screenshots and talking points
- Confirm all files run or open correctly

Deliverable:

- Conference-ready proposal materials and portfolio repository draft

## Submission Deadline

September 16, 2026

Submit the RU1st Fall Conference application with a clear project abstract, motivation, methods summary, and proof-of-concept evidence.

## After September 16

Possible portfolio-quality extensions:

- Add BLS employment and wage context
- Add compliant job-posting API data
- Add Streamlit student assessment interface
- Expand roles and occupations
- Improve resource matching
- Build a polished Power BI dashboard
- Add GitHub Actions for scheduled refreshes
