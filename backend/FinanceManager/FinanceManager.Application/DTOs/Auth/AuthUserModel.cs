using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.DTOs.Auth
{

    public class AuthUserModel
    {
        public int Id { get; set; }

        public Guid Guid { get; set; }

        public string FirstName { get; set; } = string.Empty;

        public string? LastName { get; set; }

        public string Email { get; set; } = string.Empty;

        public string? PhoneNumber { get; set; }

        public string PasswordHash { get; set; } = string.Empty;

        public string PasswordSalt { get; set; } = string.Empty;

        public int FailedLoginCount { get; set; }

        public DateTime? LockoutEndDate { get; set; }

        public int RefreshTokenVersion { get; set; }

        public bool EmailVerified { get; set; }

        public bool PhoneVerified { get; set; }

        public DateTime? LastLoginDate { get; set; }

        public bool IsActive { get; set; }

        public bool IsDeleted { get; set; }
    }
}
