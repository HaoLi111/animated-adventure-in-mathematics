using Pkg
Pkg.add("PkgTemplates")
using PkgTemplates
cd("D://")
t = Template(;
    dir="D://",
    user = "HaoLi111",
    license = "MIT",
    authors = "Hao Li",
    plugins=[
        Git(; manifest=true,
         ),
        Codecov(),
        TravisCI(; x86=true),
        Documenter{TravisCI}(),
        Coveralls(),
        AppVeyor()
    ],
)



generate("VisDyn",t)
] add https://github.com/HaoLi111/VisDyn.jl