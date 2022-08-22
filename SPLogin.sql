USE TareaProgramada1;
GO

CREATE PROCEDURE SP_Login
@Usuario varchar(16),
@Password varchar(16)
as
begin
SELECT * FROM Usuario WHERE UserName = @Usuario AND Password = @Password
end