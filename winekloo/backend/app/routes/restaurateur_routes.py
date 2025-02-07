from flask import Blueprint, request, jsonify
from app.repositories.restaurateurrepo import RestaurateurRepository
from app.repositories.favorites_repo import get_favorite_restaurateurs

restaurateur_bp = Blueprint('restaurateur_bp', __name__)

@restaurateur_bp.route('/restaurateur/<int:id>', methods=['GET'])
def get_restaurateur_by_id(id):
    restaurateur = RestaurateurRepository.get_restaurateur_by_id(id)
    if restaurateur:
        return jsonify(restaurateur.to_json()), 200
    else:
        return jsonify({"error": "Restaurateur not found"}), 404
    

@restaurateur_bp.route('/all/restaurateurs/', methods = ['GET'])
def get_all_restaurateurs():
    restaurateurs = RestaurateurRepository.get_all_restaurateurs()
    for restaurateur in restaurateurs:
        print(restaurateur.to_json())
    return jsonify([restaurateur.to_json() for restaurateur in restaurateurs]), 200

@restaurateur_bp.route('/all/restaurateurs/favorites/<int:id>', methods = ['GET'])
def get_all_fav_restau(id):
    favoriteRestaurateurs = get_favorite_restaurateurs(id)
    for restaurateur in favoriteRestaurateurs:
        print(restaurateur.to_json())
    return jsonify([restaurateur.to_json() for restaurateur in favoriteRestaurateurs]), 200

               
