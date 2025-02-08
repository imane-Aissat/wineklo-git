import os
from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from sqlalchemy import text
from app.db import db
from flask import request
from flask import Flask, session
from flask_session import Session


from app.routes.foodie_routes import foodie_bp
from app.routes.restaurateur_routes import restaurateur_bp
from app.routes.categories_routes import categories_bp
from app.routes.dietarypreferences_routes import dietarypreferences_bp
from app.routes.menu_routes import menu_bp
from app.routes.pricing_routes import pricing_bp
from app.routes.specialfeatures_routes import specialfeatures_bp
from app.routes.review_routes import reviews_bp

def create_app():
    
    app = Flask(__name__)
    app.secret_key = "key"
    CORS(app, supports_credentials=True)

    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres.grngcgspcdqsoainkmdh:winekloslaya@aws-0-eu-west-3.pooler.supabase.com:5432/postgres'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

    app.config["SESSION_TYPE"] = "filesystem"
    app.config["SESSION_PERMANENT"] = False
    app.config["SESSION_USE_SIGNER"] = True
    app.config['SESSION_COOKIE_NAME'] = 'session_cookie'
    app.config['SESSION_COOKIE_SECURE'] = False
    app.config["SESSION_FILE_DIR"] = "./flask_sessions"
    app.config['SECRET_KEY'] = 'key' 
    
    Session(app)

    with app.app_context():
        try:
            result = db.session.execute(text('SELECT 1')).fetchall()
            print("✅ PostgreSQL database is connected successfully:", result)
        except Exception as e:
            print("❌ Failed to connect to the PostgreSQL database:", e)

    app.register_blueprint(foodie_bp)
    app.register_blueprint(restaurateur_bp)
    app.register_blueprint(categories_bp)
    app.register_blueprint(dietarypreferences_bp)
    app.register_blueprint(menu_bp)
    app.register_blueprint(pricing_bp)
    app.register_blueprint(specialfeatures_bp)
    app.register_blueprint(reviews_bp)

    return app