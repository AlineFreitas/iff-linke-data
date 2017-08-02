USE [IFF]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_registros]
AS
SELECT     r.ID_REGISTRO, rb.IDFK_MATERIAL AS IDFK_MIDIA,
	(SELECT     TOP (1) IDIOMA
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (ID_REGISTRO = r.ID_REGISTRO)) AS IDIOMA,
	(SELECT     TOP (1) VALOR
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (TAG = 20) AND (SUBCAMPO = 'a') AND (ID_REGISTRO = r.ID_REGISTRO)) AS ISBN,
	(SELECT     VALOR
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (TAG = 22) AND (SUBCAMPO = 'a') AND (ID_REGISTRO = r.ID_REGISTRO)) AS ISSN,
	(SELECT     VALOR
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (TAG = 245) AND (SUBCAMPO = 'a') AND (ID_REGISTRO = r.ID_REGISTRO)) AS TITULO,
	(SELECT     VALOR
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (TAG = 245) AND (SUBCAMPO = 'b') AND (ID_REGISTRO = r.ID_REGISTRO)) AS SUBTITULO,
	(SELECT     VALOR
    FROM          dbo.view_tags_subcampos AS vts
    WHERE      (TAG = 250) AND (SUBCAMPO = 'a') AND (ID_REGISTRO = r.ID_REGISTRO)) AS EDICAO,
	(SELECT     IDFK_EDITORA
    FROM          biblioteca.REGISTRO_SUBCAMPO__EDITORA AS rse
    WHERE      (ID_FK_REGISTRO_SUBCAMPO =
       (SELECT     TOP (1) ID_REGISTRO_SUBCAMPO
         FROM          dbo.view_tags_subcampos AS vts
         WHERE      (TAG = 260) AND (SUBCAMPO = 'b') AND (ID_REGISTRO = r.ID_REGISTRO)))) AS IDFK_EDITORA,
	(SELECT VALOR FROM  dbo.view_tags_subcampos AS vts
    WHERE (TAG = 260) AND (SUBCAMPO = 'c') AND (ID_REGISTRO = r.ID_REGISTRO)) AS ANO

FROM biblioteca.REGISTRO AS r INNER JOIN
  biblioteca.REGISTRO_BIBLIOGRAFICO AS rb ON r.ID_REGISTRO = rb.ID_FK_REGISTRO

GO