
const app = require('./app');
const config = require('./src/config/config');

app.listen(config.port, () => console.log(`Máy chủ chạy trên cổng ${config.port}`));