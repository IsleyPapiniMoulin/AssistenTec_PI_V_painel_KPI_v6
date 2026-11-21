-- AssistenTec - PI V
-- Novos dados objetivos para priorização automática.
-- Execute uma única vez no banco assistentec, após realizar backup.

ALTER TABLE chamado
  ADD COLUMN pessoas_afetadas INT NOT NULL DEFAULT 1,
  ADD COLUMN setores_afetados INT NOT NULL DEFAULT 1,
  ADD COLUMN alternativa_temporaria TINYINT(1) NOT NULL DEFAULT 1,
  ADD COLUMN justificativa_prioridade VARCHAR(500) NULL;

-- As colunas antigas impacto e urgencia, caso existam de uma versão anterior,
-- são mantidas para não quebrar registros antigos. A nova automação não as utiliza.
