# Lab 11: Instruments – Measure, Diagnose, Improve

## Objective
To identify and improve unnecessary repeated work in a SwiftUI course list using Xcode Instruments.

## Test Environment
- Device/Simulator: [Your simulator model]
- iOS Version: [Version]
- Xcode Version: [Version]
- Build Configuration: [Debug/Release]
- Dataset: 10,000 courses
- Workload: Launch app, search "swift", search "development", clear search and scroll for approximately 30 seconds.

## Issue Identified
The baseline implementation repeatedly converted course titles and categories to lowercase while filtering the list. Filtering was also performed whenever the computed results property was accessed during view updates.

## Improvement
Precomputed a normalized searchable string for each course and moved filtering into an update function triggered by search text changes. The course dataset was kept static to avoid regenerating it during view reconstruction.

## Before and After Measurements

| Metric | Before | After |
|---|---|---|
| CPU usage | [Actual value] | [Actual value] |
| Filtering time | [Actual value] | [Actual value] |
| Allocations | [Actual value] | [Actual value] |
| Peak memory | [Actual value] | [Actual value] |

## Results and Analysis
[Explain what Instruments showed. Mention whether filtering time, CPU usage or allocations changed. If no measurable improvement was observed, state that honestly.]

## Conclusion
This exercise demonstrated how Time Profiler and Allocations can help identify repeated work and evaluate a targeted optimization. The results are based on measurements collected under the same test conditions.

## Evidence
- Before optimization: Lab11-Before.trace
- After optimization: Lab11-After.trace
- Screenshot: Before Instruments results
- Screenshot: After Instruments results
