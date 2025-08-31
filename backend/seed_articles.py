import os
import sys
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from models.models import Base, Article, ArticleStatus
from database import SQLALCHEMY_DATABASE_URL

def seed_articles():
    # Create engine and session with UTF-8 encoding
    engine = create_engine(
        SQLALCHEMY_DATABASE_URL, 
        connect_args={"check_same_thread": False},
        encoding='utf-8'
    )
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    
    # Sample article data
    sample_articles = [
        {
            "title": "人工智能在医疗领域的应用前景",
            "content": "人工智能技术正在医疗领域发挥越来越重要的作用。从疾病诊断到药物研发，AI正在改变医疗行业的方方面面。本文将探讨AI在医疗领域的最新应用和未来发展趋势。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "可持续发展：绿色能源的未来",
            "content": "随着全球气候变化问题日益严重，绿色能源的发展变得尤为重要。太阳能、风能等可再生能源正在成为解决能源危机的关键。本文将分析绿色能源的发展现状和前景。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 9.99
        },
        {
            "title": "区块链技术的创新应用",
            "content": "区块链技术不仅限于加密货币，它在供应链管理、数字身份验证等领域也有着广泛的应用前景。本文将介绍区块链技术的创新应用场景。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "心理健康：现代社会的挑战",
            "content": "在快节奏的现代生活中，心理健康问题日益突出。本文将探讨心理健康的重要性，以及如何在日常生活中维护心理健康。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "未来城市：智慧城市的构想",
            "content": "智慧城市利用物联网、大数据等技术提升城市管理效率和居民生活质量。本文将展望未来城市的发展方向和关键技术。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 12.99
        },
        {
            "title": "生物技术的突破性进展",
            "content": "基因编辑、细胞治疗等生物技术正在为医学带来革命性变化。本文将介绍生物技术领域的最新突破和发展趋势。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "数字艺术的兴起与发展",
            "content": "NFT、数字绘画等数字艺术形式正在改变艺术创作和收藏的方式。本文将探讨数字艺术的发展现状和未来可能。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "太空探索：人类的星辰大海",
            "content": "私人航天公司的崛起使得太空探索进入了一个新时代。本文将回顾人类太空探索的历史，并展望未来的星际旅行。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 14.99
        },
        {
            "title": "教育科技：在线学习的未来",
            "content": "疫情加速了在线教育的发展，虚拟现实、人工智能等技术正在重塑教育体验。本文将分析教育科技的发展趋势。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "气候变化与环境保护",
            "content": "全球气候变化对地球生态系统造成了深远影响。本文将探讨环境保护的重要性和可行的解决方案。",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        }
    ]
    
    # Add articles to database
    for article_data in sample_articles:
        article = Article(**article_data)
        db.add(article)
    
    # Commit changes
    db.commit()
    db.close()
    print(f"Successfully added {len(sample_articles)} sample articles to the database.")

if __name__ == "__main__":
    seed_articles()