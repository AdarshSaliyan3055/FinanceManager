using FinanceManager.Application.Interfaces;
using FinanceManager.Domain.Interfaces;
public class CategoryService : ICategoryService
{

    private readonly ICategoryRepository _repository;


    public CategoryService(ICategoryRepository repository)
    {
        _repository = repository;
    }


    public async Task<List<CategoryDto>> GetCategoriesAsync()
    {

        var categories =
        await _repository.GetAllAsync();


        return categories.Select(x => new CategoryDto
        {
            Id = x.Id,
            Name = x.Name
        }).ToList();


    }

}