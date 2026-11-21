const path = require("path");

const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const db = require("./database");

dotenv.config();
const app = express();
app.use(express.json());
app.use(cors());

// Importação das rotas
const clienteRoutes = require("./routes/cliente");
const chamadoRoutes = require("./routes/chamado");
const enderecoRoutes = require("./routes/endereco");
const historicoRoutes = require("./routes/historico");
const tecnicoRoutes = require("./routes/tecnico");
const relatorioRoutes = require("./routes/relatorio");
const kpiRoutes = require("./routes/kpi");

// Servir arquivos estáticos (front-end)
app.use(express.static("public"));

// 🔥 Deixar a pasta uploads acessível publicamente
app.use("/uploads", express.static(path.join(__dirname, "uploads")));


// Aplicação das rotas
app.use("/cliente", clienteRoutes);
app.use("/chamado", chamadoRoutes);
app.use("/endereco", enderecoRoutes);
app.use("/historico", historicoRoutes);
app.use("/tecnico", tecnicoRoutes);
app.use("/rat", relatorioRoutes);
app.use("/kpi", kpiRoutes);




// Rota principal
app.get("/", (req, res) => {
  res.send("Servidor AssistenTec rodando 🚀");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
 
//download do pdf
app.get("/download/rat", (req, res) => {
  const filePath = path.join(__dirname, "public", "pdf_rat", "Rat - Relatório de Atendimento Técnico.pdf");

  // Forçar exibição inline no navegador
  res.setHeader("Content-Type", "application/pdf");
  res.setHeader("Content-Disposition", 'inline; filename="RAT.pdf"');

  res.sendFile(filePath, (err) => {
    if (err) {
      console.error("Erro ao enviar PDF:", err);
      // Só envie erro simples para o cliente
      if (!res.headersSent) res.status(500).send("Erro ao abrir RAT.");
    }
  });
});


