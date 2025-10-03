from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import Favorite as FavoriteModel, Article as ArticleModel, Magazine as MagazineModel
from schemas.schemas import FavoriteCreate, Favorite, Article

router = APIRouter(prefix="/favorites", tags=["favorites"])

@router.post("/", response_model=Favorite)
def create_favorite(favorite: FavoriteCreate, db: Session = Depends(get_db)):
    # Check if the favorite already exists
    existing_favorite = db.query(FavoriteModel).filter(
        FavoriteModel.user_id == favorite.user_id,
        FavoriteModel.article_id == favorite.article_id if favorite.article_id else None,
        FavoriteModel.magazine_id == favorite.magazine_id if favorite.magazine_id else None
    ).first()
    
    if existing_favorite:
        raise HTTPException(status_code=400, detail="Favorite already exists")
    
    db_favorite = FavoriteModel(**favorite.dict())
    db.add(db_favorite)
    db.commit()
    db.refresh(db_favorite)
    return db_favorite

@router.get("/{user_id}/{content_type}/{content_id}", response_model=Favorite)
def read_favorite(user_id: int, content_type: str, content_id: int, db: Session = Depends(get_db)):
    if content_type == "article":
        db_favorite = db.query(FavoriteModel).filter(
            FavoriteModel.user_id == user_id,
            FavoriteModel.article_id == content_id
        ).first()
    elif content_type == "magazine":
        db_favorite = db.query(FavoriteModel).filter(
            FavoriteModel.user_id == user_id,
            FavoriteModel.magazine_id == content_id
        ).first()
    else:
        raise HTTPException(status_code=400, detail="Invalid content type")
    
    if db_favorite is None:
        raise HTTPException(status_code=404, detail="Favorite not found")
    return db_favorite

@router.get("/user/{user_id}", response_model=List[Favorite])
def read_user_favorites(user_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    favorites = db.query(FavoriteModel).filter(FavoriteModel.user_id == user_id).offset(skip).limit(limit).all()
    return favorites

@router.delete("/{user_id}/{content_type}/{content_id}")
def delete_favorite(user_id: int, content_type: str, content_id: int, db: Session = Depends(get_db)):
    if content_type == "article":
        db_favorite = db.query(FavoriteModel).filter(
            FavoriteModel.user_id == user_id,
            FavoriteModel.article_id == content_id
        ).first()
    elif content_type == "magazine":
        db_favorite = db.query(FavoriteModel).filter(
            FavoriteModel.user_id == user_id,
            FavoriteModel.magazine_id == content_id
        ).first()
    else:
        raise HTTPException(status_code=400, detail="Invalid content type")
    
    if db_favorite is None:
        raise HTTPException(status_code=404, detail="Favorite not found")
    
    db.delete(db_favorite)
    db.commit()
    return {"message": "Favorite deleted successfully"}

from schemas.schemas import Article

@router.get("/user/{user_id}/articles", response_model=List[Article])
def read_user_favorite_articles(user_id: int, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """获取用户收藏的所有文章"""
    favorite_articles = db.query(ArticleModel)\
        .join(FavoriteModel)\
        .filter(
            FavoriteModel.user_id == user_id,
            FavoriteModel.article_id.isnot(None)
        ).offset(skip).limit(limit).all()
    
    # 将SQLAlchemy模型转换为Pydantic模型
    return [Article.from_orm(article) if hasattr(Article, 'from_orm') else Article(**article.__dict__) for article in favorite_articles]