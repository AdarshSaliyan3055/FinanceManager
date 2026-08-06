using Microsoft.EntityFrameworkCore;
using FinanceManager.Domain.Entities;
using FinanceManager.Domain.Interfaces;
namespace FinanceManager.Infrastructure.Persistence.Repositories
{
    public class CategoryRepository : ICategoryRepository
    {


        public CategoryRepository()
        {
        }


        public async Task<List<Category>> GetAllAsync()
        {
            return null;
        }

    }
}