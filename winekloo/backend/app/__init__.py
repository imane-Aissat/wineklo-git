import os
from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from supabase import create_client, Client
from datetime import datetime
from sqlalchemy import text
from app.db import db


from app.routes.foodie_routes import foodie_bp
from app.routes.restaurateur_routes import restaurateur_bp
from app.routes.categories_routes import categories_bp
from app.routes.dietarypreferences_routes import dietarypreferences_bp
from app.routes.menu_routes import menu_bp
from app.routes.pricing_routes import pricing_bp
from app.routes.specialfeatures_routes import specialfeatures_bp

def create_app():
    
    app = Flask(__name__)
    CORS(app)

    # Database configuration
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres.grngcgspcdqsoainkmdh:winekloslaya@aws-0-eu-west-3.pooler.supabase.com:5432/postgres'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

    # Test database connection
    with app.app_context():
        try:
            result = db.session.execute(text('SELECT 1')).fetchall()
            print("✅ PostgreSQL database is connected successfully:", result)
        except Exception as e:
            print("❌ Failed to connect to the PostgreSQL database:", e)

    # Register Blueprints
    app.register_blueprint(foodie_bp)
    app.register_blueprint(restaurateur_bp)
    app.register_blueprint(categories_bp)
    app.register_blueprint(dietarypreferences_bp)
    app.register_blueprint(menu_bp)
    app.register_blueprint(pricing_bp)
    app.register_blueprint(specialfeatures_bp)

    return app