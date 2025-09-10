from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import Article as ArticleModel
from schemas.schemas import ArticleCreate, Article, ArticleUpdate

router = APIRouter(prefix="/articles", tags=["articles"])

@router.post("/", response_model=Article)
def create_article(article: ArticleCreate, db: Session = Depends(get_db)):
    db_article = ArticleModel(**article.dict())
    db.add(db_article)
    db.commit()
    db.refresh(db_article)
    return db_article

@router.get("/{article_id}", response_model=Article)
def read_article(article_id: int, db: Session = Depends(get_db)):
    db_article = db.query(ArticleModel).filter(ArticleModel.id == article_id).first()
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    return db_article

@router.get("/", response_model=List[Article])
def read_articles(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    articles = db.query(ArticleModel).offset(skip).limit(limit).all()
    return articles

@router.put("/{article_id}", response_model=Article)
def update_article(article_id: int, article: ArticleUpdate, db: Session = Depends(get_db)):
    db_article = db.query(ArticleModel).filter(ArticleModel.id == article_id).first()
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    
    for key, value in article.dict(exclude_unset=True).items():
        setattr(db_article, key, value)
    
    db.commit()
    db.refresh(db_article)
    return db_article

@router.delete("/{article_id}", response_model=Article)
def delete_article(article_id: int, db: Session = Depends(get_db)):
    db_article = db.query(ArticleModel).filter(ArticleModel.id == article_id).first()
    if db_article is None:
        raise HTTPException(status_code=404, detail="Article not found")
    
    db.delete(db_article)
    db.commit()
    return db_article