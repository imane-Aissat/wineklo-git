from app.db import db
from app.models.dietarypreferences import DietaryPreferences

class DietaryPreferencesRepository:
    @staticmethod
    def get_all_preferences():
        return DietaryPreferences.query.all()

    @staticmethod
    def get_preference_by_id(preference_id):
        return DietaryPreferences.query.get(preference_id)

    @staticmethod
    def create_preference(data):
        preference = DietaryPreferences(**data)
        db.session.add(preference)
        db.session.commit()
        return preference

    @staticmethod
    def update_preference(preference_id, data):
        preference = DietaryPreferences.query.get(preference_id)
        if not preference:
            return None
        for key, value in data.items():
            setattr(preference, key, value)
        db.session.commit()
        return preference

    @staticmethod
    def delete_preference(preference_id):
        preference = DietaryPreferences.query.get(preference_id)
        if not preference:
            return False
        db.session.delete(preference)
        db.session.commit()
        return True