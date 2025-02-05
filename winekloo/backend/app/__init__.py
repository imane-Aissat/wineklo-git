import os
from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from supabase import create_client, Client
from app.routes.foodie_routes import foodie_bp
from datetime import datetime
from sqlalchemy import text
from app.db import db

def create_app():
    
    app = Flask(__name__)
    CORS(app)

    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres.grngcgspcdqsoainkmdh:winekloslaya@aws-0-eu-west-3.pooler.supabase.com:5432/postgres'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)



    with app.app_context():
        try:
            result = db.session.execute(text('SELECT 1')).fetchall()
            print("✅ PostgreSQL database is connected successfully:", result)
        except Exception as e:
            print("❌ Failed to connect to the PostgreSQL database:", e)

    app.register_blueprint(foodie_bp)

    return app
