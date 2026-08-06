using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Interfaces.Repositories;
using FinanceManager.Application.Interfaces.Services;
using FinanceManager.Application.Mappings;
using System.Security.Cryptography;
using System.Text;

namespace FinanceManager.Application.Services;

public class AuthService : IAuthService
{
    private readonly IAuthRepository _authRepository;
    private readonly IJwtService _jwtService;

    public AuthService(
        IAuthRepository authRepository,
        IJwtService jwtService)
    {
        _authRepository = authRepository;
        _jwtService = jwtService;
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

        if (!VerifyPassword(
        request.Password,
        result.User.PasswordHash,
        result.User.PasswordSalt))
        {
            throw new Exception("Invalid email or password.");
        }

        var response = AuthMapper.ToLoginResponse(result);

        var jwt = _jwtService.GenerateToken(
            result.User,
            result.Roles,
            result.Permissions);

        response.AccessToken = jwt.AccessToken;
        response.ExpiresAt = jwt.ExpiresAt;

        var refreshToken = GenerateRefreshToken();

        await _authRepository.SaveRefreshTokenAsync(
            result.User.Id,
            refreshToken,
            DateTime.UtcNow.AddDays(7),
            cancellationToken);

        response.RefreshToken = refreshToken;

        return response;
    }

    private string GenerateSalt()
    {
        byte[] salt = RandomNumberGenerator.GetBytes(32);

        return Convert.ToBase64String(salt);
    }

    private string HashPassword(
        string password,
        string salt)
    {
        using var pbkdf2 = new Rfc2898DeriveBytes(
            password,
            Convert.FromBase64String(salt),
            100000,
            HashAlgorithmName.SHA256);

        return Convert.ToBase64String(
            pbkdf2.GetBytes(32));
    }

    private bool VerifyPassword(
        string password,
        string passwordHash,
        string passwordSalt)
    {
        var hashedPassword =
            HashPassword(password, passwordSalt);

        return CryptographicOperations.FixedTimeEquals(
            Convert.FromBase64String(hashedPassword),
            Convert.FromBase64String(passwordHash));
    }

    private string GenerateRefreshToken()
    {
        return Convert.ToBase64String(
            RandomNumberGenerator.GetBytes(64));
    }

    public async Task<LoginResponseDto> RefreshTokenAsync(
     RefreshTokenRequestDto request,
     CancellationToken cancellationToken = default)
    {
        var result = await _authRepository.GetUserByRefreshTokenAsync(
            request.RefreshToken,
            cancellationToken);

        if (result is null || result.User is null)
        {
            throw new Exception("Invalid refresh token.");
        }

        var jwt = _jwtService.GenerateToken(
            result.User,
            result.Roles,
            result.Permissions);

        await _authRepository.RevokeRefreshTokenAsync(
            request.RefreshToken,
            cancellationToken);

        var newRefreshToken = GenerateRefreshToken();

        await _authRepository.SaveRefreshTokenAsync(
            result.User.Id,
            newRefreshToken,
            DateTime.UtcNow.AddDays(7),
            cancellationToken);

        var response = AuthMapper.ToLoginResponse(result);

        response.AccessToken = jwt.AccessToken;
        response.RefreshToken = newRefreshToken;
        response.ExpiresAt = jwt.ExpiresAt;

        return response;
    }

    public async Task LogoutAsync(
    RefreshTokenRequestDto request,
    CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrEmpty(request.RefreshToken))
        {
            throw new Exception("Refresh token is required.");
        }


        await _authRepository.RevokeRefreshTokenAsync(
            request.RefreshToken,
            cancellationToken);
    }
}