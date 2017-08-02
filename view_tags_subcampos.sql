USE [IFF]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_tags_subcampos]
AS
SELECT     TOP (100) PERCENT r.ID_REGISTRO,
                          (SELECT     DESCRICAO
                            FROM          biblioteca.IDIOMAS AS i
                            WHERE      (CODIGO = rb.IDFK_IDIOMA)) AS IDIOMA, rs.ID_REGISTRO_SUBCAMPO, rt.TAG, rs.SUBCAMPO, rs.VALOR
FROM         biblioteca.REGISTRO_BIBLIOGRAFICO AS rb INNER JOIN
                      biblioteca.MIDIAS AS m ON rb.IDFK_MATERIAL = m.CODIGO INNER JOIN
                      biblioteca.REGISTRO AS r ON rb.ID_FK_REGISTRO = r.ID_REGISTRO INNER JOIN
                      biblioteca.REGISTRO_TAG AS rt ON r.ID_REGISTRO = rt.IDFK_REGISTRO INNER JOIN
                      biblioteca.REGISTRO_TAG_DADO AS rtd ON rt.ID_REGISTRO_TAG = rtd.ID_FK_REGISTRO_TAG INNER JOIN
                      biblioteca.REGISTRO_SUBCAMPO AS rs ON rtd.ID_FK_REGISTRO_TAG = rs.IDFK_REGISTRO_TAG_DADO
ORDER BY r.ID_REGISTRO

GO