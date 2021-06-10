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
                if (!Enum.IsDefined(typeof(IntermediateComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(model.componentType), Constants.intermediateComponentTypeValidationMsg);

                //locations
                if (model.locations == null || !(model.locations >= 0 && model.locations <= 4))
                    modelState.AddModelError(nameof(model.locations), Constants.intermediateLocationValidationMsg);

                //intermediateType
                if (string.IsNullOrEmpty(model.intermediateType) || !Enum.IsDefined(typeof(IntermediateType), model.intermediateType.ToLower()))
                    modelState.AddModelError(nameof(model.intermediateType), Constants.intermediateImmediateTypeValidationMsg);

                //gearbox
                if (!string.IsNullOrEmpty(model.intermediateType) && model.intermediateType.ToLower() == IntermediateType.gearbox.ToString())
                {
                    if (model.speedChangesMax == null || !(model.speedChangesMax >= 1 && model.speedChangesMax <= 3))
                        modelState.AddModelError(nameof(model.speedChangesMax), Constants.intermediateSpeedChangesMaxValidationMsg);
                }

                //AOP
                if (!string.IsNullOrEmpty(model.intermediateType) && model.intermediateType.ToLower() == IntermediateType.aop.ToString())
                {
                    if (string.IsNullOrEmpty(model.drivenBy) || !Enum.IsDefined(typeof(IntermediateAOPDrivenBy), model.drivenBy.ToLower()))
                        modelState.AddModelError(nameof(model.drivenBy), Constants.intermediateDrivenByRequiredValidationMsg);
                }

                //AccDrGr
                if (!string.IsNullOrEmpty(model.intermediateType) && model.intermediateType.ToLower() == IntermediateType.accdrgr.ToString())
                {
                    if (string.IsNullOrEmpty(model.drivenBy) || !Enum.IsDefined(typeof(IntermediateAccDrGrDrivenBy), model.drivenBy.ToLower()))
                        modelState.AddModelError(nameof(model.drivenBy), Constants.intermediateDrivenByRequiredValidationMsg);
                }

                //componentCode
                if (model.componentCode == null)
                    modelState.AddModelError(nameof(model.componentCode), Constants.componentCodeRequiredMessage);
            }
        }
    }
}
