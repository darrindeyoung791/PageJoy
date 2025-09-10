from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime, date
from decimal import Decimal

# User schemas
class UserBase(BaseModel):
    username: str
    email: Optional[str] = None
    phone: Optional[str] = None
    wechat_id: Optional[str] = None

class UserCreate(UserBase):
    password: str

class UserUpdate(UserBase):
    pass

class User(UserBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Role schemas
class RoleBase(BaseModel):
    name: str

class RoleCreate(RoleBase):
    pass

class RoleUpdate(RoleBase):
    pass

class Role(RoleBase):
    id: int

    class Config:
        orm_mode = True

# Article schemas
class ArticleStatus(str):
    DRAFT = "draft"
    PUBLISHED = "published"
    ARCHIVED = "archived"

class ArticleBase(BaseModel):
    title: str
    content: str
    ai_summary: Optional[str] = None
    status: ArticleStatus = ArticleStatus.DRAFT
    is_premium: bool = False
    price: Optional[Decimal] = None

class ArticleCreate(ArticleBase):
    pass

class ArticleUpdate(ArticleBase):
    pass

class Article(ArticleBase):
    id: int
    created_at: datetime
    updated_at: datetime
    view_count: int

    class Config:
        orm_mode = True

# Magazine schemas
class MagazineBase(BaseModel):
    name: str
    description: Optional[str] = None
    cover_image: Optional[str] = None
    is_premium: bool = False
    subscription_plan_id: Optional[int] = None

class MagazineCreate(MagazineBase):
    pass

class MagazineUpdate(MagazineBase):
    pass

class Magazine(MagazineBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Subscription Plan schemas
class SubscriptionPlanBase(BaseModel):
    name: str
    description: Optional[str] = None
    price: Decimal
    duration: int  # in days
    is_recurring: bool = False

class SubscriptionPlanCreate(SubscriptionPlanBase):
    pass

class SubscriptionPlanUpdate(SubscriptionPlanBase):
    pass

class SubscriptionPlan(SubscriptionPlanBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# User Subscription schemas
class SubscriptionStatus(str):
    ACTIVE = "active"
    EXPIRED = "expired"
    CANCELED = "canceled"

class UserSubscriptionBase(BaseModel):
    user_id: int
    plan_id: int
    start_date: date
    end_date: date
    status: SubscriptionStatus
    payment_id: Optional[int] = None

class UserSubscriptionCreate(UserSubscriptionBase):
    pass

class UserSubscriptionUpdate(UserSubscriptionBase):
    pass

class UserSubscription(UserSubscriptionBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Payment schemas
class PaymentStatus(str):
    SUCCESS = "success"
    FAILED = "failed"
    PENDING = "pending"

class PaymentBase(BaseModel):
    user_id: int
    amount: Decimal
    payment_method: str
    transaction_id: Optional[str] = None
    status: PaymentStatus

class PaymentCreate(PaymentBase):
    pass

class PaymentUpdate(PaymentBase):
    pass

class Payment(PaymentBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Like schemas
class LikeBase(BaseModel):
    user_id: int
    article_id: Optional[int] = None
    magazine_id: Optional[int] = None

class LikeCreate(LikeBase):
    pass

class LikeUpdate(LikeBase):
    pass

class Like(LikeBase):
    created_at: datetime

    class Config:
        orm_mode = True

# User Follow schemas
class UserFollowBase(BaseModel):
    follower_id: int
    followed_id: int

class UserFollowCreate(UserFollowBase):
    pass

class UserFollowUpdate(UserFollowBase):
    pass

class UserFollow(UserFollowBase):
    created_at: datetime

    class Config:
        orm_mode = True