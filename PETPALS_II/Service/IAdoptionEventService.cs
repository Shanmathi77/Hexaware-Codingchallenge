using PETPALS_II.Model;
using PETPALS_II.Repository;
using System;
using System.Collections.Generic;

namespace PETPALS_II.Service
{
    internal interface IAdoptionEventService
    {
        
        List<AdoptionEvent> GetAllAdoptionEvents();
        AdoptionEvent GetAdoptionEventById(int eventId);

     
        void CreateAdoptionEvent(AdoptionEvent adoptionEvent);

       
        void UpdateAdoptionEvent(AdoptionEvent adoptionEvent);

        
        void DeleteAdoptionEvent(int eventId);

       
        List<AdoptionEvent> GetAdoptionEventsByCriteria(string status, DateTime? startDate, DateTime? endDate);
    }
}
