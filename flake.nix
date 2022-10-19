{
  description = "Says hello to the world";

  outputs = { self, nixpkgs }: {

    packages.x86_64-darwin.hello = nixpkgs.legacyPackages.x86_64-darwin.hello;

    packages.x86_64-darwin.default = self.packages.x86_64-darwin.hello;

  };
}
