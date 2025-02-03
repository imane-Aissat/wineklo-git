from app.db import db

class Restaurateur(db.Model):
    __tablename__ = 'restaurateur'

    restaurateur_id = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="RestaurateurID")
    dining_type = db.Column(db.Text, nullable=True, name="DiningType")
    name = db.Column(db.Text, nullable=True, name="Name")
    email = db.Column(db.Text, nullable=False, name="Email")
    phone_number = db.Column(db.Text, nullable=False, name="PhoneNumber")
    password = db.Column(db.Text, nullable=False, name="Password")
    location = db.Column(db.Text, nullable=True, name="Location")
    photo = db.Column(db.Text, nullable=True, name="Photo")
    working_hours = db.Column(db.JSON, nullable=True, name="WorkingHours")
    working_days = db.Column(db.ARRAY(db.Text), nullable=True, name="WorkingDays")
    description = db.Column(db.Text, nullable=True, name="Description")
    rating_value_average = db.Column(db.Text, nullable=True, name="RatingValueAverage")
    menu_file_pdf = db.Column(db.Text, nullable=True, name="MenuFilePDF")
    restaurateur_categories = db.Column(db.BigInteger, db.ForeignKey('categories."CategoryID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="Categories")
    restaurateur_preferences = db.Column(db.BigInteger, db.ForeignKey('dietarypreferences."PreferenceID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="DietaryPreferences")
    restaurateur_special_features = db.Column(db.BigInteger, db.ForeignKey('specialfeatures."FeatureID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="SpecialFeatures")
    restaurateur_pricing = db.Column(db.BigInteger, db.ForeignKey('pricing."PricingID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="Pricing")
    verified = db.Column(db.Boolean, nullable=True, default=False, name="verified")

    def __init__(self, email, phone_number, password, dining_type=None, name=None, location=None, photo=None,
                 working_hours=None, working_days=None, description=None, rating_value_average=None,
                 menu_file_pdf=None, restaurateur_categories=None, restaurateur_preferences=None,
                 restaurateur_special_features=None, restaurateur_pricing=None, verified=False):
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
        self.verified = verified

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
            restaurateur_pricing=json_data.get('Pricing'),
            verified=json_data.get('verified', False)
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
            'Pricing': self.restaurateur_pricing,
            'verified': self.verified
        }
