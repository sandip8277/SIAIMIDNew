using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DrivenModels
{
    public class VacuumpumpTypes
    {
        public VacuumpumpCentrifugal vacuumpumpCentrifugal { get; set; }
        public VacuumpumpAxialRecip vacuumpumpAxialRecip { get; set; }
        public VacuumpumpRadialRecip vacuumpumpRadialRecip { get; set; }
        public VacuumpumpReciprocating vacuumpumpReciprocating { get; set; }
        public VacuumpumpLobed vacuumpumpLobed { get; set; }
    }
}
