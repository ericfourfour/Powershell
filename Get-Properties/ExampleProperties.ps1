$Attributes = @{
    FirstName = @{
        name = "First Name";
        description = "The person's first name";
        example = "John";
    };
    LastName = @{
        name = "Last Name";
        description = "The person's last name";
        example = "Doe";
    };
    Age = @{
        name = "Age";
        description = "How old is this person?";
        example = "35";
        defaultValue = "35";
    };
    FullName = @{
        name = "Full Name";
        description = "The person's full name";
        example = "John Doe";
        defaultPattern = "{0} {1}"
    }
}

$Order = @("FirstName", "LastName", "Age", "FullName")

$Substitutions = @("FirstName", "LastName")