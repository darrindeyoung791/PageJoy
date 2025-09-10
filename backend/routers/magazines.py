from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.models import Magazine as MagazineModel
from schemas.schemas import MagazineCreate, Magazine, MagazineUpdate

router = APIRouter(prefix="/magazines", tags=["magazines"])

@router.post("/", response_model=Magazine)
def create_magazine(magazine: MagazineCreate, db: Session = Depends(get_db)):
    db_magazine = MagazineModel(**magazine.dict())
    db.add(db_magazine)
    db.commit()
    db.refresh(db_magazine)
    return db_magazine

@router.get("/{magazine_id}", response_model=Magazine)
def read_magazine(magazine_id: int, db: Session = Depends(get_db)):
    db_magazine = db.query(MagazineModel).filter(MagazineModel.id == magazine_id).first()
    if db_magazine is None:
        raise HTTPException(status_code=404, detail="Magazine not found")
    return db_magazine

@router.get("/", response_model=List[Magazine])
def read_magazines(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    magazines = db.query(MagazineModel).offset(skip).limit(limit).all()
    return magazines

@router.put("/{magazine_id}", response_model=Magazine)
def update_magazine(magazine_id: int, magazine: MagazineUpdate, db: Session = Depends(get_db)):
    db_magazine = db.query(MagazineModel).filter(MagazineModel.id == magazine_id).first()
    if db_magazine is None:
        raise HTTPException(status_code=404, detail="Magazine not found")
    
    for key, value in magazine.dict(exclude_unset=True).items():
        setattr(db_magazine, key, value)
    
    db.commit()
    db.refresh(db_magazine)
    return db_magazine

@router.delete("/{magazine_id}", response_model=Magazine)
def delete_magazine(magazine_id: int, db: Session = Depends(get_db)):
    db_magazine = db.query(MagazineModel).filter(MagazineModel.id == magazine_id).first()
    if db_magazine is None:
        raise HTTPException(status_code=404, detail="Magazine not found")
    
    db.delete(db_magazine)
    db.commit()
    return db_magazine