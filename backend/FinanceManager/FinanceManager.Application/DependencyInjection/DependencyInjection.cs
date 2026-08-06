using FinanceManager.Application.Interfaces;
using FinanceManager.Application.Interfaces.Services;
using FinanceManager.Application.Services;
using Microsoft.Extensions.DependencyInjection;

namespace FinanceManager.Application.DependencyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    {
        services.AddScoped<ICategoryService, CategoryService>();

        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IJwtService, JwtService>();

        return services;
    }
}