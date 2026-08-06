namespace FinanceManager.Application.DTOs.Auth;

public class LoginResponseDto
{
    public string AccessToken { get; set; } = string.Empty;

    public string RefreshToken { get; set; } = string.Empty;

    public DateTime ExpiresAt { get; set; }

    public UserDto User { get; set; } = new();

    public List<RoleDto> Roles { get; set; } = new();

    public List<PermissionDto> Permissions { get; set; } = new();
}