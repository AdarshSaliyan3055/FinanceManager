using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.DTOs.Auth
{

    public class AuthRoleModel
    {
        public int Id { get; set; }

        public Guid Guid { get; set; }

        public string Name { get; set; } = string.Empty;

        public string Code { get; set; } = string.Empty;
    }
}
