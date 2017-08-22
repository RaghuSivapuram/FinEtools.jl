module mmmvvoxelmm1
using FinEtools
using Base.Test
function test()
    V = VoxelBoxVolume(Int, 5*[5,6,7], [4.0, 4.0, 5.0])

    s1 = solidsphere((1.5, 2.0, 2.0), 1.3)
    s2 = solidsphere((1.5, 1.0, 2.0), 1.3)
    fillsolid!(V, differenceop(s1, s2), 1)

    File = "mmmvvoxelmm1.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    @test (V.data[15,13,12]==0)
    @test (V.data[15,16,15]==1)
end
end
using mmmvvoxelmm1
mmmvvoxelmm1.test()

module mmmvvoxelmm2
using FinEtools
using Base.Test
function test()
    V = VoxelBoxVolume(Int, 5*[5,6,7], [4.0, 4.0, 5.0])

    b1 = solidbox((0.0, 0.0, 0.0), (1.0, 4.0, 5.0))
    b2 = solidbox((0.0, 0.0, 0.0), (4.0, 1.0, 5.0))
    fillsolid!(V, unionop(b1, b2), 1)

    File = "mmmvvoxelmm2.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[15,13,12])")
    # println("$(V.data[1,1,12])")
    @test (V.data[15,13,12]==0)
    @test (V.data[1,1,12]==1)
end
end
using mmmvvoxelmm2
mmmvvoxelmm2.test()

module mmmvvoxelmm3
using FinEtools
using Base.Test
function test()
    V = VoxelBoxVolume(Int, 15*[5,6,7], [4.0, 4.0, 5.0])

    b1 = solidbox((0.0, 0.0, 0.0), (1.0, 4.0, 5.0))
    b2 = solidbox((0.0, 0.0, 0.0), (4.0, 1.0, 5.0))
    fillsolid!(V, unionop(b1, b2), 1)
    s2 = solidsphere((2.0, 2.0, 2.5), 1.0)
    fillsolid!(V, s2, 2)


    File = "mmmvvoxelmm3.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[15,13,12])")
    # println("$(V.data[1,1,12])")
    # @test (V.data[15,13,12]==0)
    # @test (V.data[1,1,12]==1)
end
end
using mmmvvoxelmm3
mmmvvoxelmm3.test()


module mmmvvoxelmm4
using FinEtools
using Base.Test
function test()
    V = VoxelBoxVolume(Int, 5*[5,6,7], [4.0, 4.0, 5.0])

    h1 = solidcylinder((2.0, 2.0, 2.5), (1.0, 0.0, 0.0), 0.5)
    fillsolid!(V, h1, 1)


    File = "mmmvvoxelmm4.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[15,13,12])")
    # println("$(V.data[1,15,12])")
    # println("$(V.data[13,15,20])")
    @test (V.data[15,13,12]==0)
    @test (V.data[1,15,12]==0)
    @test (V.data[13,15,20]==1)
end
end
using mmmvvoxelmm4
mmmvvoxelmm4.test()


module mmmvvoxelmm5
using FinEtools
using Base.Test
function test()
    V = VoxelBoxVolume(Int, 15*[5,6,7], [4.0, 4.0, 5.0])

    b1 = solidbox((0.0, 0.0, 0.0), (1.0, 4.0, 5.0))
    b2 = solidbox((0.0, 0.0, 0.0), (4.0, 1.0, 5.0))
    h1 = solidcylinder((2.0, 3.0, 2.5), (1.0, 0.0, 0.0), 0.5)
    fillsolid!(V, differenceop(unionop(b1, b2), h1), 1)

    s2 = solidsphere((2.0, 2.0, 2.5), 1.0)
    fillsolid!(V, s2, 2)


    File = "mmmvvoxelmm5.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[15,13,12])")
    # println("$(V.data[1,35,12])")
    # println("$(V.data[35,45,50])")
    @test (V.data[15,13,12]==1)
    @test (V.data[1,35,12]==1)
    @test (V.data[35,45,50]==2)
end
end
using mmmvvoxelmm5
mmmvvoxelmm5.test()

module mmmvvoxelmm6
using FinEtools
using Base.Test
function test()
    raw = zeros(UInt8, 13, 14, 15)
    raw[5:7, 2:13, 12:14] = 1
    V = VoxelBoxVolume(raw, [4.0, 4.0, 5.0])

    File = "mmmvvoxelmm6.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[7,13,12])")
    # println("$(V.data[1,12,12])")
    # println("$(V.data[12,10,5])")
    @test (V.data[7,13,12]==1)
    @test (V.data[1,12,12]==0)
    @test (V.data[12,10,5]==0)
end
end
using mmmvvoxelmm6
mmmvvoxelmm6.test()

module mmmvvoxelmm7
using FinEtools
using Base.Test
function test()
    raw = zeros(UInt8, 13, 14, 15)
    V = VoxelBoxVolume(raw, [4.0, 4.0, 5.0])
    fillvolume!(V, 2)
    V.data[5:7, 2:13, 12:14] = 1

    File = "mmmvvoxelmm7.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[7,13,12])")
    # println("$(V.data[1,12,12])")
    # println("$(V.data[12,10,5])")
    @test (V.data[7,13,12]==1)
    @test (V.data[1,12,12]==2)
    @test (V.data[12,10,5]==2)
end
end
using mmmvvoxelmm7
mmmvvoxelmm7.test()

module mmmvvoxelmm8
using FinEtools
using Base.Test
function test()
    raw = zeros(UInt8, 13, 14, 15)
    V = VoxelBoxVolume(raw, [4.0, 4.0, 5.0])
    V.data[5:7, 2:13, 12:14] = 1
    Vt = trim(V, 0)
    @test size(Vt) == (3, 12, 3)
    @test size(V, 3) == 15
    Vtt = trim(Vt, 0)
    @test size(Vtt) == (3, 12, 3)

    File = "mmmvvoxelmm8.vtk"
    vtkexport(File, V)
    # @async run(`"paraview.exe" $File`)
    try rm(File) catch end

    # println("$(V.data[7,13,12])")
    # println("$(V.data[1,12,12])")
    # println("$(V.data[12,10,5])")
    # @test (V.data[7,13,12]==1)
    # @test (V.data[1,12,12]==2)
    # @test (V.data[12,10,5]==2)
end
end
using mmmvvoxelmm8
mmmvvoxelmm8.test()
