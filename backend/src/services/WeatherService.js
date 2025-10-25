
const turf = require('@turf/turf');
const fs = require('fs');
const generateRandomWeather = require('../utils/generateRandomWeather');
const config = require('../config/config');

let boundaries;
try {
  boundaries = JSON.parse(fs.readFileSync(config.geojsonPath, 'utf8'));
} catch (error) {
  boundaries = { features: [] };
}

const regions = {
  northern: [
    'Tuyen Quang', 'Lao Cai', 'Thai Nguyen', 'Phu Tho', 'Bac Ninh', 'Hung Yen',
    'Hai Phong', 'Ninh Binh', 'Ha Noi', 'Lai Chau', 'Dien Bien', 'Son La',
    'Lang Son', 'Quang Ninh', 'Cao Bang',
  ],
  central: [
    'Thanh Hoa', 'Nghe An', 'Ha Tinh', 'Quang Tri', 'Da Nang', 'Quang Ngai',
    'Gia Lai', 'Khanh Hoa', 'Lam Dong', 'Dak Lak', 'Hue',
  ],
  southern: [
    'Ho Chi Minh', 'Dong Nai', 'Tay Ninh', 'Can Tho', 'Vinh Long', 'Dong Thap',
    'Ca Mau', 'An Giang',
  ],
};

const getWeatherByCity = (city) => {
  if (!city) return null;
  const normalizedCity = city.toLowerCase().replace(/\s+/g, ' ').trim();
  const allCities = [...regions.northern, ...regions.central, ...regions.southern].map(c => c.toLowerCase().replace(/\s+/g, ' ').trim());

  const cityIndex = allCities.indexOf(normalizedCity);
  if (cityIndex === -1) {
    return null;
  }

  const originalCity = [...regions.northern, ...regions.central, ...regions.southern][cityIndex];
  return generateRandomWeather(originalCity);
};

const getWeatherByLatLon = (lat, lon) => {
  if (isNaN(lat) || isNaN(lon)) {
    return null;
  }

  const point = turf.point([parseFloat(lon), parseFloat(lat)]);
  let city = null;

  for (const feature of boundaries.features) {
    try {
      if (turf.booleanPointInPolygon(point, feature)) {
        city = feature.properties.NAME_2 || feature.properties.name_2 || feature.properties.district || null;
        break;
      }
    } catch (error) {
      continue;
    }
  }

  if (!city) {
    city = getRandomElement([...regions.northern, ...regions.central, ...regions.southern]);
  }

  return generateRandomWeather(city);
};

function getRandomElement(array) {
  return array[Math.floor(Math.random() * array.length)];
}

module.exports = { getWeatherByCity, getWeatherByLatLon };