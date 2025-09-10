from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import SubscriptionPlan as SubscriptionPlanModel
from schemas.schemas import SubscriptionPlanCreate, SubscriptionPlan, SubscriptionPlanUpdate

router = APIRouter(prefix="/subscription-plans", tags=["subscription_plans"])

@router.post("/", response_model=SubscriptionPlan)
def create_subscription_plan(plan: SubscriptionPlanCreate, db: Session = Depends(get_db)):
    db_plan = SubscriptionPlanModel(**plan.dict())
    db.add(db_plan)
    db.commit()
    db.refresh(db_plan)
    return db_plan

@router.get("/{plan_id}", response_model=SubscriptionPlan)
def read_subscription_plan(plan_id: int, db: Session = Depends(get_db)):
    db_plan = db.query(SubscriptionPlanModel).filter(SubscriptionPlanModel.id == plan_id).first()
    if db_plan is None:
        raise HTTPException(status_code=404, detail="Subscription plan not found")
    return db_plan

@router.get("/", response_model=List[SubscriptionPlan])
def read_subscription_plans(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    plans = db.query(SubscriptionPlanModel).offset(skip).limit(limit).all()
    return plans

@router.put("/{plan_id}", response_model=SubscriptionPlan)
def update_subscription_plan(plan_id: int, plan: SubscriptionPlanUpdate, db: Session = Depends(get_db)):
    db_plan = db.query(SubscriptionPlanModel).filter(SubscriptionPlanModel.id == plan_id).first()
    if db_plan is None:
        raise HTTPException(status_code=404, detail="Subscription plan not found")
    
    for key, value in plan.dict(exclude_unset=True).items():
        setattr(db_plan, key, value)
    
    db.commit()
    db.refresh(db_plan)
    return db_plan

@router.delete("/{plan_id}", response_model=SubscriptionPlan)
def delete_subscription_plan(plan_id: int, db: Session = Depends(get_db)):
    db_plan = db.query(SubscriptionPlanModel).filter(SubscriptionPlanModel.id == plan_id).first()
    if db_plan is None:
        raise HTTPException(status_code=404, detail="Subscription plan not found")
    
    db.delete(db_plan)
    db.commit()
    return db_plan