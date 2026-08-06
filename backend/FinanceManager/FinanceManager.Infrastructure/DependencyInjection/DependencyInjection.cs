using FinanceManager.Application.Interfaces.Repositories;
using FinanceManager.Domain.Interfaces;
using FinanceManager.Infrastructure.Persistence.Connections;
using FinanceManager.Infrastructure.Persistence.Repositories;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace FinanceManager.Infrastructure.DependencyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        // Dapper Connection
        services.AddScoped<IDbConnectionFactory, SqlConnectionFactory>();

        // Category Repository
        services.AddScoped<ICategoryRepository, CategoryRepository>();

        // Authentication Repository
        services.AddScoped<IAuthRepository, AuthRepository>();

        return services;
    }
}