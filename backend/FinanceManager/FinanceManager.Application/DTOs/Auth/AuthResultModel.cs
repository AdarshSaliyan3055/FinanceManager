using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.DTOs.Auth
{
    public class AuthResultModel
    {
        public AuthUserModel? User { get; set; }

        public List<AuthRoleModel> Roles { get; set; } = [];

        public List<AuthPermissionModel> Permissions { get; set; } = [];
    }
}
