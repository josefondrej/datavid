from flask import request
from flask_restx import Namespace, Resource

from common.Db import db

example_api = Namespace('example')


class CarsModel(db.Model):
    __tablename__ = 'cars'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String())

    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return f"<Car {self.name}>"


@example_api.route('/cars', methods=['POST', 'GET'])
class CarsAPI(Resource):

    def get(self):
        cars = CarsModel.query.all()
        results = [
            {
                "name": car.name
            } for car in cars]

        return {"count": len(results), "cars": results, "message": "success"}

    def post(self):
        if request.is_json:
            data = request.get_json()
            new_car = CarsModel(name=data['name'])

            db.session.add(new_car)
            db.session.commit()

            return {"message": f"car {new_car.name} has been created successfully."}
        else:
            return {"error": "The request payload is not in JSON format"}
