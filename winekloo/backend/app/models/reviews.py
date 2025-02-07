from app.db import db
from datetime import date
from app.models.foodie_model import Foodie

class Reviews(db.Model):
    __tablename__ = 'reviews'

    ReviewID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="ReviewID")
    RestaurateurID = db.Column(db.BigInteger, db.ForeignKey('restaurateur.RestaurateurID', onupdate="CASCADE", ondelete="CASCADE"), nullable=False, name="RestaurateurID")
    FoodieID = db.Column(db.BigInteger, db.ForeignKey('foodie.FoodieID', onupdate="CASCADE", ondelete="CASCADE"), nullable=False, name="FoodieID")
    Comment = db.Column(db.Text, nullable=True, name="Comment")
    Rating = db.Column(db.BigInteger, nullable=True, name="Rating")
    Date = db.Column(db.Date, nullable=True, name="Date")

    def __repr__(self):
        return f"<Reviews {self.ReviewID}>"

    
    def to_json(self, foodie_name=None):
        return {
            "ReviewID": self.ReviewID,
            "RestaurateurID": self.RestaurateurID,
            "FoodieID": self.FoodieID,
            "full_name": foodie_name,  
            "Comment": self.Comment,
            "Rating": self.Rating,
            "Date": self.Date.isoformat() if self.Date else None
        }


    @classmethod
    def from_json(cls, data):
        return cls(
            RestaurateurID=data.get("RestaurateurID"),
            FoodieID=data.get("FoodieID"),
            Comment=data.get("Comment"),
            Rating=data.get("Rating"),
            Date=date.fromisoformat(data["Date"]) if data.get("Date") else None
        )
