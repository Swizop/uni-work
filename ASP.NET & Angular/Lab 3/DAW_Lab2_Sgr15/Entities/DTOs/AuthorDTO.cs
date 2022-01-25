using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Entities.DTOs
{
    public class AuthorDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Address Address { get; set; }
        public List<Book> Books { get; set; }
        public List<AuthorResearchPaper> AuthorResearchPapers { get; set; }

        public AuthorDTO(Author author)
        {
            this.Id = author.Id;
            this.Name = author.Name;
            this.Address = author.Address;
            this.Books = new List<Book>();
            this.AuthorResearchPapers = new List<AuthorResearchPaper>();
        }
    }
}
