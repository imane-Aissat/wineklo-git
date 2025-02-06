from flask import Blueprint, request, jsonify, session
from datetime import date
from app.repositories.foodie_repo import FoodieRepository

foodie_bp = Blueprint('foodie_bp', __name__,)

@foodie_bp.route('/foodie/<int:id>', methods=['GET'])
def get_foodie_by_id(id):
    foodie = FoodieRepository.get_foodie_by_id(id)
    if foodie:
        return jsonify(foodie.to_json()), 200
    else:
        return jsonify({"error": "Mentor not found"}), 404
    


@foodie_bp.route('/foodie/updateprofile', methods=['POST'])  
def update_foodie():
    try:
        foodie_data = request.get_json()
        print(foodie_data)
        foodie_id = foodie_data.get("FoodieID") 
        print("wlh the id here:") 
        print("wlh the id here:", foodie_id)
        if not foodie_id:
            return jsonify({"error": "FoodieID is required"}), 400

        foodie_data.pop("FoodieID", None) 

        if "Birthday" in foodie_data and foodie_data["Birthday"]:
            try:
                foodie_data["Birthday"] = date.fromisoformat(foodie_data["Birthday"])
            except ValueError:
                return jsonify({"error": "Invalid birthday format. Use YYYY-MM-DD"}), 400

        FoodieRepository.update_foodie(foodie_id=foodie_id, updates=foodie_data)

        return jsonify({"message": "Profile updated successfully"}), 200

    except Exception as e:
        print(f"Error: {e}")  
        return jsonify({"error": "Internal server error"}), 500
    

@foodie_bp.route('/foodie/delete/<int:id>', methods=['DELETE'])
def delete_foodie(id):
    try:
        FoodieRepository.delete_foodie(id)
        return jsonify({"message": "Profile updated successfully"}), 200
    except Exception as e:
        print(f"Error: {e}")  
        return jsonify({"error": "Internal server error"}), 500

