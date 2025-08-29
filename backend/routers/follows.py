from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import UserFollow
from schemas.schemas import UserFollowCreate, UserFollow, UserFollowUpdate

router = APIRouter(prefix="/follows", tags=["follows"])

@router.post("/", response_model=UserFollow)
def create_follow(follow: UserFollowCreate, db: Session = Depends(get_db)):
    # Check if the follow relationship already exists
    existing_follow = db.query(UserFollow).filter(
        UserFollow.follower_id == follow.follower_id,
        UserFollow.followed_id == follow.followed_id
    ).first()
    
    if existing_follow:
        raise HTTPException(status_code=400, detail="Follow relationship already exists")
    
    db_follow = UserFollow(**follow.dict())
    db.add(db_follow)
    db.commit()
    db.refresh(db_follow)
    return db_follow

@router.get("/{follower_id}/{followed_id}", response_model=UserFollow)
def read_follow(follower_id: int, followed_id: int, db: Session = Depends(get_db)):
    db_follow = db.query(UserFollow).filter(
        UserFollow.follower_id == follower_id,
        UserFollow.followed_id == followed_id
    ).first()
    
    if db_follow is None:
        raise HTTPException(status_code=404, detail="Follow relationship not found")
    return db_follow

@router.get("/followers/{user_id}", response_model=List[UserFollow])
def read_followers(user_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    followers = db.query(UserFollow).filter(UserFollow.followed_id == user_id).offset(skip).limit(limit).all()
    return followers

@router.get("/following/{user_id}", response_model=List[UserFollow])
def read_following(user_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    following = db.query(UserFollow).filter(UserFollow.follower_id == user_id).offset(skip).limit(limit).all()
    return following

@router.delete("/{follower_id}/{followed_id}")
def delete_follow(follower_id: int, followed_id: int, db: Session = Depends(get_db)):
    db_follow = db.query(UserFollow).filter(
        UserFollow.follower_id == follower_id,
        UserFollow.followed_id == followed_id
    ).first()
    
    if db_follow is None:
        raise HTTPException(status_code=404, detail="Follow relationship not found")
    
    db.delete(db_follow)
    db.commit()
    return {"message": "Follow relationship deleted successfully"}