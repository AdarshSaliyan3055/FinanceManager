using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Interfaces.Services;
using FinanceManager.Application.Models.Authentication;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using FinanceManager.Application.Configuration;


namespace FinanceManager.Application.Services;  

public class JwtService : IJwtService
{
    private readonly JwtSettings _jwtSettings;

    public JwtService(IOptions<JwtSettings> jwtSettings)
    {
        _jwtSettings = jwtSettings.Value;
    }

    public JwtTokenModel GenerateToken(
        AuthUserModel user,
        IEnumerable<AuthRoleModel> roles,
        IEnumerable<AuthPermissionModel> permissions)
    {
        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
            new(JwtRegisteredClaimNames.Email, user.Email),
            new("UserId", user.Id.ToString()),
            new("UserGuid", user.Guid.ToString()),
            new("FirstName", user.FirstName),
            new("LastName", user.LastName ?? string.Empty)
        };

        foreach (var role in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, role.Code));
        }

        foreach (var permission in permissions)
        {
            claims.Add(new Claim("Permission", permission.PermissionKey));
        }

        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(_jwtSettings.SecretKey));

        var credentials = new SigningCredentials(
            key,
            SecurityAlgorithms.HmacSha256);

        var expires = DateTime.UtcNow.AddMinutes(
            _jwtSettings.AccessTokenExpiryMinutes);

        var token = new JwtSecurityToken(
            issuer: _jwtSettings.Issuer,
            audience: _jwtSettings.Audience,
            claims: claims,
            expires: expires,
            signingCredentials: credentials);

        return new JwtTokenModel
        {
            AccessToken = new JwtSecurityTokenHandler().WriteToken(token),
            ExpiresAt = expires
        };
    }
}