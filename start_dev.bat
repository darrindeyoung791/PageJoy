@echo off
echo Starting PageJoy Development Environment

echo.
echo Starting Backend Server...
cd backend
start "Backend Server" /D "%CD%" cmd /k "venv\Scripts\activate && uvicorn main:app --host 127.0.0.1 --port 8001 --reload"
cd ..

echo.
echo Starting Frontend Server...
cd app
start "Frontend Server" /D "%CD%" cmd /k "flutter run"
cd ..

echo.
echo Development environment started!
echo Backend API available at: http://127.0.0.1:8001
echo Frontend app will start on an available port
pause