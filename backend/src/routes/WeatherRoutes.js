
const express = require('express');
const router = express.Router();
const WeatherController = require('../controllers/WeatherController');

router.get('/address', WeatherController.getWeatherByAddress);

module.exports = router;