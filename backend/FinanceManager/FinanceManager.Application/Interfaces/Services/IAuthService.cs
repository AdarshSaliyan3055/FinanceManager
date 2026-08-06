using FinanceManager.Application.DTOs.Auth;

namespace FinanceManager.Application.Interfaces.Services;

public interface IAuthService
{
    Task<LoginResponseDto> LoginAsync(
        LoginRequestDto request,
        CancellationToken cancellationToken = default);

    Task<LoginResponseDto> RefreshTokenAsync(
    RefreshTokenRequestDto request,
    CancellationToken cancellationToken = default);

    Task LogoutAsync(
       RefreshTokenRequestDto request,
       CancellationToken cancellationToken = default);
}