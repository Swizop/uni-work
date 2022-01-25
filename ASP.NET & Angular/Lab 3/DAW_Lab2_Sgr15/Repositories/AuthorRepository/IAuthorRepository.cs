using DAW_Lab2_Sgr15.Entities;
using DAW_Lab2_Sgr15.Repositories.GenericRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Repositories.AuthorRepository
{
    public interface IAuthorRepository : IGenericRepository<Author>
    {
        Task<Author> GetByName(string name);
        Task<List<Author>> GetAllAuthorsWithAddress();
        Task<Author> GetByIdWithAddress(int id);
    }
}
