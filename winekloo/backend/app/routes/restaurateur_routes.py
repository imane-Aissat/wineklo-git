from flask import Blueprint, request, jsonify, session
from app.repositories.restaurateurrepo import RestaurateurRepository
from app.models.restaurateur import Restaurateur
from app.repositories.favorites_repo import get_favorite_restaurateurs
import jwt
import datetime
SECRET_KEY = "key"
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

@restaurateur_bp.route('/restaurateur/login', methods=['POST', 'OPTIONS'])
def login_restaurateur():
    if request.method == 'OPTIONS':
        return '', 200

    try:
        login_data = request.get_json()
        email = login_data.get("email")
        password = login_data.get("password")

        if not email or not password:
            return jsonify({"error": "Email and password are required"}), 400

        restaurateur = RestaurateurRepository.get_restaurateur_by_email(email)

        if not restaurateur or restaurateur.Password != password:
            return jsonify({"error": "Invalid email or password"}), 401

        token = jwt.encode(
            {"Restaurateur_id": restaurateur.RestaurateurID, "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=2)},
            SECRET_KEY,
            algorithm="HS256"
        )
        return jsonify({"token": token, "restaurateur": restaurateur.to_json()}), 200

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"error": "Internal server error"}), 500

@restaurateur_bp.route('/restaurateur/logged', methods=['GET'])
def get_logged_in_restaurateur():
    auth_header = request.headers.get("Authorization")
    if not auth_header:
        return jsonify({"error": "Unauthorized"}), 401

    token = auth_header.split(" ")[1]
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        restaurateur = RestaurateurRepository.get_restaurateur_by_id(decoded["Restaurateur_id"])
        return jsonify(restaurateur.to_json()), 200
    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 4011
    


@restaurateur_bp.route('/load/favorites/profile', methods = ['GET'])
def get_all_fav_restau_profile():
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
    favoriteRestaurateurs = get_favorite_restaurateurs(foodie_id)
    for restaurateur in favoriteRestaurateurs:
        print(restaurateur.to_json())
    return jsonify([restaurateur.to_json() for restaurateur in favoriteRestaurateurs]), 200