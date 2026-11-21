-- AssistenTec - PI V
-- Disponibilidade dos técnicos para distribuição automática.
-- Faça backup antes de executar. Execute uma única vez no banco assistentec.

ALTER TABLE tecnico
  ADD COLUMN disponivel TINYINT(1) NOT NULL DEFAULT 1;

-- Técnicos já cadastrados passam a ficar disponíveis inicialmente.
-- O gestor poderá alterar essa condição pelo painel Gerenciar Técnicos.
