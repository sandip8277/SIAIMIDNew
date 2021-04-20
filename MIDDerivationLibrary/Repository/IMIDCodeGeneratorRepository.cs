﻿using MIDCodeGenerator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDCodeGenerator.Repository
{
    public interface IMIDCodeGeneratorRepository
    {
        MIDCodeDetails GenerareMIDCodes(string xml);
    }
}
