using Microsoft.EntityFrameworkCore;
using FinanceManager.Domain.Entities;
using FinanceManager.Domain.Interfaces;
using FinanceManager.Infrastructure.Persistence.Context;

namespace FinanceManager.Infrastructure.Persistence.Repositories
{
    public class CategoryRepository : ICategoryRepository
    {

        private readonly FinanceDbContext _context;


        public CategoryRepository(FinanceDbContext context)
        {
            _context = context;
        }


        public async Task<List<Category>> GetAllAsync()
        {
            return await _context.Categories
                .Where(x => x.IsActive)
                .ToListAsync();
        }

    }
}