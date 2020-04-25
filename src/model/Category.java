package model;

public class Category {

    private long categoryID;
    private String categoryName;
    private String categoryGroup;

    public Category() {
    }

    public Category(long categoryID, String categoryName, String categoryGroup) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.categoryGroup = categoryGroup;
    }

    public long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(long categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryGroup() {
        return categoryGroup;
    }

    public void setCategoryGroup(String categoryGroup) {
        this.categoryGroup = categoryGroup;
    }
}
