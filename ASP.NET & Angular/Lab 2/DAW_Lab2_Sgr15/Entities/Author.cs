using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Entities
{
    public class Author
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Address Address { get; set; }
        public ICollection<Book> Books { get; set; }
        public ICollection<AuthorResearchPaper> AuthorResearchPapers { get; set; }  

    }
}
