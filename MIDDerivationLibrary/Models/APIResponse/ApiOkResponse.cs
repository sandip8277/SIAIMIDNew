using MIDDerivationLibrary.Models.APIResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.APIResponse
{
    public class ApiOkResponse : ApiResponse
    {
        public object Result { get; }

        public ApiOkResponse(object result, string message = null)
        : base(200, message)
        {
            Result = result;
        }
    }
}
