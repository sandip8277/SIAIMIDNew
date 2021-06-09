using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.CodeDeconstructionModels
{
    public class VacuumpumpTypesForDeconstruction
    {
        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpCentrifugalForDeconstruction vacuumpumpCentrifugal { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpAxialRecipForDeconstruction vacuumpumpAxialRecip { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpRadialRecipForDeconstruction vacuumpumpRadialRecip { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpReciprocatingForDeconstruction vacuumpumpReciprocating { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public VacuumpumpLobedForDeconstruction vacuumpumpLobed { get; set; }
    }
}
