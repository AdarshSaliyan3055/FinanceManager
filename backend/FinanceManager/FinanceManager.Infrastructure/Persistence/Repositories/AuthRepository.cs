using System.Data;
using Dapper;
using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Interfaces.Repositories;
using FinanceManager.Infrastructure.Persistence.Connections;

namespace FinanceManager.Infrastructure.Persistence.Repositories;

public class AuthRepository : IAuthRepository
{
    private readonly IDbConnectionFactory _connectionFactory;

    public AuthRepository(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }


    public async Task<AuthResultModel> GetUserForLoginAsync(
        string email,
        CancellationToken cancellationToken = default)
    {
        using var connection = _connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add(
            "@email",
            email,
            DbType.String,
            ParameterDirection.Input);

        using var multi = await connection.QueryMultipleAsync(
            "usp_auth_login",
            parameters,
            commandType: CommandType.StoredProcedure);

        var user = await multi.ReadFirstOrDefaultAsync<AuthUserModel>();

        if (user == null)
        {
            return null;
        }

        var roles = (await multi.ReadAsync<AuthRoleModel>()).ToList();

        var permissions = (await multi.ReadAsync<AuthPermissionModel>()).ToList();

        return new AuthResultModel
        {
            User = user,
            Roles = roles,
            Permissions = permissions
        };
    }


    public async Task SaveRefreshTokenAsync(
    int userId,
    string token,
    DateTime expiresDate,
    CancellationToken cancellationToken = default)
    {
        using var connection = _connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add("@user_id", userId);
        parameters.Add("@token", token);
        parameters.Add("@expires_date", expiresDate);

        await connection.ExecuteAsync(
            "usp_auth_save_refresh_token",
            parameters,
            commandType: CommandType.StoredProcedure);
    }

    public async Task<AuthResultModel?> GetUserByRefreshTokenAsync(
        string refreshToken,
        CancellationToken cancellationToken = default)
    {
        using var connection = _connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add(
            "@refresh_token",
            refreshToken,
            DbType.String,
            ParameterDirection.Input);

        using var multi = await connection.QueryMultipleAsync(
            "usp_auth_refresh_token",
            parameters,
            commandType: CommandType.StoredProcedure);

        var user = await multi.ReadFirstOrDefaultAsync<AuthUserModel>();

        if (user == null)
        {
            return null;
        }

        var roles = (await multi.ReadAsync<AuthRoleModel>()).ToList();
        var permissions = (await multi.ReadAsync<AuthPermissionModel>()).ToList();

        return new AuthResultModel
        {
            User = user,
            Roles = roles,
            Permissions = permissions
        };
    }

    public async Task RevokeRefreshTokenAsync(
    string refreshToken,
    CancellationToken cancellationToken = default)
    {
        using var connection = _connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add(
            "@refresh_token",
            refreshToken,
            DbType.String,
            ParameterDirection.Input);

        await connection.ExecuteAsync(
            "usp_auth_revoke_refresh_token",
            parameters,
            commandType: CommandType.StoredProcedure);
    }
}