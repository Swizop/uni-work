using Lab4_Auth_Sgr15.Models.Constants;
using Lab4_Auth_Sgr15.Models.DTOs;
using Lab4_Auth_Sgr15.Models.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lab4_Auth_Sgr15.Services.UserServices
{
    public class UserService : IUserService
    {
        private readonly UserManager<User> _userManager;
        
        public UserService(UserManager<User> userManager)
        {
            _userManager = userManager;
        }


        public async Task<bool> RegisterUserAsync(RegisterUserDTO dto)
        {
            var registerUser = new User();

            registerUser.Email = dto.Email;
            registerUser.FirstName = dto.FirstName;
            registerUser.LastName = dto.LastName;

            var result = await _userManager.CreateAsync(registerUser, dto.Password);

            if (result.Succeeded)
            {
                await _userManager.AddToRoleAsync(registerUser, UserRoleType.Admin);

                return true;
            }

            return false;
        }

        public async Task<string> LoginUser(LoginUserDTO dto)
        {
            return "";
        }
    }
}
