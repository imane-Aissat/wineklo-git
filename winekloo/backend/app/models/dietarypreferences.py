from app.db import db

class DietaryPreferences(db.Model):
    __tablename__ = 'dietarypreferences'

    PreferenceID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="PreferenceID")
    Preference = db.Column(db.Text, nullable=True, name="Preference")

    def __repr__(self):
        return f"<DietaryPreferences {self.Preference}>"