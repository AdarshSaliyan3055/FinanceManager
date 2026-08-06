using FinanceManager.Application.DTOs.Auth;

namespace FinanceManager.Application.Interfaces.Repositories;

public interface IAuthRepository
{
    Task<AuthResultModel?> GetUserForLoginAsync(
        string email,
        CancellationToken cancellationToken = default);
    Task SaveRefreshTokenAsync(
    int userId,
    string token,
    DateTime expiresDate,
    CancellationToken cancellationToken = default);
    Task<AuthResultModel?> GetUserByRefreshTokenAsync(
    string refreshToken,
    CancellationToken cancellationToken = default);

    Task RevokeRefreshTokenAsync(
    string refreshToken,
    CancellationToken cancellationToken = default);
}