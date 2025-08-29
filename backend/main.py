from fastapi import FastAPI
from database import engine, Base
import models
from routers import users, articles, magazines, subscription_plans, user_subscriptions, payments, likes, follows

# Create all tables
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="PageJoy API", description="API for PageJoy application", version="0.1.0")

# Include routers
app.include_router(users.router)
app.include_router(articles.router)
app.include_router(magazines.router)
app.include_router(subscription_plans.router)
app.include_router(user_subscriptions.router)
app.include_router(payments.router)
app.include_router(likes.router)
app.include_router(follows.router)

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/health")
def health_check():
    return {"status": "ok"}