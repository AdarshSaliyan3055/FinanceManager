using FinanceManager.Application.DTOs.Auth;

namespace FinanceManager.Application.Mappings;

public static class AuthMapper
{
    public static LoginResponseDto ToLoginResponse(AuthResultModel model)
    {
        return new LoginResponseDto
        {
            User = new UserDto
            {
                Id = model.User!.Id,
                Guid = model.User.Guid,
                FirstName = model.User.FirstName,
                LastName = model.User.LastName,
                Email = model.User.Email,
                PhoneNumber = model.User.PhoneNumber,
                EmailVerified = model.User.EmailVerified,
                PhoneVerified = model.User.PhoneVerified
            },

            Roles = model.Roles
                .Select(x => new RoleDto
                {
                    Id = x.Id,
                    Guid = x.Guid,
                    Name = x.Name,
                    Code = x.Code
                })
                .ToList(),

            Permissions = model.Permissions
                .Select(x => new PermissionDto
                {
                    Id = x.Id,
                    Guid = x.Guid,
                    PermissionKey = x.PermissionKey,
                    PermissionName = x.PermissionName,
                    ModuleName = x.ModuleName
                })
                .ToList()
        };
    }
}