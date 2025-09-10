from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models.models import Base
from database import SQLALCHEMY_DATABASE_URL

# Create engine
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

# Create all tables
Base.metadata.create_all(bind=engine)

print("Database and tables created successfully.")