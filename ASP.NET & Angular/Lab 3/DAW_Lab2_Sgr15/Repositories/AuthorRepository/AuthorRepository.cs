using DAW_Lab2_Sgr15.Data;
using DAW_Lab2_Sgr15.Entities;
using DAW_Lab2_Sgr15.Repositories.GenericRepository;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Repositories.AuthorRepository
{
    public class AuthorRepository : GenericRepository<Author>, IAuthorRepository
    {
        public AuthorRepository(Lab2Context context) : base(context) { }

        public async Task<List<Author>> GetAllAuthorsWithAddress()
        {
            return await _context.Authors.Include(a => a.Address).ToListAsync();
        }

        public async Task<Author> GetByIdWithAddress(int id)
        {
            return await _context.Authors.Include(a => a.Address).Where(a => a.Id == id).FirstOrDefaultAsync();
        }

        public async Task<Author> GetByName(string name)
        {
            return await _context.Authors.Where(a => a.Name.Equals(name)).FirstOrDefaultAsync();
        }
    }
}
