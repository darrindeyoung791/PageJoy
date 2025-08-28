# PageJoy Backend

This is the backend service for PageJoy, built with FastAPI.

## Setup

1. Create a virtual environment:
   ```
   python -m venv venv
   ```

2. Activate the virtual environment:
   - On Windows: `venv\Scripts\activate`
   - On macOS/Linux: `source venv/bin/activate`

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Run the development server:
   ```
   uvicorn main:app --reload
   ```

## Project Structure

- `main.py`: Entry point of the application
- `models/`: Database models
- `schemas/`: Pydantic schemas for API validation
- `routers/`: API route definitions
- `database.py`: Database connection and session management