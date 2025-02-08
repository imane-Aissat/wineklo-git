from app.db import db

class Favorites(db.Model):
    __tablename__ = 'favorites'

    FavoritesID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="FavoritesID")
    FoodieID = db.Column(db.BigInteger, db.ForeignKey('foodie.FoodieID', onupdate="CASCADE", ondelete="CASCADE"), nullable=True, name="FoodieID")
    RestaurateurID = db.Column(db.BigInteger, db.ForeignKey('restaurateur.RestaurateurID', onupdate="CASCADE", ondelete="CASCADE"), nullable=True, name="RestaurateurID")

    def __repr__(self):
        return f"<Favorites {self.FavoritesID}>"

    def to_json(self):
        return {
            "FavoritesID": self.FavoritesID,
            "FoodieID": self.FoodieID,
            "RestaurateurID": self.RestaurateurID
        }
