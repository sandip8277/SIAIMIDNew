using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using MIDCodeGenerator.Repository;
using MIDDerivationLibrary.Business;
using MIDDerivationLibrary.Business.Coupling;
using MIDDerivationLibrary.Business.CSDMdefs;
using MIDDerivationLibrary.Business.Driven;
using MIDDerivationLibrary.Business.Driver;
using MIDDerivationLibrary.Business.Intermediate;
using MIDDerivationLibrary.Business.PickupCode;
using MIDDerivationLibrary.Business.SpecialFaultCodes;
using MIDDerivationLibrary.Repository;
using MIDDerivationLibrary.Repository.Coupling;
using MIDDerivationLibrary.Repository.CSDMdefs;
using MIDDerivationLibrary.Repository.Driven;
using MIDDerivationLibrary.Repository.Driver;
using MIDDerivationLibrary.Repository.Intermediate;
using MIDDerivationLibrary.Repository.PickupCode;
using MIDDerivationLibrary.Repository.SpecialFaultCodes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MIDDerivationLibrary
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "MIDDerivationLibrary", Version = "v1" });
            });
            services.AddTransient<IMIDCodeGeneratorService, MIDCodeGeneratorService>();
            services.AddTransient<IMIDCodeGeneratorRepository, MIDCodeGeneratorRepository>();
            services.AddTransient<IDriverService, DriverService>();
            services.AddTransient<IDrivenService, DrivenService>();
            services.AddTransient<IIntermediateService, IntermediateService>();
            services.AddTransient<IDrivenRepository, DrivenRepository>();
            services.AddTransient<IDriverRepository, DriverRepository>();
            services.AddTransient<IIntermediateRepository, IntermediateRepository>();
            services.AddTransient<ICoupling1Service, Coupling1Service>();
            services.AddTransient<ICoupling1Repository, Coupling1Repository>();
            services.AddTransient<ICoupling2Service, Coupling2Service>();
            services.AddTransient<ICoupling2Repository, Coupling2Repository>();
            services.AddTransient<ISpecialFaultCodesService, SpecialFaultCodesService>();
            services.AddTransient<ISpecialFaultCodesRepository, SpecialFaultCodesRepository>();
            services.AddTransient<ICSDMdefsService, CSDMdefsService>();
            services.AddTransient<ICSDMdefsRepository, CSDMdefsRepository>();
            services.AddTransient<IPickupCodeService, PickupCodeService>();
            services.AddTransient<IPickupCodeRepository, PickupCodeRepository>();

            services.AddSingleton(typeof(ISQLRepository), typeof(SQLRepository));

            //services.Configure<ApiBehaviorOptions>(o =>
            //{
            //    o.InvalidModelStateResponseFactory = actionContext =>
            //        new BadRequestObjectResult(actionContext.ModelState);
            //});

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options => {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = Configuration["Jwt:Issuer"],
                        ValidAudience = Configuration["Jwt:Issuer"],
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]))
                    };
                });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "MIDDerivationLibrary v1"));
            }

            app.UseHttpsRedirection();
            app.UseAuthentication();
            app.UseRouting();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
