# PageJoy Backend

This is the backend service for PageJoy, built with FastAPI.

## Setup

1. Create a virtual environment:
   ```bash
   python -m venv venv
   ```

2. Activate the virtual environment:
   - On Windows: `venv\Scripts\activate`
   - On macOS/Linux: `source venv/bin/activate`

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the development server:
   ```bash
   uvicorn main:app --reload
   ```

## Project Structure

- `main.py`: Entry point of the application
- `database.py`: Database connection and session management
- `models/`: Database models
- `schemas/`: Pydantic schemas for API validation
- `routers/`: API route definitions
- `alembic/`: Database migration files
- `alembic.ini`: Alembic configuration

## API Documentation

Once the server is running, you can access the API documentation at:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Database Migrations

To create a new migration:
```bash
alembic revision --autogenerate -m "Migration message"
```

To apply migrations:
```bash
alembic upgrade head
```

To downgrade migrations:
```bash
alembic downgrade -1
```