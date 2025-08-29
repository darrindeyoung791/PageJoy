from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import Like
from schemas.schemas import LikeCreate, Like, LikeUpdate

router = APIRouter(prefix="/likes", tags=["likes"])

@router.post("/", response_model=Like)
def create_like(like: LikeCreate, db: Session = Depends(get_db)):
    # Check if the like already exists
    existing_like = db.query(Like).filter(
        Like.user_id == like.user_id,
        Like.article_id == like.article_id if like.article_id else None,
        Like.magazine_id == like.magazine_id if like.magazine_id else None
    ).first()
    
    if existing_like:
        raise HTTPException(status_code=400, detail="Like already exists")
    
    db_like = Like(**like.dict())
    db.add(db_like)
    db.commit()
    db.refresh(db_like)
    return db_like

@router.get("/{user_id}/{content_type}/{content_id}", response_model=Like)
def read_like(user_id: int, content_type: str, content_id: int, db: Session = Depends(get_db)):
    if content_type == "article":
        db_like = db.query(Like).filter(
            Like.user_id == user_id,
            Like.article_id == content_id
        ).first()
    elif content_type == "magazine":
        db_like = db.query(Like).filter(
            Like.user_id == user_id,
            Like.magazine_id == content_id
        ).first()
    else:
        raise HTTPException(status_code=400, detail="Invalid content type")
    
    if db_like is None:
        raise HTTPException(status_code=404, detail="Like not found")
    return db_like

@router.get("/user/{user_id}", response_model=List[Like])
def read_user_likes(user_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    likes = db.query(Like).filter(Like.user_id == user_id).offset(skip).limit(limit).all()
    return likes

@router.delete("/{user_id}/{content_type}/{content_id}")
def delete_like(user_id: int, content_type: str, content_id: int, db: Session = Depends(get_db)):
    if content_type == "article":
        db_like = db.query(Like).filter(
            Like.user_id == user_id,
            Like.article_id == content_id
        ).first()
    elif content_type == "magazine":
        db_like = db.query(Like).filter(
            Like.user_id == user_id,
            Like.magazine_id == content_id
        ).first()
    else:
        raise HTTPException(status_code=400, detail="Invalid content type")
    
    if db_like is None:
        raise HTTPException(status_code=404, detail="Like not found")
    
    db.delete(db_like)
    db.commit()
    return {"message": "Like deleted successfully"}