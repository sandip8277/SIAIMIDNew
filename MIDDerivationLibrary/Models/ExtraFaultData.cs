using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models
{
    public class ExtraFaultData
    {
        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? motorbars { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? motorfanblades { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? turbineblades { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumpvanes { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumpblades { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumpthreads { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumpteeth { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? idlerthreads { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumppistons { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? compressorvanes { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? compressorpistons { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? compressorthreads { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? compressorthreads1 { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? idlerthreads1 { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? compressorthreads2 { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? idlerthreads2 { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? blowerlobes { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? idlerlobes { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? fanblades { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? generatorbars { get; set; }

        [System.Text.Json.Serialization.JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
        public int? pumplobes { get; set; }
    }
    //public class ExtraFaultDataForMotor
    //{
    //    public int? motorbars { get; set; }
    //    public int? motorfanblades { get; set; }
    //}

    //public class ExtraFaultDataForTurbine
    //{
    //    public int? turbineblades { get; set; }
    //}
    //public class ExtraFaultDataForPump
    //{
    //    public int? pumpvanes { get; set; }
    //    public int? pumpblades { get; set; }
    //    public int? pumpthreads { get; set; }
    //    public int? pumpteeth { get; set; }
    //    public int? idlerthreads { get; set; }
    //    public int? pumppistons { get; set; }
    //    //public int? compressorvanes { get; set; }
    //    //public int? compressorpistons { get; set; }
    //    //public int? compressorthreads { get; set; }
    //    //public int? compressorthreads1 { get; set; }
    //    //public int? idlerthreads1 { get; set; }
    //    //public int? compressorthreads2 { get; set; }
    //    //public int? idlerthreads2 { get; set; }
    //    //public int? blowerlobes { get; set; }
    //    //public int? idlerlobes { get; set; }
    //    //public int? fanblades { get; set; }
    //    //public int? generatorbars { get; set; }
    //    //public int? pumplobes { get; set; }
    //}

    //public class ExtraFaultDataForCompressor
    //{

    //    public int? compressorvanes { get; set; }
    //    public int? compressorpistons { get; set; }
    //    public int? compressorthreads { get; set; }
    //    public int? idlerthreads { get; set; }
    //    public int? compressorthreads1 { get; set; }
    //    public int? idlerthreads1 { get; set; }
    //    public int? compressorthreads2 { get; set; }
    //    public int? idlerthreads2 { get; set; }
    //}

    //public class ExtraFaultDataForFan_or_blower
    //{
    //    public int? blowerlobes { get; set; }
    //    public int? idlerlobes { get; set; }
    //    public int? fanblades { get; set; }
    //}

    //public class ExtraFaultDataForGenerator
    //{
    //    public int? generatorbars { get; set; }
    //}

    //public class ExtraFaultDataForVacuumPump
    //{
    //    public int? pumpvanes { get; set; }
    //    public int? pumppistons { get; set; }
    //    public int? pumplobes { get; set; }
    //    public int? idlerlobes { get; set; }
    //}
}
