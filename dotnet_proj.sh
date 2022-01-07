#!/bin/bash

dir_name=$1

makefile_mapping() {
    echo "run:"
    echo -e "\t dotnet run \n"
    echo "createapp:"
    echo -e "\t dotnet new classlib -n \$(app)"
    echo -e "\t dotnet sln ./*.sln add **/*.csproj"
}

program_file_map() {
    echo -e "using System;\n"
    echo -e "namespace $1;\n"
    echo "public class Program"
    echo -e "{"
    echo -e "\tpublic static void Main(string[] args)"
    echo -e "\t\t{"
    echo -e "\t\t\tConsole.WriteLine(\"Hello World !!!\");"
    echo -e "\t\t}"
    echo -e "}"
}

gitignore_file_mapping() {
    echo -e "# vscode config \n.vscode/\n\n# jetbrains ide configs \n.idea/\n\n# c# auto generated folders\nbin/\nobj/"
}

mkdir "$dir_name"
cd "./$dir_name" || exit
# generate console app
dotnet new console --framework net6.0

# create solusion file
dotnet new sln -n "$dir_name"

# update *.csproj file
# add sln file to *.csproj file
dotnet sln "./$dir_name.sln" add "./$dir_name.csproj"

# Generate makefile
makefile_mapping >Makefile
# Rewrite Program.cs
program_file_map "$dir_name" >Program.cs
# Generate gitignore
gitignore_file_mapping >".gitignore"
