describe("jungle app", () => {

  beforeEach(() => {
    cy.visit('http://0.0.0.0:3000/')
  });

  it("shows the home page", () => {
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });

  it("Click on 'Void Fennel' and visit it's product detail page", () => {
    cy.get(".products article").contains("Void Fennel").click()
    cy.get("h1").contains("Void Fennel").should("be.visible")

    cy.go("back")
    cy.location("pathname").should("not.include", "products")
  });

  it("Click on each product to view product details page", () => {
    cy.get(".products article").not(".soldout").each(item => {
      const title = item.find("h1 span").first().text()
      const baseURL = 'http://0.0.0.0:3000/'
      const link = item.find("a").first()

      cy.visit(baseURL + link.attr("href"))
      cy.get("h1").contains(title).should("be.visible")

      cy.go("back")
    cy.location("pathname").should("not.include", "products")
    })
  });

})