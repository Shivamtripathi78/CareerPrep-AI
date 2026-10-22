# CareerPrep AI Resume Analysis Backend

This backend keeps the OpenAI API key off the Flutter client. It accepts resume text and a job description and returns structured coaching feedback.

## 1. Configure

Use Python 3.10+.

```powershell
cd D:\Codes\CareerPrep-AI\careerprep_ai_backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
```

Open `.env` and set `OPENAI_API_KEY` to your own secret API key. Never put this key in Flutter code, commit it to Git, or share it publicly. API usage may incur charges.

## 2. Start the API

```powershell
uvicorn main:app --reload --host 127.0.0.1 --port 8000
```

Check `http://127.0.0.1:8000/health` and expect `{"status":"ok"}`.

## 3. Add the Flutter dependency

From the Flutter project root in another terminal:

```powershell
flutter pub add http
```

Replace `lib/main.dart` with the supplied updated `main.dart`, then run:

```powershell
dart format lib/main.dart
flutter analyze
flutter test
flutter run -d web-server --web-port 8080
```

The existing local keyword analysis remains available. Click **Get AI-powered analysis** to call the backend.

If the backend is on a different host, pass the URL at build/run time, for example:

```powershell
flutter run -d web-server --web-port 8080 --dart-define=RESUME_AI_API_URL=http://127.0.0.1:8000/analyze-resume
```

## Privacy and production notes

- Resume text and the job description are sent to the backend and then to the configured AI provider only when the AI analysis button is clicked.
- Do not log request bodies. Obtain user consent and set a retention policy before production deployment.
- For production, use HTTPS, restrict `CORS_ORIGINS` to your actual frontend domain, add authentication/rate limiting, and configure hosting/network access.
- The match score is an AI estimate, not a real ATS score or hiring probability.
- This development backend binds to loopback. A deployed frontend cannot reach a developer's localhost; deploy the API and configure `RESUME_AI_API_URL` accordingly.
