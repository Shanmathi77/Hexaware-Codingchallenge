using PETPALS_II.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PETPALS_II.Repository
{
    internal interface IPetRepository
    {
          void AddPet(Pet pet);
            Pet GetPetById(int petId);
            List<Pet> GetAvailablePets();
            void UpdatePet(Pet pet);
            void DeletePet(int petId);
        }
    }

}
}
