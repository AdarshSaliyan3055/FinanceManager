using FinanceManager.Domain.Entities;

namespace FinanceManager.Domain.Interfaces;

public interface ICategoryRepository
{
    Task<List<Category>> GetAllAsync();
}