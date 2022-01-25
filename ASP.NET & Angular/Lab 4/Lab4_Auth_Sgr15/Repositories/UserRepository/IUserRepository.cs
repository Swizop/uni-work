using Lab4_Auth_Sgr15.Models.Entities;
using Lab4_Auth_Sgr15.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lab4_Auth_Sgr15.Repositories
{
    public interface IUserRepository : IGenericRepository<User>
    {
        Task<List<User>> GetAllUsers();
        Task<User> GetUserByEmail(string email);
    }
}
