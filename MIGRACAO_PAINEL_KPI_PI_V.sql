-- Migração do Painel de KPIs - AssistenTec / PI V
-- Execute uma única vez no banco assistentec.
-- Para chamados antigos, a abertura é aproximada para meia-noite da data já registrada.

ALTER TABLE chamado
  ADD COLUMN aberto_em DATETIME NULL,
  ADD COLUMN primeira_resposta_em DATETIME NULL,
  ADD COLUMN resolvido_em DATETIME NULL,
  ADD COLUMN kpi_tempos_validos TINYINT(1) NOT NULL DEFAULT 0;

UPDATE chamado
SET aberto_em = TIMESTAMP(data_abertura, '00:00:00')
WHERE aberto_em IS NULL AND data_abertura IS NOT NULL;

UPDATE chamado
SET resolvido_em = TIMESTAMP(data_encerramento, '00:00:00')
WHERE resolvido_em IS NULL AND data_encerramento IS NOT NULL;

CREATE TABLE IF NOT EXISTS sla_configuracao (
  prioridade VARCHAR(20) NOT NULL PRIMARY KEY,
  primeira_resposta_minutos INT NOT NULL,
  resolucao_minutos INT NOT NULL
);

INSERT INTO sla_configuracao (prioridade, primeira_resposta_minutos, resolucao_minutos)
VALUES
  ('Crítica', 15, 240),
  ('Alta', 60, 480),
  ('Média', 240, 1440),
  ('Baixa', 480, 2880)
ON DUPLICATE KEY UPDATE
  primeira_resposta_minutos = VALUES(primeira_resposta_minutos),
  resolucao_minutos = VALUES(resolucao_minutos);
