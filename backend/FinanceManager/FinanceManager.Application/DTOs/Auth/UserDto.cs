namespace FinanceManager.Application.DTOs.Auth;

public class UserDto
{
    public int Id { get; set; }

    public Guid Guid { get; set; }

    public string FirstName { get; set; } = string.Empty;

    public string? LastName { get; set; }

    public string Email { get; set; } = string.Empty;

    public string? PhoneNumber { get; set; }

    public bool EmailVerified { get; set; }

    public bool PhoneVerified { get; set; }
}