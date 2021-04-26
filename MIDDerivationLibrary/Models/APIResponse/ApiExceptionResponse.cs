using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Models.APIResponse.ApiBadRequestResponse;

namespace MIDDerivationLibrary.Models.APIResponse
{
    public class ApiExceptionResponse : ApiResponse
    {
        //public int StatusCode { get; set; }
        public object Result { get; }
        public ApiExceptionResponse() : base(500)
        {
           // StatusCode = statusCode;
            //Result = result;
        }
    }
}
