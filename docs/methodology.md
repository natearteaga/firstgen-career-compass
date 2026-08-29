# Methodology

This document explains the planned analytical approach for FirstGen Career Compass.

## Analytical Approach

The project will use public occupation and workforce data to identify skills associated with selected analytics roles. The MVP will focus on a small number of target roles so the full workflow can be completed and explained clearly.

The planned workflow is:

1. Select target analytics roles.
2. Identify corresponding O*NET occupations.
3. Ingest public skills and technology data.
4. Clean and standardize role, skill, and tool names.
5. Store the data in relational SQL tables.
6. Analyze skill importance and role differences.
7. Compare a sample student profile to role requirements.
8. Produce transparent skill-gap priorities.
9. Map priority skills to Rutgers and public resources.

## Initial Target Roles

The MVP will likely begin with these roles:

- Business Intelligence Analyst
- Operations Analyst
- Data Analyst or Reporting Analyst

Final role selection will depend on how cleanly each role maps to available public occupation data.

## Primary Data Source

The first data source will be O*NET.

O*NET provides structured occupation data, including knowledge areas, skills, abilities, tasks, and technology skills. For this project, O*NET is being used as a defensible proxy for role skill expectations during the MVP.

Important distinction:

- O*NET describes occupation-level skill and task expectations.
- O*NET does not represent live entry-level job postings by itself.

Because of that, any claim based only on O*NET will be framed as occupation-based skill expectations, not a complete picture of the live job market.

## Possible Additional Sources

Bureau of Labor Statistics data may be added for labor-market context such as employment levels, growth, and wages.

Compliant job-posting APIs may be evaluated after the first vertical slice is complete. Any job-posting source must be legally and ethically usable under its terms.

## Skill Standardization

Skills and tools may appear under different names across sources. The project will maintain a standardized skill table with optional aliases.

Examples:

- `Microsoft Excel`, `Excel`, and `spreadsheets` may need careful distinction.
- `SQL`, `database querying`, and `relational databases` may be related but not identical.
- `Tableau`, `Power BI`, and `data visualization software` may belong to a broader visualization category.

The MVP will avoid over-automating skill normalization. Manual review is acceptable when it improves transparency and accuracy.

## Student Skill Comparison

The MVP will use a sample student profile rather than collecting sensitive personal data.

A student skill profile may include:

- Skill name
- Self-rated proficiency
- Evidence note, such as a course, project, or experience

The gap score will be based on the difference between role expectations and student self-rating. The ranking should remain interpretable and should not be presented as a hiring probability.

## Recommendation Logic

Recommendations will be based on:

- Skill importance for the target role
- Student self-rated gap
- Whether the skill is foundational for multiple analytics roles
- Availability of relevant learning or career resources

The 30-, 60-, or 90-day plan will prioritize a small number of high-value skills rather than overwhelming the student with every possible gap.

## Dashboard Strategy

The dashboard should help viewers quickly understand:

- Top skills by target role
- Differences across roles
- Student strengths and priority gaps
- Recommended resources and next steps

The dashboard is a communication layer, not the analytical engine. The core logic should remain in Python and SQL so the process is reproducible.
