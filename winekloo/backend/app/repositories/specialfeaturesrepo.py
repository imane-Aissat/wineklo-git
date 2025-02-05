from app.db import db
from app.models.specialfeatures import SpecialFeatures

class SpecialFeaturesRepository:
    @staticmethod
    def get_all_features():
        return SpecialFeatures.query.all()

    @staticmethod
    def get_feature_by_id(feature_id):
        return SpecialFeatures.query.get(feature_id)

    @staticmethod
    def create_feature(data):
        feature = SpecialFeatures(**data)
        db.session.add(feature)
        db.session.commit()
        return feature

    @staticmethod
    def update_feature(feature_id, data):
        feature = SpecialFeatures.query.get(feature_id)
        if not feature:
            return None
        for key, value in data.items():
            setattr(feature, key, value)
        db.session.commit()
        return feature

    @staticmethod
    def delete_feature(feature_id):
        feature = SpecialFeatures.query.get(feature_id)
        if not feature:
            return False
        db.session.delete(feature)
        db.session.commit()
        return True