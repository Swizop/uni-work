using DAW_Lab2_Sgr15.Entities;
using DAW_Lab2_Sgr15.Entities.DTOs;
using DAW_Lab2_Sgr15.Repositories.AuthorRepository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthorController : ControllerBase
    {
        private readonly IAuthorRepository _repository;
        public AuthorController(IAuthorRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllAuthors()
        {
            var authors = await _repository.GetAllAuthorsWithAddress();

            var authorsToReturn = new List<AuthorDTO>();

            foreach (var author in authors)
            {
                authorsToReturn.Add(new AuthorDTO(author));
            }

            return Ok(authorsToReturn);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetAuthorById(int id)
        {
            var author = await _repository.GetByIdWithAddress(id);

            return Ok(new AuthorDTO(author));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAuthor(int id)
        {
            var author = await _repository.GetByIdAsync(id);

            if (author == null)
            {
                return NotFound("Author does not exist!");
            }

            _repository.Delete(author);

            await _repository.SaveAsync();

            return NoContent();
        }

        [HttpPost]
        public async Task<IActionResult> CreateAuthor(CreateAuthorDTO dto)
        {
            Author newAuthor = new Author();

            newAuthor.Name = dto.Name;
            newAuthor.Address = dto.Address;

            _repository.Create(newAuthor);

            await _repository.SaveAsync();


            return Ok(new AuthorDTO(newAuthor));
        }
    }
}
