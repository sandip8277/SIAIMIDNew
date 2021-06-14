using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.SpecialFaultCodeModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MIDDerivationLibrary.Helper
{
    public static class SpecialFaultCodeValidationHelper
    {
        public static void ValidateSpecialFaultCodeInput(ref ModelStateDictionary modelState, ref SpecialFaultCodesDetails model)
        {
            //Validations for Special Fault Codes
            if (model != null)
            {
                //specialfaultcodetype
                if (string.IsNullOrEmpty(model.specialfaultcodetype))
                    modelState.AddModelError(nameof(SpecialFaultCodesDetails.specialfaultcodetype), Constants.specialFaultCodeTypeRequired);

                //specialmultiple
                if (model.specialmultiple == null)
                    modelState.AddModelError(nameof(SpecialFaultCodesDetails.specialmultiple), Constants.specialMultipleRequired);

                //specialcode
                if (string.IsNullOrEmpty(model.specialcode))
                    modelState.AddModelError(nameof(SpecialFaultCodesDetails.specialcode), Constants.specialCodeRequired);
            }
        }
    }
}
