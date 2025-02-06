from app.db import db

class SpecialFeatures(db.Model):
    __tablename__ = 'specialfeatures'

    FeatureID = db.Column(db.BigInteger, primary_key=True, name="FeatureID")
    Feature = db.Column(db.Text, nullable=False, name="Feature")

    def __repr__(self):
        return f"<SpecialFeatures {self.Feature}>"

    def to_json(self):
        return {
            "FeatureID": self.FeatureID,
            "Feature": self.Feature
        }