﻿using MIDDerivationLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDCodeGenerator.Models
{
    public class MIDCodeDetails
    {
        public Codes Driver { get; set; }
        public Codes Coupling1 { get; set; }
        public Codes Intermediate { get; set; }
        public Codes Coupling2 { get; set; }
        public Codes Driven { get; set; }
        public FaultCodeMatrix FaultCodeMatrix { get; set; }
    }
}
