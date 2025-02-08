from app.db import db
from datetime import datetime

class Review(db.Model):
    __tablename__ = 'reviews'

    review_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    restaurateur_id = db.Column(db.Integer, nullable=False)
    foodie_id = db.Column(db.Integer, nullable=False)
    comment = db.Column(db.String(1000), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.timezone.utc)
    
    def __init__(self, restaurateur_id, foodie_id, comment=None, created_at=None):
        self.restaurateur_id = restaurateur_id
        self.foodie_id = foodie_id
        self.comment = comment
        self.created_at = created_at or datetime.timezone.utc()

    @staticmethod
    def from_json(json_data):
        return Review(
            review_id=json_data.get('ReviewID'),
            restaurateur_id=json_data.get('RestaurateurID'),
            foodie_id=json_data.get('FoodieID'),
            comment=json_data.get('Comment'),
            created_at=datetime.strptime(json_data['CreatedAt'], '%Y-%m-%dT%H:%M:%S') if json_data.get('CreatedAt') else None
        )

    def to_json(self):
        return {
            'ReviewID': self.review_id,
            'RestaurateurID': self.restaurateur_id,
            'FoodieID': self.foodie_id,
            'Comment': self.comment,
            'CreatedAt': self.created_at.isoformat() if self.created_at else None
        }
