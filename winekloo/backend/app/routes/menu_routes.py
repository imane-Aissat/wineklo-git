from flask import Blueprint, request, jsonify
from app.repositories.menurepo import MenuRepository
from app.models.menu import Menu

menu_bp = Blueprint('menu_bp', __name__)

@menu_bp.route('/menu', methods=['GET'])
def get_all_menus():
    menus = MenuRepository.get_all_menus()
    return jsonify([menu.to_json() for menu in menus]), 200

@menu_bp.route('/menu/<int:menu_id>', methods=['GET'])
def get_menu_by_id(menu_id):
    menu = MenuRepository.get_menu_by_id(menu_id)
    if menu:
        return jsonify(menu.to_json()), 200
    else:
        return jsonify({"error": "Menu not found"}), 404

@menu_bp.route('/menu/create', methods=['POST'])
def create_menu():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    menu = MenuRepository.create_menu(data)
    return jsonify(menu.to_json()), 201

@menu_bp.route('/menu/update/<int:menu_id>', methods=['PUT'])
def update_menu(menu_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    menu = MenuRepository.update_menu(menu_id, data)
    if menu:
        return jsonify(menu.to_json()), 200
    else:
        return jsonify({"error": "Menu not found"}), 404

@menu_bp.route('/menu/delete/<int:menu_id>', methods=['DELETE'])
def delete_menu(menu_id):
    success = MenuRepository.delete_menu(menu_id)
    if success:
        return jsonify({"message": "Menu deleted successfully"}), 200
    else:
        return jsonify({"error": "Menu not found"}), 404

@menu_bp.route('/menu/restaurant/<int:restaurant_id>', methods=['GET'])
def get_menus_by_restaurant(restaurant_id):
    try:
        menus = MenuRepository.get_menu_by_restaurateur(restaurant_id)
        return jsonify([menu.to_json() for menu in menus]), 200 
    except Exception as e:
        return jsonify({"error": str(e)}), 500
