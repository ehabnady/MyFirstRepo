//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AmounCRM4
{
    using System;
    using System.Collections.Generic;
    
    public partial class Vacation
    {
        public int VacationID { get; set; }
        public Nullable<int> EmpHRCode { get; set; }
        public string EmpName { get; set; }
        public Nullable<int> EmpID { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public Nullable<int> DMHRCode { get; set; }
        public string DMName { get; set; }
        public Nullable<int> DMID { get; set; }
        public string ApprovalStatus { get; set; }
        public Nullable<System.DateTime> RequestDate { get; set; }
        public Nullable<bool> Deleted { get; set; }
        public Nullable<System.DateTime> ApprovalDate { get; set; }
        public Nullable<int> NoOfDayes { get; set; }
        public Nullable<int> CycleID { get; set; }
        public Nullable<int> VacationTypeID { get; set; }
        public string VacationType { get; set; }
    }
}
