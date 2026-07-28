using Microsoft.AspNetCore.Mvc;
using FinanceManager.Application.Interfaces;

namespace FinanceManager.API.Controllers
{
    [ApiController]
    [Route("api/categories")]
    public class CategoriesController : ControllerBase
    {

        private readonly ICategoryService _service;


        public CategoriesController(ICategoryService service)
        {
            _service = service;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var result =
            await _service.GetCategoriesAsync();


            return Ok(result);
        }

    }
}
