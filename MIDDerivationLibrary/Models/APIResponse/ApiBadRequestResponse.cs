using Microsoft.AspNetCore.Mvc.ModelBinding;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Models.APIResponse
{
    public class ApiBadRequestResponse : ApiResponse
    {
        public object Result { get; }
        public IEnumerable<ValidationError> ValidationErrors { get; set; }
        public ApiBadRequestResponse(ModelStateDictionary modelState = null) : base(400, "Invalid input")
        {
            if (modelState.IsValid)
            {
                throw new ArgumentException("ModelState must be invalid", nameof(modelState));
            }
            ValidationErrors = modelState.Keys
            .SelectMany(key => modelState[key].Errors.Select(x => new ValidationError(key, x.ErrorMessage)))
            .ToList();
        }
        public class ValidationError
        {
            [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
            public string Field { get; }

            public string Message { get; }

            public ValidationError(string field, string message)
            {
                Field = field != string.Empty ? field : null;
                Message = message;
            }
        }
    }
}
