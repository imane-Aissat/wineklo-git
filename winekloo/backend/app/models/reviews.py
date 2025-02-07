from app.db import db
from datetime import date

class Reviews(db.Model):
    __tablename__ = 'reviews'

    ReviewID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="ReviewID")
    RestaurateurID = db.Column(db.BigInteger, db.ForeignKey('restaurateur.RestaurateurID', onupdate="CASCADE", ondelete="CASCADE"), nullable=False, name="RestaurateurID")
    FoodieID = db.Column(db.BigInteger, db.ForeignKey('foodie."FoodieID"', onupdate="CASCADE", ondelete="CASCADE"), nullable=False, name="FoodieID")
    Comment = db.Column(db.Text, nullable=True, name="Comment")
    Rating = db.Column(db.BigInteger, nullable=True, name="Rating")
    Date = db.Column(db.Date, nullable=True, name="Date")

    def __repr__(self):
        return f"<Reviews {self.ReviewID}>"