
const WeatherService = require('../services/WeatherService');

const getWeatherByAddress = async (req, res) => {
  const { address, lat, lon } = req.query;

  if (!address && (!lat || !lon)) {
    return res.status(400).json({ error: 'Yêu cầu phải có tên thành phố hoặc tọa độ lat/lon' });
  }

  if (address) {
    const weather = WeatherService.getWeatherByCity(address);
    if (!weather) {
      return res.status(404).json({ error: 'Thành phố không tìm thấy' });
    }
    return res.json(weather);
  }

  const weather = WeatherService.getWeatherByLatLon(lat, lon);
  if (!weather) {
    return res.status(404).json({ error: 'Không tìm thấy thành phố cho tọa độ đã cung cấp' });
  }

  res.json(weather);
};

module.exports = { getWeatherByAddress };