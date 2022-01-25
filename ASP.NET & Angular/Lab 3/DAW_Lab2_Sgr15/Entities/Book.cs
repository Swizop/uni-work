using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAW_Lab2_Sgr15.Entities
{
    public class Book
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int NumberOfPages { get; set; }
        public int AuthorId { get; set; }
        public Author Author { get; set; }

    }
}
