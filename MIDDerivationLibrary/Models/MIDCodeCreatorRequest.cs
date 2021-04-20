using MIDDerivationLibrary.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MIDCodeGenerator.Models
{
    public class MIDCodeCreatorRequest
    {
        public MachineComponentsForMIDgeneration machineComponentsForMIDgeneration { get; set; }
    }
}
