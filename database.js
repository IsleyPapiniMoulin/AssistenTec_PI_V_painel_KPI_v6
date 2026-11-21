const mysql = require("mysql2");

const db = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASS || "G4briel@",
  database: process.env.DB_NAME || "assistentec",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Apenas para testar uma conexão inicial
db.getConnection((err, connection) => {
  if (err) {
    console.error("❌ Erro ao conectar ao banco (POOL):", err);
  } else {
    console.log("✅ Banco de dados conectado usando POOL!");
    connection.release();
  }
});

module.exports = db;
