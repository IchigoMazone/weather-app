
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

const getRandomInt = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
const getRandomFloat = (min, max) => (Math.random() * (max - min) + min).toFixed(1);
const getRandomElement = (array) => array[Math.floor(Math.random() * array.length)];

const generateRandomWeather = (city) => {
  const date = new Date();
  const currentDateTime = date.toISOString();
  date.setDate(date.getDate() + 5);

  const weatherData = {
    location: {
      city: city || getRandomElement([...regions.northern, ...regions.central, ...regions.southern]),
      country: 'VN',
      latitude: getRandomFloat(8, 23),
      longitude: getRandomFloat(102, 109),
    },
    currentWeather: {
      temperature: getRandomInt(20, 35),
      unit: '°C',
      humidity: getRandomInt(60, 95),
      pressure: getRandomInt(1000, 1020),
      maxTemperature: getRandomInt(25, 38),
      minTemperature: getRandomInt(18, 28),
      uvIndex: getRandomInt(4, 10),
      feelsLike: getRandomInt(18, 36),
      wind: {
        speed: getRandomFloat(2, 10),
        unit: 'm/s',
        direction: getRandomElement(['North', 'Northeast', 'East', 'Southeast', 'South', 'Southwest', 'West', 'Northwest']),
      },
      cloudCover: getRandomInt(10, 90),
      weatherDescription: getRandomElement(['Sunny', 'Cloudy', 'Rainy', 'Partly Cloudy', 'Cool', 'Warm']),
      sunrise: new Date(date.setHours(5, getRandomInt(30, 59), 0)).toISOString(),
      sunset: new Date(date.setHours(17, getRandomInt(0, 59), 0)).toISOString(),
    },
    fiveDayForecast: Array(5).fill().map((_, index) => {
      date.setDate(date.getDate() + 1);
      return {
        date: date.toISOString().split('T')[0],
        maxTemperature: getRandomInt(25, 38),
        minTemperature: getRandomInt(18, 28),
        weatherDescription: getRandomElement(['Sunny', 'Cloudy', 'Rainy', 'Partly Cloudy', 'Cool', 'Warm']),
      };
    }),
    twentyFourHourForecast: Array(24).fill().map((_, index) => {
      date.setHours(date.getHours() + 1);
      return {
        time: date.toISOString(),
        feelsLike: getRandomInt(18, 36),
      };
    }),
    dataFetchedAt: currentDateTime,
  };

  return weatherData;
};

module.exports = generateRandomWeather;