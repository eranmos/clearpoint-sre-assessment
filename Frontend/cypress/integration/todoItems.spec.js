describe('App main page', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('User can browse to the main page', () => {
    cy.findByText('Todo List App').should('exist');    
  })

  it('User can add a new todo item', () => {
    // Arrange
    cy.findByLabelText(/Description/i).clear().type('Cypress todo item')
    
    // Act
    cy.findByRole('button', {name: 'Add Item'}).click();
    cy.findByRole('button', {name: 'Clear'}).click();

    // Assert
    cy.findByText('Cypress todo item').should('exist');    
  })

  it('User should not be able to add a duplicate todo item', () => {
    // Arrange
    cy.findByLabelText('Description').clear().type('This is a duplicate item')
    
    // Act
    cy.findByRole('button', {name: 'Add Item'}).click();
    cy.findByRole('button', {name: 'Add Item'}).click();

    // Assert
    cy.findByText('A todo item with description already exists').should('exist');    
  })

  it('User should not be able to add a todo item with no description', () => {
    // Act
    cy.findByRole('button', {name: 'Add Item'}).click();

    // Assert
    cy.findByText('Description field can not be empty').should('exist');    
  })

  it('User should be able to mark a todo item as completed', () => {
    // Arrange
    cy.findByLabelText('Description').clear().type('Cypress item to be marked as complete')
    
    // Act
    cy.findByRole('button', {name: 'Add Item'}).click();
    cy.findAllByText('Mark as completed').click({multiple: true})    
    
    // Assert
    cy.findByText('Cypress item to be marked as complete').should('not.exist');   
  })

  it('User should be able to add a completed item again', () => {
    // Arrange
    cy.findByLabelText('Description').clear().type('Cypress item to be marked as completed and added again')
    
    // Act
    cy.findByRole('button', {name: 'Add Item'}).click();
    cy.findAllByText('Mark as completed').click({multiple: true})
    cy.findByRole('button', {name: 'Add Item'}).click();
    
    // Assert
    cy.findByText('Cypress item to be marked as completed and added again').should('exist');   
  })
})
