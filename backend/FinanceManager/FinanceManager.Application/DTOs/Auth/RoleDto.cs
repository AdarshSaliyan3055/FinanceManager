namespace FinanceManager.Application.DTOs.Auth;

public class RoleDto
{
    public int Id { get; set; }

    public Guid Guid { get; set; }

    public string Name { get; set; } = string.Empty;

    public string Code { get; set; } = string.Empty;
}