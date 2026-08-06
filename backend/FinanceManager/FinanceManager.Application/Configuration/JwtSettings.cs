using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.Configuration;

public class JwtSettings
{
    public string SecretKey { get; set; } = string.Empty;

    public string Issuer { get; set; } = string.Empty;

    public string Audience { get; set; } = string.Empty;

    public int AccessTokenExpiryMinutes { get; set; }

    public int RefreshTokenExpiryDays { get; set; }
}