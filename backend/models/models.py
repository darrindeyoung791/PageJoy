from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, ForeignKey, Date, DECIMAL, Enum
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from database import Base
from enum import Enum as PyEnum

# Define Enums
class ArticleStatus(str, PyEnum):
    DRAFT = "draft"
    PUBLISHED = "published"
    ARCHIVED = "archived"

class PaymentStatus(str, PyEnum):
    SUCCESS = "success"
    FAILED = "failed"
    PENDING = "pending"

class SubscriptionStatus(str, PyEnum):
    ACTIVE = "active"
    EXPIRED = "expired"
    CANCELED = "canceled"

class ContentAccessType(str, PyEnum):
    FREE = "free"
    SUBSCRIPTION = "subscription"
    PURCHASE = "purchase"

class ContentType(str, PyEnum):
    MAGAZINE = "magazine"
    ARTICLE = "article"
    AUTHOR = "author"

# User Model
class User(Base):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), nullable=False, unique=True)
    password_hash = Column(String(255), nullable=False)
    email = Column(String(100), nullable=True)
    phone = Column(String(20), nullable=True)
    wechat_id = Column(String(50), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    roles = relationship("UserRole", back_populates="user")
    articles_written = relationship("ArticleWriter", back_populates="user")
    magazines_published = relationship("MagazinePublisher", back_populates="user")
    following = relationship("UserFollow", foreign_keys="[UserFollow.follower_id]", back_populates="follower")
    followers = relationship("UserFollow", foreign_keys="[UserFollow.followed_id]", back_populates="followed")
    likes = relationship("Like", back_populates="user")
    favorites = relationship("Favorite", back_populates="user")
    subscriptions = relationship("UserSubscription", back_populates="user")
    payments = relationship("Payment", back_populates="user")

# Role Model
class Role(Base):
    __tablename__ = "role"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(20), nullable=False)

    # Relationships
    users = relationship("UserRole", back_populates="role")

# UserRole Model
class UserRole(Base):
    __tablename__ = "user_role"

    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    role_id = Column(Integer, ForeignKey("role.id"), primary_key=True)

    # Relationships
    user = relationship("User", back_populates="roles")
    role = relationship("Role", back_populates="users")

# Article Model
class Article(Base):
    __tablename__ = "article"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    content = Column(Text, nullable=False)
    ai_summary = Column(Text, nullable=True)  # AI摘要字段
    status = Column(Enum(ArticleStatus), default=ArticleStatus.DRAFT, nullable=False)
    is_premium = Column(Boolean, default=False, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)
    view_count = Column(Integer, default=0, nullable=False)

    # Relationships
    writers = relationship("ArticleWriter", back_populates="article")
    magazines = relationship("MagazineArticle", back_populates="article")
    likes = relationship("Like", back_populates="article")
    favorites = relationship("Favorite", back_populates="article")

# Magazine Model
class Magazine(Base):
    __tablename__ = "magazine"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(Text, nullable=True)
    cover_image = Column(String(255), nullable=True)
    is_premium = Column(Boolean, default=False, nullable=False)
    subscription_plan_id = Column(Integer, ForeignKey("subscription_plan.id"), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    publishers = relationship("MagazinePublisher", back_populates="magazine")
    articles = relationship("MagazineArticle", back_populates="magazine")
    subscription_plan = relationship("SubscriptionPlan", back_populates="magazines")
    likes = relationship("Like", back_populates="magazine")
    favorites = relationship("Favorite", back_populates="magazine")

# ArticleWriter Model
class ArticleWriter(Base):
    __tablename__ = "article_writer"

    article_id = Column(Integer, ForeignKey("article.id"), primary_key=True)
    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    is_primary = Column(Boolean, default=False, nullable=False)

    # Relationships
    article = relationship("Article", back_populates="writers")
    user = relationship("User", back_populates="articles_written")

# MagazinePublisher Model
class MagazinePublisher(Base):
    __tablename__ = "magazine_publisher"

    magazine_id = Column(Integer, ForeignKey("magazine.id"), primary_key=True)
    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)

    # Relationships
    magazine = relationship("Magazine", back_populates="publishers")
    user = relationship("User", back_populates="magazines_published")

# MagazineArticle Model
class MagazineArticle(Base):
    __tablename__ = "magazine_article"

    magazine_id = Column(Integer, ForeignKey("magazine.id"), primary_key=True)
    article_id = Column(Integer, ForeignKey("article.id"), primary_key=True)
    order_in_magazine = Column(Integer, nullable=False)

    # Relationships
    magazine = relationship("Magazine", back_populates="articles")
    article = relationship("Article", back_populates="magazines")

# UserFollow Model
class UserFollow(Base):
    __tablename__ = "user_follow"

    follower_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    followed_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)

    # Relationships
    follower = relationship("User", foreign_keys=[follower_id], back_populates="following")
    followed = relationship("User", foreign_keys=[followed_id], back_populates="followers")

# Favorite Model
class Favorite(Base):
    __tablename__ = "favorites"

    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    article_id = Column(Integer, ForeignKey("article.id"), nullable=True)
    magazine_id = Column(Integer, ForeignKey("magazine.id"), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="favorites")
    article = relationship("Article", back_populates="favorites")
    magazine = relationship("Magazine", back_populates="favorites")

# Like Model
class Like(Base):
    __tablename__ = "likes"

    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    article_id = Column(Integer, ForeignKey("article.id"), nullable=True)
    magazine_id = Column(Integer, ForeignKey("magazine.id"), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="likes")
    article = relationship("Article", back_populates="likes")
    magazine = relationship("Magazine", back_populates="likes")

# SubscriptionPlan Model
class SubscriptionPlan(Base):
    __tablename__ = "subscription_plan"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(Text, nullable=True)
    price = Column(DECIMAL(10, 2), nullable=False)
    duration = Column(Integer, nullable=False)  # in days
    is_recurring = Column(Boolean, default=False, nullable=False)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    magazines = relationship("Magazine", back_populates="subscription_plan")
    subscriptions = relationship("UserSubscription", back_populates="plan")

# Payment Model
class Payment(Base):
    __tablename__ = "payment"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    amount = Column(DECIMAL(10, 2), nullable=False)
    payment_method = Column(String(50), nullable=False)
    transaction_id = Column(String(100), nullable=True)
    status = Column(Enum(PaymentStatus), nullable=False)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="payments")
    subscription = relationship("UserSubscription", back_populates="payment", uselist=False)

# UserSubscription Model
class UserSubscription(Base):
    __tablename__ = "user_subscription"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    plan_id = Column(Integer, ForeignKey("subscription_plan.id"), nullable=False)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    status = Column(Enum(SubscriptionStatus), nullable=False)
    payment_id = Column(Integer, ForeignKey("payment.id"), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    user = relationship("User", back_populates="subscriptions")
    plan = relationship("SubscriptionPlan", back_populates="subscriptions")
    payment = relationship("Payment", back_populates="subscription")

# ContentAccessRule Model
class ContentAccessRule(Base):
    __tablename__ = "content_access_rule"

    id = Column(Integer, primary_key=True, index=True)
    content_type = Column(Enum(ContentType), nullable=False)
    content_id = Column(Integer, nullable=False)
    access_type = Column(Enum(ContentAccessType), nullable=False)
    price = Column(DECIMAL(10, 2), nullable=True)
    subscription_plan_id = Column(Integer, ForeignKey("subscription_plan.id"), nullable=True)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now(), nullable=False)

    # Relationships
    subscription_plan = relationship("SubscriptionPlan")