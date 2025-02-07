from app.db import db
from app.models.restaurateur import Restaurateur
from app.models.favorites_model import Favorites

@staticmethod
def get_favorite_restaurateurs(foodie_id):
    return (
        Restaurateur.query
        .join(Favorites, Favorites.RestaurateurID == Restaurateur.RestaurateurID)
        .filter(Favorites.FoodieID == foodie_id)
        .all()
    )
