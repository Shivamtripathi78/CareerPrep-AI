# CareerPrep AI — Flutter Web Deployment

## 1. Verify a production build locally

From the project root:

```bash
flutter pub get
flutter analyze
flutter test
flutter build web --release
```

The static web output is generated in `build/web/`. Test the built app in a browser before publishing. Do not deploy a debug build.

## 2. GitHub Pages considerations

GitHub Pages serves static files, so it can host the Flutter Web build. If the app is published below a repository subpath, configure Flutter's base href for that subpath when building. For a repository named `careerprep-ai`, the base path is commonly `/careerprep-ai/`:

```bash
flutter build web --release --base-href /careerprep-ai/
```

Use `/` only when the site is served from the domain root. Deploy the contents of `build/web/` (not the entire Flutter source folder) using a Pages workflow or the repository's configured Pages publishing method. Confirm the exact repository name and URL before setting the base href.

## 3. Alternative static hosting

For a static host that serves the site at its own root, build with the default base href and publish the contents of `build/web/`. Configure SPA/static fallback only if required by the hosting provider. Since this app primarily uses Flutter's client-side routing, refresh behavior should be tested on the deployed URL.

## 4. Before making the repository public

- Remove local secrets, `.env` files, personal resumes, and private exports.
- Review `pubspec.yaml` and `pubspec.lock` and keep dependency declarations consistent.
- Add real screenshots with personal data removed.
- Choose a license if you intend to grant reuse rights.
- Do not describe the heuristic resume score as a real ATS score or a guarantee of selection.
- Verify that the production build works from the actual deployment subpath.
