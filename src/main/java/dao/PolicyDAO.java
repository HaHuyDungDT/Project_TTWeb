package dao;
import model.Policy;
import db.JDBIConector;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class PolicyDAO implements DAOInterface<Policy>{
    @Override
    public List<Policy> selectAll() {
        List<Policy> policies = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, content, title FROM policy")
                        .mapToBean(Policy.class).stream().collect(Collectors.toList())
        ));
        return policies;
    }

    @Override
    public Policy selectById(Policy policyP) {
        Optional<Policy> policy = JDBIConector.me().withHandle((handle ->
                handle.createQuery("SELECT id, content, title FROM policy WHERE id=?")
                        .bind(0, policyP.getId())
                        .mapToBean(Policy.class).stream().findFirst()
        ));
        return policy.isEmpty() ? null : policy.get();
    }

    @Override
    public int insert(Policy policy) {
        return 0;
    }


    @Override
    public int delete(Policy policy) {
        return 0;
    }

    @Override
    public int update(Policy policy) {
        return 0;
    }

    public static void main(String[] args) {
        PolicyDAO policyDAO = new PolicyDAO();
        System.out.println(policyDAO.selectAll());

        System.out.println(policyDAO.selectById(new Policy("cs_2", null, null)));

    }


}
