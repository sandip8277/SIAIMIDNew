using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.IntermediateModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Enums.IntermediateEnums;

namespace MIDDerivationLibrary.Helper
{
    public class IntermediateValidationHelper
    {
        public static void ValidateIntermediateInput(ref ModelStateDictionary modelState, ref IntermediateDetails model)
        {
            if (model != null)
            {
                //componentType
                if (string.IsNullOrEmpty(model.componentType) || !Enum.IsDefined(typeof(IntermediateComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(IntermediateDetails.componentType),Constants.intermediateComponentTypeValidationMsg);

                //intermediateType
                if (string.IsNullOrEmpty(model.intermediateType) || !Enum.IsDefined(typeof(IntermediateType), model.intermediateType.ToLower()))
                    modelState.AddModelError(nameof(IntermediateDetails.intermediateType), Constants.intermediateImmediateTypeValidationMsg);

                //locations
                if (model.locations == null || !(model.locations >= 1 && model.locations <= 10))
                    modelState.AddModelError(nameof(IntermediateDetails.locations),Constants.intermediateLocationValidationMsg);

                //drivenBy
                if (model.drivenBy == null || !Enum.IsDefined(typeof(IntermediateDrivenBy), model.drivenBy.ToLower()))
                    modelState.AddModelError(nameof(IntermediateDetails.drivenBy), Constants.intermediateDrivenByValidationMsg);

                //speedChangesMax
                if (model.speedChangesMax == null || !(model.speedChangesMax >= 1 && model.speedChangesMax <= 3))
                    modelState.AddModelError(nameof(IntermediateDetails.speedChangesMax),Constants.intermediateSpeedChangesMaxValidationMsg);

                //componentCode
                if (model.componentCode == null)
                    modelState.AddModelError(nameof(model.componentCode), Constants.componentCodeRequiredMessage);
            }
        }
    }
}
