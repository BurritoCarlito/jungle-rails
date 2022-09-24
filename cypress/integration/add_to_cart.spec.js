describe("jungle App", () => {

  beforeEach(() => {
    cy.visit('http://0.0.0.0:3000/')
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("lets you add a product to the cart and checks that cart count increases by 1", () => {
    cy.get(".products article").eq(2).click();
    cy.get(".nav-link").contains("My Cart (0)").should("be.visible");
    cy.get(".btn").eq(2).click({force: true});
    cy.get(".nav-link").contains("My Cart (1)").should("be.visible");
  });
})