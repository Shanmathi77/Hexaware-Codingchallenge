using PETPALS_II.Model;


namespace PETPALS_II.Repository
{
    internal interface IDonationRepository
    {
       
            void AddDonation(Donation donation);
            Donation GetDonationById(int donationId);
            List<Donation> GetAllDonations();
        }
    }

}
}
