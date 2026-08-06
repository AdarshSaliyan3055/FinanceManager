using FinanceManager.Application.DTOs.Auth;
using FinanceManager.Application.Interfaces.Services;
using Microsoft.AspNetCore.Mvc;

namespace FinanceManager.API.Controllers;


[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IAuthService _authService;

    public AuthController(IAuthService authService)
    {
        _authService = authService;
    }

    [HttpPost("login")]
    [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Login(
        [FromBody] LoginRequestDto request,
        CancellationToken cancellationToken)
    {
        var response = await _authService.LoginAsync(
            request,
            cancellationToken);

        return Ok(response);
    }

    [HttpPost("logout")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Logout(
    [FromBody] RefreshTokenRequestDto request,
    CancellationToken cancellationToken)
    {
        await _authService.LogoutAsync(
            request,
            cancellationToken);


        return Ok(new
        {
            message = "Logged out successfully."
        });
    }

    [HttpPost("refresh-token")]
    [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> RefreshToken(
    [FromBody] RefreshTokenRequestDto request,
    CancellationToken cancellationToken)
    {
        var response = await _authService.RefreshTokenAsync(
            request,
            cancellationToken);

        return Ok(response);
    }
}
