from flask import Blueprint, request, jsonify, session
from datetime import date
from app.repositories.foodie_repo import FoodieRepository
from werkzeug.security import generate_password_hash, check_password_hash
from app.repositories.favorites_repo import add_to_favorites
import jwt
import datetime
SECRET_KEY = "key"

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
        session.pop('Foodie_id', None)

        return jsonify({"message": "Profile deleted successfully"}), 200
    except Exception as e:
        print(f"Error: {e}")  
        return jsonify({"error": "Internal server error"}), 500


@foodie_bp.route('/foodie/login', methods=['POST', 'OPTIONS'])
def login_foodie():
    if request.method == 'OPTIONS':
        return '', 200  

    try:
        login_data = request.get_json()
        email = login_data.get("email")
        password = login_data.get("password")

        if not email or not password:
            return jsonify({"error": "Email and password are required"}), 400

        foodie = FoodieRepository.get_foodie_by_email(email)

        if not foodie or foodie.Password != password:
            return jsonify({"error": "Invalid email or password"}), 401

        if foodie:
            token = jwt.encode(
                    {"Foodie_id": foodie.FoodieID, "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=2)},
                    SECRET_KEY,
                    algorithm="HS256"
            )
            return jsonify({"token": token, "foodie": foodie.to_json()}), 200

        return jsonify({"error": "Invalid credentials"}), 401


    
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"error": "Internal server error"}), 500


@foodie_bp.route('/foodie/logged', methods=['GET'])
def get_logged_in_foodie():

    auth_header = request.headers.get("Authorization")
    if not auth_header:
            return jsonify({"error": "Unauthorized"}), 401
    
    token = auth_header.split(" ")[1]
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        foodie = FoodieRepository.get_foodie_by_id(decoded["Foodie_id"])
        return jsonify(foodie.to_json()), 200
    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 40


@foodie_bp.route('/foodie/signup', methods=['POST'])
def signup_foodie():
    try:
        foodie_data = request.get_json()
        print(f"Foodie Data: {foodie_data}")

        full_name = foodie_data.get("full_name")
        email = foodie_data.get("email")
        phone = foodie_data.get("phone")
        password = foodie_data.get("password")
        gender = foodie_data.get("gender")
        wilaya = foodie_data.get("wilaya")
        categories = foodie_data.get("categories")
        dietary_options = foodie_data.get("dietaryOptions")
        pricing = foodie_data.get("pricing")

        if FoodieRepository.get_foodie_by_email(email):
            return jsonify({"error": "Foodie with this email already exists"}), 400

        hashed_password = generate_password_hash(password)
        
        foodie_data = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "password": hashed_password,
        "gender": gender,
        "wilaya": wilaya,
        "categories": categories,
        "dietary_options": dietary_options,
        "pricing": pricing
        }

        foodie = FoodieRepository.add_foodie(foodie_data)

        session['Foodie_id'] = foodie.FoodieID

        return jsonify({"message": "Foodie created successfully", "foodie": foodie.to_json()}), 201

    except Exception as e:
        print(f"Error during signup: {e}")
        return jsonify({"error": f"Internal server error: {e}"}), 500



@foodie_bp.route('/foodie/check/<string:email>', methods=['GET'])
def check_foodie_by_email(email):
    foodie = FoodieRepository.get_foodie_by_email(email)
    if foodie:
        return jsonify({"message": "Foodie exists"}), 200
    else:
        return jsonify({"message": "Foodie does not exist"}), 404
    

@foodie_bp.route("/favorites/<int:restau_id>", methods=["POST"])
def add_to_favorites_route(restau_id):
    auth_header = request.headers.get("Authorization")
    if not auth_header:
        return jsonify({"error": "Unauthorized"}), 401

    token = auth_header.split(" ")[1]
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        foodie_id = decoded["Foodie_id"]

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

    add_to_favorites(foodie_id, restau_id)
    
    return jsonify({"message": "Successfully added to favorites!"}), 201
