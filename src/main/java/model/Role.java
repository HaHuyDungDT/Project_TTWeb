package model;

public class Role {
    private String id;
    private String role_name;

    public Role() {
    }

    public Role(String id, String role_name) {
        this.id = id;
        this.role_name = role_name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id='" + id + '\'' +
                ", role_name='" + role_name + '\'' +
                '}';
    }
}
