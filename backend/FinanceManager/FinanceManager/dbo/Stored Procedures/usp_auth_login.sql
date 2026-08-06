CREATE   PROCEDURE usp_auth_login
(
    @email NVARCHAR(510)
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
        u.first_name,
        u.last_name,
        u.email,
        u.phone_number,
        u.password_hash,
        u.password_salt,
        u.failed_login_count,
        u.lockout_end_date,
        u.refresh_token_version,
        u.email_verified,
        u.phone_verified,
        u.last_login_date,
        u.is_active,
        u.is_deleted
    FROM users u
    WHERE
        u.email = @email
        AND u.is_deleted = 0;

    --------------------------------------------------------
    -- Result Set 2 : Roles
    --------------------------------------------------------

    SELECT
        r.id,
        r.guid,
        r.name,
        r.code
    FROM user_roles ur
    INNER JOIN roles r
        ON ur.role_id = r.id
    INNER JOIN users u
        ON ur.user_id = u.id
    WHERE
        u.email = @email
        AND ur.is_active = 1
        AND r.is_active = 1
        AND r.is_deleted = 0;

    --------------------------------------------------------
    -- Result Set 3 : Permissions
    --------------------------------------------------------

    SELECT DISTINCT
        p.id,
        p.guid,
        p.permission_key,
        p.permission_name,
        p.module_name
    FROM user_roles ur
    INNER JOIN role_permissions rp
        ON ur.role_id = rp.role_id
    INNER JOIN permissions p
        ON rp.permission_id = p.id
    INNER JOIN users u
        ON ur.user_id = u.id
    WHERE
        u.email = @email
        AND ur.is_active = 1
        AND rp.is_allowed = 1
        AND p.is_active = 1
        AND p.is_deleted = 0;

END;