//The polarization energy of the light is calculated and then multiplied by the Fresnel reflectance to get the final reflectivity:
//Ray:Ray normalization vector
//OBJ_N:The normal of the object
//Ray_N:The ray comes from the normal of the object
//PColor:P-polarized light carried by rays
//SColor:S-polarized light carried by rays

static __forceinline__ __device__ RpRs CalculatePolarization(float3& Ray, float3& OBJ_N, float3& Ray_N, float3& PColor, float3& SColor)
{
    float3 TangentA = Normalize(cross(OBJ_N, OBJ_N + float3{ 1.2349f,2.123f,-3.4857f }));
    float3 TangentB = Normalize(cross(TangentA, OBJ_N));
    float3 P_polarization = Normalize(cross(Ray, Ray_N));
    float3 S_polarization = Normalize(cross(Ray, P_polarization));

    float PN = dot(P_polarization, OBJ_N);
    float SN = dot(S_polarization, OBJ_N);
    float3 P = PN * PN * PColor + SN * SN * SColor;

    float PTA = dot(P_polarization, TangentA);
    float PTB = dot(P_polarization, TangentB);
    float STA = dot(S_polarization, TangentA);
    float STB = dot(S_polarization, TangentB);
    float3 S = PTA * PTA * PColor + STA * STA * SColor + PTB * PTB * PColor + STB * STB * SColor;

    RpRs temp;
    temp.Rp = P;
    temp.Rs = S;
    return temp;
}




