from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import UserSubscription
from schemas.schemas import UserSubscriptionCreate, UserSubscription, UserSubscriptionUpdate

router = APIRouter(prefix="/user-subscriptions", tags=["user_subscriptions"])

@router.post("/", response_model=UserSubscription)
def create_user_subscription(subscription: UserSubscriptionCreate, db: Session = Depends(get_db)):
    db_subscription = UserSubscription(**subscription.dict())
    db.add(db_subscription)
    db.commit()
    db.refresh(db_subscription)
    return db_subscription

@router.get("/{subscription_id}", response_model=UserSubscription)
def read_user_subscription(subscription_id: int, db: Session = Depends(get_db)):
    db_subscription = db.query(UserSubscription).filter(UserSubscription.id == subscription_id).first()
    if db_subscription is None:
        raise HTTPException(status_code=404, detail="User subscription not found")
    return db_subscription

@router.get("/", response_model=List[UserSubscription])
def read_user_subscriptions(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    subscriptions = db.query(UserSubscription).offset(skip).limit(limit).all()
    return subscriptions

@router.put("/{subscription_id}", response_model=UserSubscription)
def update_user_subscription(subscription_id: int, subscription: UserSubscriptionUpdate, db: Session = Depends(get_db)):
    db_subscription = db.query(UserSubscription).filter(UserSubscription.id == subscription_id).first()
    if db_subscription is None:
        raise HTTPException(status_code=404, detail="User subscription not found")
    
    for key, value in subscription.dict(exclude_unset=True).items():
        setattr(db_subscription, key, value)
    
    db.commit()
    db.refresh(db_subscription)
    return db_subscription

@router.delete("/{subscription_id}", response_model=UserSubscription)
def delete_user_subscription(subscription_id: int, db: Session = Depends(get_db)):
    db_subscription = db.query(UserSubscription).filter(UserSubscription.id == subscription_id).first()
    if db_subscription is None:
        raise HTTPException(status_code=404, detail="User subscription not found")
    
    db.delete(db_subscription)
    db.commit()
    return db_subscription