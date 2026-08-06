using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Interfaces.Repositories;
using FinanceManager.Application.Interfaces.Services;
using FinanceManager.Application.Mappings;

namespace FinanceManager.Application.Services;

public class AuthService : IAuthService
{
    private readonly IAuthRepository _authRepository;

    public AuthService(IAuthRepository authRepository)
    {
        _authRepository = authRepository;
    }

    public async Task<LoginResponseDto> LoginAsync(
        LoginRequestDto request,
        CancellationToken cancellationToken = default)
    {
        var result = await _authRepository.GetUserForLoginAsync(
            request.Email,
            cancellationToken);

        if (result is null || result.User is null)
        {
            throw new Exception("Invalid email or password.");
        }

        // Password verification will be added here

        return AuthMapper.ToLoginResponse(result);
    }
}