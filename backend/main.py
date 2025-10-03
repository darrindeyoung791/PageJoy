from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models import models
from database import engine, SessionLocal
from routers import users, articles, magazines, subscription_plans, user_subscriptions, payments, likes, follows, favorites

# 确保在创建表之前导入了所有模型
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="PageJoy API", description="API for PageJoy application", version="0.1.0")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(users.router)
app.include_router(articles.router)
app.include_router(magazines.router)
app.include_router(subscription_plans.router)
app.include_router(user_subscriptions.router)
app.include_router(payments.router)
app.include_router(likes.router)
app.include_router(favorites.router)
app.include_router(follows.router)

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/health")
def health_check():
    return {"status": "ok"}

# 依赖项函数
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()