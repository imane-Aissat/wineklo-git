from app.db import db
from app.models.categories import Categories

class CategoriesRepository:
    @staticmethod
    def get_all_categories():
        return Categories.query.all()

    @staticmethod
    def get_category_by_id(category_id):
        return Categories.query.get(category_id)

    @staticmethod
    def create_category(data):
        category = Categories(**data)
        db.session.add(category)
        db.session.commit()
        return category

    @staticmethod
    def update_category(category_id, data):
        category = Categories.query.get(category_id)
        if not category:
            return None
        for key, value in data.items():
            setattr(category, key, value)
        db.session.commit()
        return category

    @staticmethod
    def delete_category(category_id):
        category = Categories.query.get(category_id)
        if not category:
            return False
        db.session.delete(category)
        db.session.commit()
        return True