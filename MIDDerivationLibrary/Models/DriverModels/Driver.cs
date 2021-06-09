﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.DriverModels
{
    public class Driver
    {
        public string componentType { get; set; }
        public int? locations { get; set; }
        public bool? driverLocationNDE { get; set; }
        public bool? driverLocationDE { get; set; }
        public int? rpm { get; set; }
        public string driverType { get; set; }
        public Drivers drivers { get; set; }
    }

    //public class Drivers
    //{
    //    public Diesel diesel { get; set; }
    //    public Motor motor { get; set; }
    //    public Turbine turbine { get; set; }
    //}

    //public class Diesel
    //{
    //    public int? cylinders { get; set; }
    //}
    //public class Motor
    //{
    //    public string motorDrive { get; set; }
    //    public bool? motorFan { get; set; }
    //    public bool? motorBallBearings { get; set; }
    //    public bool? drivenBallBearings { get; set; }
    //    public bool? drivenBalanceable { get; set; }
    //    public VFD vfd { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }

    //}
    //public class VFD
    //{
    //    public int? motorPoles { get; set; }
    //}
    //public class Turbine
    //{
    //    public bool? turbineReductionGear { get; set; }
    //    public bool? turbineRotorSupported { get; set; }
    //    public bool? turbineBallBearing { get; set; }
    //    public bool? turbineThrustBearing { get; set; }
    //    public bool? turbineThrustBearingIsBall { get; set; }
    //    public ExtraFaultData extraFaultData { get; set; }
    //}
}
