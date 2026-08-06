using FinanceManager.Application.DTOs.Auth;

namespace FinanceManager.Application.Interfaces.Repositories;

public interface IAuthRepository
{
    Task<AuthResultModel?> GetUserForLoginAsync(
        string email,
        CancellationToken cancellationToken = default);
}