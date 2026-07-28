using Microsoft.EntityFrameworkCore;
using FinanceManager.Domain.Entities;


namespace FinanceManager.Infrastructure.Persistence.Context;


public class FinanceDbContext : DbContext
{

    public FinanceDbContext(
        DbContextOptions<FinanceDbContext> options)
        : base(options)
    {

    }


    public DbSet<Category> Categories { get; set; }

}