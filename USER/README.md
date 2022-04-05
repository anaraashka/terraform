TASK
Create IAM Users in terraform under IAM directory
    variable -> dev-users = John, Tom, David, Sarah, Henry, Thomas, Freddie, Alfie, Theo
    variable -> test-users = William, Theodore, Archie, Joshua, Alexander, James, Isaac
    variable -> prod-users = Edward, Lucas, Tommy, Finley, Max, Logan, Ethan, Teddy
Create IAM Groups in terraform under IAM directory
    variable -> dev-group = development
    variable -> test-group = tester
    variable -> prod-group = production
Assign users to group
    dev-users -> dev-group
    test-users -> test-group
    prod-users -> prod-group