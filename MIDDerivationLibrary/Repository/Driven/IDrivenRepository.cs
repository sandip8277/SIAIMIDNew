﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Repository.Driven
{
    public interface IDrivenRepository
    {
        long AddOrUpdateDrivenDetails(string xml);
    }
}