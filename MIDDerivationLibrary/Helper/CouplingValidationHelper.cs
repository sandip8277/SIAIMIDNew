using Microsoft.AspNetCore.Mvc.ModelBinding;
using MIDDerivationLibrary.Models;
using MIDDerivationLibrary.Models.CouplingModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static MIDDerivationLibrary.Enums.Coupling1Enums;
using static MIDDerivationLibrary.Enums.Coupling2Enums;

namespace MIDDerivationLibrary.Helper
{
    public static class CouplingValidationHelper
    {
        public static void ValidateCoupling1Input(ref ModelStateDictionary modelState, ref Coupling1Details model)
        {
            //Validations for coupling1 component
            if (model != null)
            {
                //componentType
                if (string.IsNullOrEmpty(model.componentType) || !Enum.IsDefined(typeof(Coupling1ComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(Coupling1Details.componentType), Constants.coupling1ComponentTypeValidationMsg);

                //couplingPosition
                if (model.couplingPosition == null || !Enum.IsDefined(typeof(Coupling1CouplingPosition), model.couplingPosition))
                    modelState.AddModelError(nameof(Coupling1Details.couplingPosition), Constants.coupling1PositionTypeRequiredMessage);

                //couplingType
                if (model.couplingType == null || !Enum.IsDefined(typeof(Coupling1CouplingType), model.couplingType))
                    modelState.AddModelError(nameof(Coupling1Details.couplingType), Constants.coupling1CouplingTypeRequiredMessage);

                //location
                if (model.locations != null && !(model.locations >= 1 && model.locations <= 10))
                    modelState.AddModelError(nameof(Coupling1Details.locations), Constants.coupling1LocationValidationMessage);

                //componentCode
                if (model.componentCode == null)
                    modelState.AddModelError(nameof(model.componentCode), Constants.componentCodeRequiredMessage);
            }
        }

        public static void ValidateCoupling2Input(ref ModelStateDictionary modelState, ref Coupling2Details model)
        {
            //Validations for Coupling2 component
            if (model != null)
            {

                //componentType
                if (string.IsNullOrEmpty(model.componentType) || !Enum.IsDefined(typeof(Coupling2ComponentType), model.componentType.ToLower()))
                    modelState.AddModelError(nameof(Coupling2Details.componentType), Constants.coupling2ComponentTypeRequiredMsg);

                //couplingPosition
                if (model.couplingPosition == null || !Enum.IsDefined(typeof(Coupling2CouplingPosition), model.couplingPosition))
                    modelState.AddModelError(nameof(Coupling2Details.couplingPosition), Constants.coupling2PositionTypeRequiredMessage);

                //couplingType
                if (model.couplingType == null || !Enum.IsDefined(typeof(Coupling2CouplingType), model.couplingType))
                    modelState.AddModelError(nameof(Coupling2Details.couplingType), Constants.coupling2CouplingTypeRequiredMessage);

                //location
                if (model.locations != null && !(model.locations >= 1 && model.locations <= 10))
                    modelState.AddModelError(nameof(Coupling2Details.locations), Constants.coupling2LocationValidationMessage);

                //componentCode
                if (model.componentCode == null)
                    modelState.AddModelError(nameof(model.componentCode), Constants.componentCodeRequiredMessage);
            }
        }
    }
}
