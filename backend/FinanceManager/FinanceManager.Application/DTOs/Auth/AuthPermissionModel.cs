using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.DTOs.Auth
{

    public class AuthPermissionModel
    {
        public int Id { get; set; }

        public Guid Guid { get; set; }

        public string PermissionKey { get; set; } = string.Empty;

        public string PermissionName { get; set; } = string.Empty;

        public string ModuleName { get; set; } = string.Empty;
    }

}
