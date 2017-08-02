USE [IFF]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_papel_autoridades] AS
	SELECT DISTINCT dbo.slugify(VALOR) AS SLUG, VALOR AS LABEL
	FROM dbo.view_tags_subcampos AS vts
	WHERE (TAG = 700) AND (SUBCAMPO = 'e')
GO