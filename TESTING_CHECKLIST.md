# CareerPrep AI — Testing Checklist

Run automated checks first:

```bash
dart format lib test
flutter analyze
flutter test
flutter build web
```

## Dashboard and navigation
- [ ] App opens without an exception.
- [ ] Every navigation item opens the expected page.
- [ ] Layout remains usable at narrow, medium, and wide browser widths.
- [ ] No important buttons or text are clipped or hidden.

## Questions and quizzes
- [ ] All four categories contain questions.
- [ ] Category, difficulty, and question-count selections are respected.
- [ ] Answer selection, next, previous, skip, and revisit work.
- [ ] Final score is consistent with the selected answers.
- [ ] Review shows the correct answer and explanation.
- [ ] Retake/new quiz starts a fresh attempt.
- [ ] Quiz history records an attempt and remains after a page reload.
- [ ] Clearing history has the intended effect and does not crash.

## Bookmarks and revision
- [ ] A question can be bookmarked and unbookmarked.
- [ ] Bookmark state persists after reload where supported.
- [ ] Revision mode includes bookmarked and previously missed questions.
- [ ] Empty revision state is clear and does not start an invalid quiz.

## Progress and recommendations
- [ ] Empty-state guidance appears before enough quiz data exists.
- [ ] Scores and category summaries match saved attempts.
- [ ] Practice buttons open the intended category quiz.
- [ ] Recommendations update after completing a quiz.

## Resume Analyzer
- [ ] A valid, text-based PDF can be selected and analyzed.
- [ ] Empty job description is validated.
- [ ] Empty/unreadable PDF produces a helpful message.
- [ ] Matched and missing skills reflect the resume text and job description.
- [ ] ATS-style estimate and completeness score remain within 0–100.
- [ ] Skill-gap actions and local interview prompts render correctly.
- [ ] Selecting another file and re-running analysis updates the results.
- [ ] Privacy text clearly explains local/rule-based analysis.

## Regression and browser checks
- [ ] Resume checklist still works.
- [ ] No paid API key or backend is required for local features.
- [ ] Test in the target browser and at mobile-like width.
- [ ] Check browser console for runtime errors.
- [ ] Do not commit real resumes or personal information.

Record any failure with: steps to reproduce, expected result, actual result, browser/device, and console or terminal error.
