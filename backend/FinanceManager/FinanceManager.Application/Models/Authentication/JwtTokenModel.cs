using System;
using System.Collections.Generic;
using System.Text;

namespace FinanceManager.Application.Models.Authentication;

public class JwtTokenModel
{
    public string AccessToken { get; set; } = string.Empty;

    public DateTime ExpiresAt { get; set; }
}