"""Collection of hardcoded, shared configuration variables."""
from .enums import Power

CASSANDRA_SENSOR_FIELDS = {
    "temperature": ["temperature", "temperature_refined", "temperature_raw"],
    "humidity": ["humidity", "humidity_refined", "humidity_raw"],
    "pirload": ["five_min AS pirload"],
    "pircount": ["pircount"],
    "luminosity": ["infrared_spectrum AS luminosity"],
    "co2": ["co2"],
}

PREDICTION_SETTINGS = ["power", "mode", "fan", "temperature_set"]
TEMPERATURE_SET_VALUES = list(range(18, 31))
DEFAULT_SETTINGS = {
    "temperature_set": 30,
    "mode": "off",
    "fan": "off",
    "louver": "off",
    "swing": "off",
    "power": Power.OFF,
    "ventilation": None,
}

ALL_SIGNALS = {
    "off": {DEFAULT_SETTINGS["mode"]: [DEFAULT_SETTINGS["temperature_set"]]},
    "on": {
        "cool": TEMPERATURE_SET_VALUES,
        "auto": TEMPERATURE_SET_VALUES,
        "dry": TEMPERATURE_SET_VALUES,
        "fan": TEMPERATURE_SET_VALUES,
        "heat": TEMPERATURE_SET_VALUES,
    },
}

MIN_COMFORT = -3.0
MAX_COMFORT = 3.0
