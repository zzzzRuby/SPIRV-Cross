#version 310 es

struct Light
{
    vec3 Position;
    float Radius;

    vec4 Color;
};

layout(std140) uniform UBO
{
    mat4 uMVP;

    Light light;
};

in vec4 aVertex;
in vec3 aNormal;
out vec4 vColor;

void main()
{
    gl_Position = uMVP * aVertex;

    vColor = vec4(0.0);

    vec3 L = aVertex.xyz - light.Position;
    vColor += dot(aNormal, normalize(L)) * (clamp(1.0 - length(L) / light.Radius, 0.0, 1.0) * light.Color);
}
