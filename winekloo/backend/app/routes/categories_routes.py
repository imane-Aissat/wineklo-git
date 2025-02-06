from flask import Blueprint, request, jsonify
from app.repositories.categoriesrepo import CategoriesRepository
from app.models.categories import Categories

categories_bp = Blueprint('categories_bp', __name__)

@categories_bp.route('/categories', methods=['GET'])
def get_all_categories():
    categories = CategoriesRepository.get_all_categories()
    return jsonify([category.to_json() for category in categories]), 200

@categories_bp.route('/categories/<int:category_id>', methods=['GET'])
def get_category_by_id(category_id):
    category = CategoriesRepository.get_category_by_id(category_id)
    if category:
        return jsonify(category.to_json()), 200
    else:
        return jsonify({"error": "Category not found"}), 404

@categories_bp.route('/categories', methods=['POST'])
def create_category():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    category = CategoriesRepository.create_category(data)
    return jsonify(category.to_json()), 201

@categories_bp.route('/categories/<int:category_id>', methods=['PUT'])
def update_category(category_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    category = CategoriesRepository.update_category(category_id, data)
    if category:
        return jsonify(category.to_json()), 200
    else:
        return jsonify({"error": "Category not found"}), 404

@categories_bp.route('/categories/<int:category_id>', methods=['DELETE'])
def delete_category(category_id):
    success = CategoriesRepository.delete_category(category_id)
    if success:
        return jsonify({"message": "Category deleted successfully"}), 200
    else:
        return jsonify({"error": "Category not found"}), 404