module.exports = {
  HOST: "172.31.31.75",
  USER: "nodeuser",
  PASSWORD: "StrongPass@123",
  DB: "nodejs_db",
  dialect: "mysql",
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  }
};
