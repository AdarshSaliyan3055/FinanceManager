CREATE   PROCEDURE usp_auth_save_refresh_token
(
    @user_id INT,
    @token NVARCHAR(1000),
    @expires_date DATETIME2
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE refresh_tokens
    SET
        updated_date = SYSUTCDATETIME(),
        updated_by = @user_id
    WHERE
        user_id = @user_id
        AND is_active = 1;

    INSERT INTO refresh_tokens
    (
        guid,
        user_id,
        token,
        expires_date,
        created_date,
        created_by
    )
    VALUES
    (
        NEWID(),
        @user_id,
        @token,
        @expires_date,
        SYSUTCDATETIME(),
        @user_id
    );

    UPDATE users
    SET
        last_login_date = SYSUTCDATETIME()
    WHERE id = @user_id;

END