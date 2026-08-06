CREATE   PROCEDURE [dbo].[usp_auth_refresh_token]
(
    @refresh_token NVARCHAR(1000)
)
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------
    -- Result Set 1 : User
    --------------------------------------------------------

     SELECT
        u.id,
        u.guid,
        u.first_name              AS FirstName,
        u.last_name               AS LastName,
        u.email                   AS Email,
        u.phone_number            AS PhoneNumber,
        u.password_hash           AS PasswordHash,
        u.password_salt           AS PasswordSalt,
        u.failed_login_count      AS FailedLoginCount,
        u.lockout_end_date        AS LockoutEndDate,
        u.refresh_token_version   AS RefreshTokenVersion,
        u.email_verified          AS EmailVerified,
        u.phone_verified          AS PhoneVerified,
        u.last_login_date         AS LastLoginDate,
        u.is_active               AS IsActive,
        u.is_deleted              AS IsDeleted
    FROM refresh_tokens rt
    INNER JOIN users u
        ON rt.user_id = u.id
    WHERE
        rt.token = @refresh_token
        AND rt.is_active = 1
        AND rt.expires_date > SYSUTCDATETIME()
        AND u.is_active = 1
        AND u.is_deleted = 0;

    --------------------------------------------------------
    -- Result Set 2 : Roles
    --------------------------------------------------------

   SELECT
        r.id,
        r.guid,
        r.name                    AS Name,
        r.code                    AS Code
    FROM refresh_tokens rt
    INNER JOIN users u
        ON rt.user_id = u.id
    INNER JOIN user_roles ur
        ON u.id = ur.user_id
    INNER JOIN roles r
        ON ur.role_id = r.id
    WHERE
        rt.token = @refresh_token
        AND rt.is_active = 1
        AND ur.is_active = 1
        AND r.is_active = 1
        AND r.is_deleted = 0;

    --------------------------------------------------------
    -- Result Set 3 : Permissions
    --------------------------------------------------------

     SELECT DISTINCT
        p.id,
        p.guid,
        p.permission_key          AS PermissionKey,
        p.permission_name         AS PermissionName,
        p.module_name             AS ModuleName
    FROM refresh_tokens rt
    INNER JOIN users u
        ON rt.user_id = u.id
    INNER JOIN user_roles ur
        ON u.id = ur.user_id
    INNER JOIN role_permissions rp
        ON ur.role_id = rp.role_id
    INNER JOIN permissions p
        ON rp.permission_id = p.id
    WHERE
        rt.token = @refresh_token
        AND rt.is_active = 1
        AND rp.is_allowed = 1
        AND p.is_active = 1
        AND p.is_deleted = 0;

END