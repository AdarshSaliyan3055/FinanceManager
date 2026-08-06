using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Models.Authentication;
using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.Interfaces.Services;

public interface IJwtService
{
    JwtTokenModel GenerateToken(
        AuthUserModel user,
        IEnumerable<AuthRoleModel> roles,
        IEnumerable<AuthPermissionModel> permissions);
}