package model;

public class Users {
    
    private long userID;
    private String userEmail;
    private String userPass;
    private String userName;
    private boolean userRole;

    public Users() {
    }
    
    public Users(long userID, String userEmail, String userPass, String userName, boolean userRole) {
        this.userID = userID;
        this.userEmail = userEmail;
        this.userPass = userPass;
        this.userName = userName;
        this.userRole = userRole;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isUserRole() {
        return userRole;
    }

    public void setUserRole(boolean userRole) {
        this.userRole = userRole;
    }
}
