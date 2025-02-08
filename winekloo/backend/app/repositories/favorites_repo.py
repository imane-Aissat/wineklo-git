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
@staticmethod
def add_to_favorites(foodie_id, restau_id):
    existing_favorite = Favorites.query.filter_by(FoodieID=foodie_id, RestaurateurID=restau_id).first()
    if not existing_favorite:
        new_favorite = Favorites(FoodieID=foodie_id, RestaurateurID=restau_id)
        db.session.add(new_favorite)
        db.session.commit()
        return {"message": "Successfully added to favorites!"}, 201 
    else:
        return {"message": "Already in favorites!"}, 409
