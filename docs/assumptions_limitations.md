# Assumptions and Limitations

This project is intended to support career exploration and skill planning. It should not be interpreted as a hiring prediction tool.

## Core Assumptions

- Public occupation data can provide a useful starting point for understanding analytics-role skill expectations.
- First-generation students may benefit from clearer translation between job-market language and actionable skill development.
- A transparent skills comparison can help students prioritize learning without making unrealistic promises.
- A small proof of concept can be valuable if its scope and limitations are clearly stated.

## What The MVP Can Claim

The MVP can claim to:

- Identify skills associated with selected analytics-related occupations.
- Compare skill expectations across a small number of roles.
- Show a transparent comparison between a sample student profile and role expectations.
- Recommend learning priorities based on visible rules.
- Connect priority skills to selected Rutgers or public resources.

## What The MVP Cannot Claim

The MVP cannot claim to:

- Predict whether a student will get hired.
- Represent every employer or every analytics job posting.
- Fully capture internship, networking, interviewing, or credential effects.
- Replace career advising.
- Prove causation between a skill and a job offer.

## Data Limitations

O*NET is occupation-level data, not live job-posting data. It may not fully reflect current entry-level hiring trends, employer-specific requirements, or local New Jersey market conditions.

If BLS data is added, it will provide labor-market context but not detailed skill requirements.

If job-posting API data is added later, it may still be limited by coverage, rate limits, source bias, duplicate postings, missing salary fields, and inconsistent job descriptions.

## Bias and Equity Considerations

Job-market data can reflect existing inequities. If employers overstate requirements, use vague language, or favor certain credentials, the data may reproduce those patterns.

The project should avoid telling students that they are deficient as people. The framing should be:

> These are visible market signals, and these are practical ways to prepare for them.

## Privacy Considerations

The MVP should avoid collecting personally identifiable or sensitive student data.

Recommended MVP approach:

- Use a sample student profile.
- Store only skill self-ratings and optional non-sensitive evidence notes.
- Avoid names, student IDs, financial information, immigration status, disability status, or other sensitive attributes.

## Recommendation Limitations

The recommendation logic will be rule-based and transparent. It will not use machine learning unless a later version shows a clear reason to do so.

Recommendations should be treated as planning guidance, not official academic, career, financial, or employment advice.

## Presentation Limitations

The September 16 version is a proof of concept. It should be evaluated as an early analytical prototype, not as a finished student-facing product.
