-- =============================================
ALTER FUNCTION [dbo].[AvailableKey]
(	
	@LoginId int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT K.Id, K.Token, K.[Filename], K.DateCreated, K.TransformMethodId, K.IsValid
	FROM ActiveKey K
		LEFT OUTER JOIN UsedKey UK ON K.Id = UK.ActiveKeyId AND UK.LoginId = @LoginId
	GROUP BY K.Id, K.Token, K.[Filename], K.DateCreated, K.TransformMethodId, K.IsValid
	HAVING COUNT(UK.ActiveKeyId) = 0
)
