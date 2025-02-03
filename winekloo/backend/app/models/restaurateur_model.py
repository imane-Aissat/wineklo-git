from app.db import db

class Restaurateur(db.Model):
    __tablename__ = 'restaurateur'

    restaurateur_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    dining_type = db.Column(db.String(255), nullable=True)
    name = db.Column(db.String(255), nullable=True)
    email = db.Column(db.String(255), unique=True, nullable=False)
    phone_number = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    location = db.Column(db.String(255), nullable=True)
    photo = db.Column(db.String(255), nullable=True)
    working_hours = db.Column(db.JSON, nullable=True)
    working_days = db.Column(db.JSON, nullable=True)
    description = db.Column(db.String(1000), nullable=True)
    rating_value_average = db.Column(db.Float, nullable=True)
    menu_file_pdf = db.Column(db.String(255), nullable=True)
    restaurateur_categories = db.Column(db.Integer, nullable=True)
    restaurateur_preferences = db.Column(db.Integer, nullable=True)
    restaurateur_special_features = db.Column(db.Integer, nullable=True)
    restaurateur_pricing = db.Column(db.Integer, nullable=True)

    def __init__(self, email, phone_number, password, dining_type=None, name=None, location=None, photo=None,
                 working_hours=None, working_days=None, description=None, rating_value_average=None,
                 menu_file_pdf=None, restaurateur_categories=None, restaurateur_preferences=None,
                 restaurateur_special_features=None, restaurateur_pricing=None):
        self.email = email
        self.phone_number = phone_number
        self.password = password
        self.dining_type = dining_type
        self.name = name
        self.location = location
        self.photo = photo
        self.working_hours = working_hours
        self.working_days = working_days
        self.description = description
        self.rating_value_average = rating_value_average
        self.menu_file_pdf = menu_file_pdf
        self.restaurateur_categories = restaurateur_categories
        self.restaurateur_preferences = restaurateur_preferences
        self.restaurateur_special_features = restaurateur_special_features
        self.restaurateur_pricing = restaurateur_pricing

    @staticmethod
    def from_json(json_data):
        return Restaurateur(
            restaurateur_id=json_data.get('RestaurateurID'),
            email=json_data.get('Email'),
            phone_number=json_data.get('PhoneNumber'),
            password=json_data.get('Password'),
            dining_type=json_data.get('DiningType'),
            name=json_data.get('Name'),
            location=json_data.get('Location'),
            photo=json_data.get('Photo'),
            working_hours=json_data.get('WorkingHours'),
            working_days=json_data.get('WorkingDays'),
            description=json_data.get('Description'),
            rating_value_average=json_data.get('RatingValueAverage'),
            menu_file_pdf=json_data.get('MenuFilePDF'),
            restaurateur_categories=json_data.get('Categories'),
            restaurateur_preferences=json_data.get('DietaryPreferences'),
            restaurateur_special_features=json_data.get('SpecialFeatures'),
            restaurateur_pricing=json_data.get('Pricing')
        )

    def to_json(self):
        return {
            'RestaurateurID': self.restaurateur_id,
            'Email': self.email,
            'PhoneNumber': self.phone_number,
            'Password': self.password,
            'DiningType': self.dining_type,
            'Name': self.name,
            'Location': self.location,
            'Photo': self.photo,
            'WorkingHours': self.working_hours,
            'WorkingDays': self.working_days,
            'Description': self.description,
            'RatingValueAverage': self.rating_value_average,
            'MenuFilePDF': self.menu_file_pdf,
            'Categories': self.restaurateur_categories,
            'DietaryPreferences': self.restaurateur_preferences,
            'SpecialFeatures': self.restaurateur_special_features,
            'Pricing': self.restaurateur_pricing
        }
