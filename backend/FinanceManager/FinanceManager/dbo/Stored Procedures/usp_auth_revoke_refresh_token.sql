CREATE   PROCEDURE usp_auth_revoke_refresh_token
(
    @refresh_token NVARCHAR(1000)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE refresh_tokens
    SET
        revoked_date = SYSUTCDATETIME(),
        updated_date = SYSUTCDATETIME()
    WHERE token = @refresh_token
      AND revoked_date IS NULL;

END