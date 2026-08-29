# FirstGen Career Compass

FirstGen Career Compass is a career-readiness analytics portfolio project designed to help first-generation college students understand the skills commonly associated with entry-level analytics roles.

The project translates public labor-market and occupation data into a transparent skills comparison workflow. A student can compare their current skills with target role requirements, identify priority gaps, and connect those gaps to university or public career-development resources.

## Project Motivation

This project is inspired by the experience of preparing for the entry-level analytics job market as a first-generation college student approaching graduation. Many students are capable of doing the work but may not have equal access to the hidden curriculum of internships, professional networks, resume language, technical expectations, and role-specific skill signals.

The goal is not to predict whether a student will be hired. Instead, the project helps students answer a more practical question:

> What skills should I focus on next, and why?

## Conference Theme

Proposed RU1st Fall Conference theme:

**The Hidden Curriculum of Getting Hired: Using Data to Help First-Generation Students Navigate the Entry-Level Job Market**

Target conference date: November 6, 2026  
Application deadline: September 16, 2026

## Primary Questions

1. Which technical and business skills appear most frequently in entry-level analytics-related occupations?
2. How do skill expectations differ across roles such as Business Intelligence Analyst, Operations Analyst, and Data Analyst?
3. How can a student compare their existing skills with target role expectations?
4. Which skill gaps should the student prioritize first?
5. Which Rutgers or public resources can help address those gaps?

## MVP Scope

The September 16 proof of concept will focus on a realistic vertical slice:

- 2 to 3 target analytics roles
- At least one reliable public data source
- A reproducible Python data ingestion and cleaning workflow
- A documented relational SQL schema
- SQL queries that answer the main analytical questions
- A basic dashboard prototype or dashboard-ready output tables
- A simple skills-gap comparison using a sample student profile
- Clear assumptions, limitations, and next steps

## Initial Data Strategy

The MVP will use O*NET as the primary source for structured occupation and skills data. O*NET is a credible public source maintained for occupational research and workforce development.

Possible later additions:

- Bureau of Labor Statistics data for employment and wage context
- CareerOneStop data if API access is approved and useful
- Compliant job-posting API data if terms, cost, and time constraints are manageable

This project will not scrape LinkedIn or any other site in violation of its terms.

## Planned Technical Stack

- Python for ingestion, cleaning, analysis, and automation
- SQL for relational modeling and analysis
- PostgreSQL as the target database design
- SQLite or DuckDB as a lightweight local development option if needed
- Power BI or another dashboard layer for visualization
- Git and GitHub for version control and documentation

## Repository Structure

```text
data/        Raw, processed, and reference data files
dashboard/   Dashboard prototypes and dashboard-ready exports
docs/        Methodology, planning notes, assumptions, and limitations
sql/         Schema definitions and analysis queries
src/         Python source code for ingestion, cleaning, and analysis
tests/       Tests for data cleaning and recommendation logic
```

## Current Status

Project setup is underway. The first phase focuses on documentation, scope control, schema design, and data-source selection before writing substantial code.

## Guiding Principles

- Keep the MVP realistic.
- Build a working vertical slice before expanding features.
- Separate data processing from presentation.
- Make recommendations transparent and traceable to data.
- Avoid collecting sensitive student information during the MVP.
- Treat data quality, bias, and coverage gaps as explicit limitations.
