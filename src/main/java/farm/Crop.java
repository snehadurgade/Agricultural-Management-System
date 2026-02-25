package farm;



public class Crop {
    private int id;
    private String name;
    private String season;
    private String startMonth;
    private String endMonth;
    private String description;
    private String imagePath;

    // Constructors
    public Crop() {
    }

    public Crop(int id, String name, String season, String startMonth, String endMonth, String description, String imagePath) {
        this.id = id;
        this.name = name;
        this.season = season;
        this.startMonth = startMonth;
        this.endMonth = endMonth;
        this.description = description;
        this.imagePath = imagePath;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getStartMonth() {
        return startMonth;
    }

    public void setStartMonth(String startMonth) {
        this.startMonth = startMonth;
    }

    public String getEndMonth() {
        return endMonth;
    }

    public void setEndMonth(String endMonth) {
        this.endMonth = endMonth;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
