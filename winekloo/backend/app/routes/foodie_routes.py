from flask import Blueprint, request, jsonify, session
from app.repositories.foodie_repo import FoodieRepository
foodie_bp = Blueprint('foodie_bp', __name__,)

@foodie_bp.route('/foodie/<int:id>', methods=['GET'])
def get_foodie_by_id(id):
    foodie = FoodieRepository.get_foodie_by_id(id)
    if foodie:
        return jsonify(foodie.to_json()), 200
    else:
        return jsonify({"error": "Mentor not found"}), 404